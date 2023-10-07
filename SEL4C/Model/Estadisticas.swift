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
        let baseString = "http://127.0.0.1:8000/api/user/progress/bars/\(idUsuario)/"
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
