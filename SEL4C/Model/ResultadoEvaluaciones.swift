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
    case decodingFailed
}

extension ResultadoEvaluaciones {
    
    static func fetchResultadoEvaluacionesDetail(idUsuario: Int) async throws -> ResultadoIndividual {
        let baseString = "http://54.205.255.125:8000/api/user/progress/initialEvaluation/\(idUsuario)/"
        let resultadosURL = URL(string: baseString)!
        let (data, response) = try await URLSession.shared.data(from: resultadosURL)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ResultadoError.itemNotFound
        }
        
        let jsonDecoder = JSONDecoder()
        let resultado = try? jsonDecoder.decode(ResultadoIndividual.self, from: data)
        
        return resultado!
    }
    
    static func fetchResultadoEvaluacionesDetailStatus(idUsuario: Int) async throws -> (statusCode: Int, resultado: ResultadoIndividual?){
        let baseString = "http://54.205.255.125:8000/api/user/progress/initialEvaluation/\(idUsuario)/"
        let resultadosURL = URL(string: baseString)!
        let (data, response) = try await URLSession.shared.data(from: resultadosURL)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ResultadoError.itemNotFound
        }
        
        if httpResponse.statusCode == 200 {
            let jsonDecoder = JSONDecoder()
            if let resultado = try? jsonDecoder.decode(ResultadoIndividual.self, from: data) {
                return (statusCode: httpResponse.statusCode, resultado: resultado)
            } else {
                throw ResultadoError.decodingFailed
            }
        } else {
            return (statusCode: httpResponse.statusCode, resultado: nil)
        }
    }
}

