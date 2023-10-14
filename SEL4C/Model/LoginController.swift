//
//  LoginController.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 02/10/23.
//

import Foundation

enum UserError: Error, LocalizedError{
    case itemNotFound
}
class LoginController{
    let baseString = "http://34.230.9.105:8000/api/user/login/"
    func userLogin(loginResponse:UserLogin)async throws-> [String: Any]? {
        let insertURL = URL(string: baseString)!
        var request = URLRequest(url: insertURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(loginResponse)
        let jsonString = String(data: jsonData!, encoding: .utf8)
        print(jsonString!)
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw UserError.itemNotFound}
        if let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            return jsonObject
//            print(jsonObject)
        } else {
            return nil
//            print("nada")
        }
    }
    
    func userLoginStatus(loginResponse: UserLogin) async throws -> (response: [String: Any]?, statusCode: Int) {
            let insertURL = URL(string: baseString)!
            var request = URLRequest(url: insertURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let jsonEncoder = JSONEncoder()
            let jsonData = try? jsonEncoder.encode(loginResponse)
            let jsonString = String(data: jsonData!, encoding: .utf8)
            print(jsonString!)
            request.httpBody = jsonData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw UserError.itemNotFound
            }

            let statusCode = httpResponse.statusCode

            if statusCode == 200 {
                if let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    return (jsonObject, statusCode)
                } else {
                    return (nil, statusCode)
                }
            } else {
                return (nil, statusCode)
            }
        }
    
}
