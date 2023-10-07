//
//  ProgresoUsuarios.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 06/10/23.
//

import Foundation

enum UserProgressError: Error, LocalizedError {
    case userNotFound
    case invalidData
}

class UserProgressController {
    let baseString = "http://127.0.0.1:8000/api/user/progress/user/"
    
        func postProgressForUser(idUsuario: Int, idActividad: Int, idModulo: Int, estadoActividad: Bool, estadoModulo: Bool) async throws -> Void {
            // Construir la URL con el ID de usuario
            let url = URL(string: "\(baseString)\(idUsuario)/")!

            // Crear la solicitud HTTP POST
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            // Crear el cuerpo de la solicitud como un diccionario JSON
            let requestBody: [String: Any] = [
                "id_usuario": idUsuario,
                "id_actividad": idActividad,
                "id_modulo": idModulo,
                "estado_actividad": estadoActividad,
                "estado_modulo": estadoModulo
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

                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 201 {
                    // Manejar el error de acuerdo a tu lógica de manejo de errores
                    // Por ejemplo, lanzar una excepción o realizar alguna otra acción
                }
            } catch {
                throw error
            }
        }
}

enum ProgressUpdateError: Error, LocalizedError {
    case userNotFound
    case missingActivityFields
}

class ProgressUpdateController {
    let baseString = "http://127.0.0.1:8000/api/user/progress/user/"

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
                    throw ProgressUpdateError.userNotFound
                } else if httpResponse.statusCode == 400 {
                    throw ProgressUpdateError.missingActivityFields
                } else if httpResponse.statusCode != 200 {
                    // Handle other error cases here if needed
                }
            }
        } catch {
            throw error
        }
    }
}
