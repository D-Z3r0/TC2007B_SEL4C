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
        let baseString = "http://34.230.9.105:8000/api/user/progress/brief/\(id_usuario)/"
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
    let baseString = "http://34.230.9.105:8000/api/user/progress/activities/"

    func postProgressForUser(idUsuario: Int, actividad1: Bool, actividad2: Bool, actividad3: Bool, actividad4: Bool) async throws -> Void {
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

enum UpdateProgressError: Error {
    case networkError(Error)
    case decodingError(Error)
    case apiError(String)
}

func updateProgressActivity(idUsuario: Int, activityName: String, newValue: Bool) async throws -> ProgresoActividades {
    // Define the API endpoint URL
    let apiUrl = URL(string: "http://34.230.9.105:8000/api/user/progress/brief/\(idUsuario)/")!
    
    // Create a dictionary with the request parameters
    let requestData: [String: Any] = [
        "activity_name": activityName,
        "new_value": newValue
    ]
    
    // Serialize the request data to JSON
    let jsonData = try JSONSerialization.data(withJSONObject: requestData)
    
    // Create a URL request with the appropriate method and headers
    var request = URLRequest(url: apiUrl)
    request.httpMethod = "PUT"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData
    
    // Use URLSession's data method to send the request and handle errors
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        
        // Deserialize the response JSON into a ProgresoActividades object
        let decoder = JSONDecoder()
        let progresoActividades = try decoder.decode(ProgresoActividades.self, from: data)
        return progresoActividades
    } catch {
        throw UpdateProgressError.networkError(error)
    }
}


