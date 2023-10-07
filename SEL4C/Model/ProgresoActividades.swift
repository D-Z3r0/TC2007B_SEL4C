//
//  ProgresoActividades.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 06/10/23.
//

import Foundation

class UserProgressActivties {
    let baseString = "http://127.0.0.1:8000/api/user/progress/activities/"

    func postProgressForUser(idUsuario: Int, actividad1: String, actividad2: String, actividad3: String, actividad4: String) async throws -> Void {
        // Construir la URL con el ID de usuario
        let url = URL(string: "\(baseString)\(idUsuario)/")!

        // Crear la solicitud HTTP POST
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Crear el cuerpo de la solicitud como un diccionario JSON
        let requestBody: [String: Any] = [
            "actividad1": actividad1,
            "actividad2": actividad2,
            "actividad3": actividad3,
            "actividad4": actividad4
        ]

        // Codificar el cuerpo de la solicitud en formato JSON
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
            request.httpBody = jsonData
        } catch {
            throw error
        }

        // Realizar la solicitud HTTP
        do {
            let (_, response) = try await URLSession.shared.data(for: request)

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                // Manejar el error de acuerdo a tu lógica de manejo de errores
                // Por ejemplo, lanzar una excepción o realizar alguna otra acción
            }
        } catch {
            throw error
        }
    }
}

enum UserProgressUpdateError: Error, LocalizedError {
    case userNotFound
    case missingActivityFields
}

class UserProgressUpdateController {
    let baseString = "http://127.0.0.1:8000/api/user/progress/activities/"

    func updateUserProgress(idUsuario: Int, activityData: [String: Any]) async throws -> Void {
        let updateURL = URL(string: "\(baseString)\(idUsuario)/")!
        var request = URLRequest(url: updateURL)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: activityData)
            request.httpBody = jsonData
            let (_, response) = try await URLSession.shared.data(for: request)

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 404 {
                    throw UserProgressUpdateError.userNotFound
                } else if httpResponse.statusCode == 400 {
                    throw UserProgressUpdateError.missingActivityFields
                } else if httpResponse.statusCode != 200 {
                    // Handle other error cases here if needed
                }
            }
        } catch {
            throw error
        }
    }
}
