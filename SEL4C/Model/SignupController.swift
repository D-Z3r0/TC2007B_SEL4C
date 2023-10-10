//
//  SignupController.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 03/10/23.
//

import Foundation

enum UserSignUpError: Error, LocalizedError{
    case itemNotFound
}
class SignupController{
    let baseString = "http://127.0.0.1:8000/api/user/signup/"
    
    func userSignup(signupResponse:Users)async throws-> [String: Any]? {
        let insertURL = URL(string: baseString)!
        var request = URLRequest(url: insertURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(signupResponse)
        let jsonString = String(data: jsonData!, encoding: .utf8)
        print(jsonString!)
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else { throw UserError.itemNotFound}
//        print(httpResponse)
        if let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            return jsonObject
//            print(jsonObject)
        } else {
            return nil
//            print("nada")
        }
    }
    
}
