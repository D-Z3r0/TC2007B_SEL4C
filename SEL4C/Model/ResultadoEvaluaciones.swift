//
//  ResultadoEvaluaciones.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 04/10/23.
//

import Foundation

struct ResultadoEvaluaciones: Codable {
    let id_resultado: String
    let id_evaluacion: String
    let competencia1: String
    let competencia2: String
    let competencia3: String
    let competencia4: String
    let competencia5: String
}

typealias ResultadoIndividual = ResultadoEvaluaciones

enum ResultadoError: Error, LocalizedError {
    case itemNotFound
}

extension ResultadoEvaluaciones {
    
    static func fetchResultadoEvaluacionesDetail(idUsuario: Int) async throws -> ResultadoIndividual {
        let baseString = "http://127.0.0.1:8000/api/user/progress/initialEvaluation/\(idUsuario)/"
        let resultadosURL = URL(string: baseString)!
        let (data, response) = try await URLSession.shared.data(from: resultadosURL)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ResultadoError.itemNotFound
        }
        
        let jsonDecoder = JSONDecoder()
        let resultado = try? jsonDecoder.decode(ResultadoIndividual.self, from: data)
        
        return resultado!
    }
}

