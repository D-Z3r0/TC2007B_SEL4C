//
//  Modulos.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 01/10/23.
//
import Foundation

struct Modulo: Codable {
    let id_modulo: Int
    let titulo_mod:String
    let instrucciones: String
    let imagen_mod:String?
    let tipo_multimedia: String
    let id_actividad: Int
}

typealias Modulos = [Modulo]
typealias Modulo_individual = Modulo

enum ModuloError: Error, LocalizedError{
    case itemNotFound
    case decodingError
    case serverError(status: Int)
}

extension Modulo{
    
    static func fetchModulos(id_actividad: Int) async throws->Modulos{
        let baseString = "http://54.205.255.125:8000/api/admin/activity/\(id_actividad)/module/all/"
        let questionsURL = URL(string: baseString)!
        let (data, response) = try await URLSession.shared.data(from: questionsURL)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ModuloError.itemNotFound
        }
        let jsonDecoder = JSONDecoder()
        let modulos = try? jsonDecoder.decode(Modulos.self, from: data)
        return modulos!
        
    }
    
    static func fetchModulosDetail(id_actividad: Int, id_modulo: Int) async throws -> Modulo_individual{
        let baseString = "http://54.205.255.125:8000/api/admin/activity/\(id_actividad)/module/\(id_modulo)/"
        let actividadURL = URL(string: baseString)!
        let (data, response) = try await URLSession.shared.data(from: actividadURL)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ActividadError.itemNotFound
        }
        let jsonDecoder = JSONDecoder()
        let modulo = try? jsonDecoder.decode(Modulo_individual.self, from: data)
        return modulo!
    }
    
    static func fetchModulosDetailStatus(id_actividad: Int, id_modulo: Int) async throws -> (Int, Modulo_individual?) {
        let baseString = "http://54.205.255.125:8000/api/admin/activity/\(id_actividad)/module/\(id_modulo)/"
        let actividadURL = URL(string: baseString)!
        let (data, response) = try await URLSession.shared.data(from: actividadURL)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ModuloError.itemNotFound
        }
        
        let jsonDecoder = JSONDecoder()
        let modulo = try? jsonDecoder.decode(Modulo_individual.self, from: data)
        
        return (httpResponse.statusCode, modulo)
    }

}
