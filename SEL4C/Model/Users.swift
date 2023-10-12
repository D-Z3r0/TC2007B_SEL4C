//
//  Users.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 02/10/23.
//

import Foundation

struct Users: Codable {
    var id_usuario: Int = 0
    var username: String = ""
    var email:String = ""
    var contrasena: String = ""
    var photo: String? = nil
    var grado_ac: String = ""
    var institucion: String = ""
    var genero: String = ""
    var edad: Int = 0
    var pais: String = ""
}

enum GetUserError: Error, LocalizedError{
    case itemNotFound
}

extension Users{
    
    static func getUser() async throws->Users{
        let defaults = UserDefaults.standard
        let userID = defaults.string(forKey: "ID")
        let baseString = "http://127.0.0.1:8000/api/user/profile/"+userID!
        print(baseString)
        let userURL = URL(string: baseString)!
        let (data, response) = try await URLSession.shared.data(from: userURL)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw GetUserError.itemNotFound
        }
        let jsonDecoder = JSONDecoder()
        let users = try? jsonDecoder.decode(Users.self, from: data)
        return users!
    }
    
    static func putUser(user:Users)async throws {
        let defaults = UserDefaults.standard
        let userID = defaults.string(forKey: "ID")
        let baseString = "http://127.0.0.1:8000/api/user/profile/"+userID!+"/"
        let insertURL = URL(string: baseString)!
        var request = URLRequest(url: insertURL)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(user)
        let jsonString = String(data: jsonData!, encoding: .utf8)
        print(jsonString!)
        request.httpBody = jsonData
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw UserError.itemNotFound}
        if let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            print(jsonObject)
        } else {
            print("nada")
        }
    }
}
