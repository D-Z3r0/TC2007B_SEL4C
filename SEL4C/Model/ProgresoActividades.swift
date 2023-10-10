//
//  ProgresoActividades.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 06/10/23.
//

import Foundation

struct ProgresoActividad: Codable {
    let id_progreso: Int
    let id_usuario: Int
    let actividad1: Bool
    let actividad2: Bool
    let actividad3: Bool
    let actividad4: Bool
}

typealias ProgresoActividades = ProgresoActividad

enum ProgresoActividadError: Error, LocalizedError{
    case itemNotFound
}

extension ProgresoActividad{
    static func fetchProgresoActividades(id_usuario: Int) async throws->ProgresoActividades{
        let baseString = "http://127.0.0.1:8000/api/user/progress/brief/\(id_usuario)/"
        let questionsURL = URL(string: baseString)!
        let (data, response) = try await URLSession.shared.data(from: questionsURL)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ProgresoActividadError.itemNotFound
        }
        let jsonDecoder = JSONDecoder()
        let modulos = try? jsonDecoder.decode(ProgresoActividades.self, from: data)
        return modulos!
        
    }
}

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

class UserProgressActivities {
    let baseString = "http://127.0.0.1:8000/api/user/progress/activities/"

    func putProgressForUser(idUsuario: Int, actividad1: Bool, actividad2: Bool, actividad3: Bool, actividad4: Bool) async throws -> Void {
        // Construir la URL con el ID de usuario
        let url = URL(string: "\(baseString)\(idUsuario)/")!

        // Crear la solicitud HTTP PUT
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
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


