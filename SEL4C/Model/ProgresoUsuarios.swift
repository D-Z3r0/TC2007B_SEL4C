//
//  ProgresoUsuarios.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 06/10/23.
//

import Foundation

struct ProgresoUsuario: Codable {
    let id_progreso_usuario: Int
    let id_usuario: Int
    let id_actividad: Int
    let id_modulo: Int
    let estado_actividad: Bool
    let estado_modulo: Bool
}

typealias ProgresoUsuarios = [ProgresoUsuario]

enum ProgresoUsuarioError: Error, LocalizedError{
    case itemNotFound
}

extension ProgresoUsuario{
    
    static func fetchProgresoUsuarios(id_usuario: Int) async throws->ProgresoUsuarios{
        let baseString = "http://127.0.0.1:8000/api/user/progress/user/\(id_usuario)/"
        let questionsURL = URL(string: baseString)!
        let (data, response) = try await URLSession.shared.data(from: questionsURL)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ProgresoUsuarioError.itemNotFound
        }
        let jsonDecoder = JSONDecoder()
        let modulos = try? jsonDecoder.decode(ProgresoUsuarios.self, from: data)
        return modulos!
        
    }
}

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

enum UserProgressUpdateError: Error, LocalizedError {
    case userNotFound
    case missingActivityFields
}

class UserProgressUpdateController {
    static let shared = UserProgressUpdateController()
        
        func updateProgress(estadoActividad: Bool, estadoModulo: Bool, idUsuario: Int, idActividad: Int, idModulo: Int) {
            // Crear un diccionario con los datos a enviar
            let json: [String: Any] = [
                "estado_actividad": estadoActividad,
                "estado_modulo": estadoModulo,
                "id_usuario": idUsuario,
                "id_actividad": idActividad,
                "id_modulo": idModulo
            ]

            do {
                // Convertir el diccionario JSON en un objeto Data
                let jsonData = try JSONSerialization.data(withJSONObject: json)

                // Crear una URL para la solicitud PUT
                let url = URL(string: "http://127.0.0.1:8000/api/user/progress/user/\(idUsuario)/")!

                // Crear una solicitud URLRequest
                var request = URLRequest(url: url)
                request.httpMethod = "PUT"

                // Establecer el tipo de contenido como JSON
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")

                // Asignar los datos JSON a la solicitud
                request.httpBody = jsonData

                // Crear una sesión URLSession
                let session = URLSession.shared

                // Realizar la solicitud PUT
                let task = session.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                    } else if let data = data {
                        // Manejar la respuesta del servidor (puede ser necesario procesarla)
                        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                        if let responseJSON = responseJSON as? [String: Any] {
                            print("Respuesta del servidor: \(responseJSON)")
                        }
                    }
                }

                // Iniciar la tarea
                task.resume()

            } catch {
                print("Error al serializar los datos JSON: \(error.localizedDescription)")
            }
        }
}
