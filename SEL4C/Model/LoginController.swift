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
    let baseString = "http://127.0.0.1:8000/api/user/login/"
    func userLogin(loginResponse:UserLogin)async throws->Void{
        let insertURL = URL(string: baseString)!
        var request = URLRequest(url: insertURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(loginResponse)
        let jsonString = String(data: jsonData!, encoding: .utf8)
        print(jsonString!)
        request.httpBody = jsonData
        
        let (_, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw UserError.itemNotFound}
    }
    
}
