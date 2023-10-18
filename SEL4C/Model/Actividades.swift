//
//  Actividades.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 30/09/23.
//

import Foundation

struct Actividad: Codable {
    let id_actividad:Int
    let titulo:String
    let imagen:String?
    let descripcion: String
}

typealias Actividades = [Actividad]
typealias Actividad_individual = Actividad

enum ActividadError: Error, LocalizedError{
    case itemNotFound
    case decodingError
}

extension Actividad{
    
    static func fetchActividades() async throws->Actividades{
        let baseString = "http://34.230.9.105:8000/api/admin/activities/all/"
        let questionsURL = URL(string: baseString)!
        let (data, response) = try await URLSession.shared.data(from: questionsURL)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ActividadError.itemNotFound
        }
        let jsonDecoder = JSONDecoder()
        let actividades = try? jsonDecoder.decode(Actividades.self, from: data)
        return actividades!
        
    }
    
    static func fetchActividadesDetail(id_actividad: Int) async throws -> Actividad_individual{
        let baseString = "http://34.230.9.105:8000/api/admin/activities/\(id_actividad)/"
        let actividadURL = URL(string: baseString)!
        let (data, response) = try await URLSession.shared.data(from: actividadURL)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ActividadError.itemNotFound
        }
        let jsonDecoder = JSONDecoder()
        let actividad = try? jsonDecoder.decode(Actividad_individual.self, from: data)
        return actividad!
    }
    
    static func fetchActividadesDetailStatus(id_actividad: Int) async throws -> (statusCode: Int, actividad: Actividad_individual?) {
        let baseString = "http://34.230.9.105:8000/api/admin/activities/\(id_actividad)/"
        let actividadURL = URL(string: baseString)!
        let (data, response) = try await URLSession.shared.data(from: actividadURL)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw ActividadError.itemNotFound
        }
        
        let statusCode = httpResponse.statusCode

        if statusCode == 200 {
            let jsonDecoder = JSONDecoder()
            guard let actividad = try? jsonDecoder.decode(Actividad_individual.self, from: data) else {
                throw ActividadError.decodingError
            }
            return (statusCode, actividad)
        } else {
            return (statusCode, nil)
        }
    }
}
