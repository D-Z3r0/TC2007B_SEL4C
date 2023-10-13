//
//  Estadisticas.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 05/10/23.
//

import Foundation

struct Estadisticas: Codable {
    let id_estadistica: Int
    let id_usuario: Int
    let actividades: Int
    let evidencias: Int
    let progreso: Int
}

typealias EstadisticaIndividual = Estadisticas

enum EstadisticaError: Error, LocalizedError {
    case itemNotFound
}

extension Estadisticas {
    
    static func fetchEstadisticasDetail(idUsuario: Int) async throws -> Estadisticas {
        let baseString = "http://54.205.255.125:8000/api/user/progress/bars/\(idUsuario)/"
        let estadisticasURL = URL(string: baseString)!
        let (data, response) = try await URLSession.shared.data(from: estadisticasURL)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw EstadisticaError.itemNotFound
        }
        
        let jsonDecoder = JSONDecoder()
        let estadistica = try? jsonDecoder.decode(EstadisticaIndividual.self, from: data)
        
        return estadistica!
    }
}

class EstadisticasPost{
    let baseString = "http://54.205.255.125:8000/api/admin/estadisticas/create/"

    func postEstadisticasUser(idUsuario: Int, actividades: Int, evidencias: Int, progreso: Int) async throws -> Void {
        // Construir la URL con el ID de usuario
        let url = URL(string: "\(baseString)")!

        // Crear la solicitud HTTP POST
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Crear el cuerpo de la solicitud como un diccionario JSON
        let requestBody: [String: Any] = [
            "id_usuario": idUsuario,
            "actividades": actividades,
            "evidencias": evidencias,
            "progreso": progreso
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

class EstadisticasPut {
    let baseString = "http://54.205.255.125:8000/api/user/progress/bars/"

    func putEstadisticasUser(idUsuario: Int, actividades: Int, evidencias: Int, progreso: Int) async throws -> Void {
        // Construir la URL con el ID de usuario
        let url = URL(string: "\(baseString)\(idUsuario)/")!

        // Crear la solicitud HTTP PUT
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Crear el cuerpo de la solicitud como un diccionario JSON
        let requestBody: [String: Any] = [
            "actividades": actividades,
            "evidencias": evidencias,
            "progreso": progreso
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
