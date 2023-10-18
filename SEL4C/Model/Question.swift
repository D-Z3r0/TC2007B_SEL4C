//
//  Question.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 06/10/23.
//

import Foundation

struct Question:Codable{
    let id_pregunta:Int
    let contenido:String
    
}
typealias Questions = [Question]

enum QuestionError: Error, LocalizedError{
    case itemNotFound
}

extension Question{
    
    static func fetchQuestions() async throws->Questions{
        let baseString = "http://34.230.9.105:8000/api/preguntas/all/"
        let questionsURL = URL(string: baseString)!
        let (data, response) = try await URLSession.shared.data(from: questionsURL)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw QuestionError.itemNotFound
        }
        let jsonDecoder = JSONDecoder()
        let questions = try? jsonDecoder.decode(Questions.self, from: data)
        return questions!
    }
    
    static func sendQuestions(questions:[[String: Any]], evalutaion_id: Int)async throws-> Void {
        let defaults = UserDefaults.standard
        let userID = defaults.string(forKey: "ID")
        let baseString = "http:/34.230.9.105:8000/api/respuestas/\(userID!)/\(evalutaion_id)/"
        print(baseString)
        let insertURL = URL(string: baseString)!
        var request = URLRequest(url: insertURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let jsonEncoder = JSONEncoder()
//        let jsonData = try? jsonEncoder.encode(questions)
        let jsonData = try? JSONSerialization.data(withJSONObject: questions)
        let jsonString = String(data: jsonData!, encoding: .utf8)
        print(jsonString!)
        request.httpBody = jsonData
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else { throw UserError.itemNotFound}
        if let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            print(jsonObject)
        } else {
            print("nada")
        }
    }
}


// extension Question {
//     
//     static func fetchQuestions() throws -> Questions {
//         let questionsText = [
//             "Cuando algo me apasiona hago lo posible para lograr mis metas.",
//             "Cuando mi trabajo me apasiona hago lo posible por concluirlo, aunque enfrente circunstancias adversas, falta de tiempo o distractores",
//             "A pesar del rechazo o problemas, siempre busco conseguir mis objetivos",
//             "Soy tolerante ante situaciones ambiguas o que me generen incertidumbre",
//             "Tengo la capacidad de establecer una meta clara y los pasos para lograrla",
//             "Es común que logre convencer a otros sobre mis ideas y acciones",
//             "Domino diferentes formas de comunicar mis ideas: por escrito, en un video o en charlas cara a cara",
//             "Se me facilita delegar actividades a los miembros de mi equipo de acuerdo con sus perfiles",
//             "Tengo la habilidad de identificar las fortalezas y debilidades de las personas con las que trabajo",
//             "Se me facilita colaborar de manera activa en un equipo para lograr objetivos comunes",
//             "Me apasiona trabajar en favor de causas sociales",
//             "Creo que la misión de mi vida es trabajar para el cambio social y mejorar la vida de las personas",
//             "Me interesa dirigir una iniciativa con resultados favorables para la sociedad y/o el medio ambiente",
//             "Soy capaz de identificar problemas en el entorno social o ambiental para generar soluciones innovadoras",
//             "Manifiesto un compromiso por participar en aspectos sociales de mi entorno",
//             "Opino que el crecimiento económico debe ocurrir en igualdad de oportunidades y equidad para todos",
//             "Mis acciones y comportamientos se rigen por normas morales basadas en el respeto y cuidado hacia las personas y a la naturaleza",
//             "Sé cómo aplicar estrategias para crear nuevas ideas o proyectos",
//             "Sé aplicar conocimientos contables y financieros para el desarrollo de un emprendimiento",
//             "Tengo nociones sobre la logística para llevar a cabo la gestión de una organización",
//             "Sé cómo realizar un presupuesto para lograr un proyecto",
//             "Sé cómo establecer criterios de valoración y medir los resultados de impacto social",
//             "Creo que el cometer errores nos ofrece nuevas oportunidades de aprendizaje",
//             "Conozco estrategias para desarrollar un proyecto, aún con escasez de recursos",
//             /*
//             //Segunda parte forms
//             "Tengo la capacidad de encontrar asociaciones entre las variables, condiciones y restricciones en un proyecto",
//             "Identifico datos de mi disciplina y de otras áreas que contribuyen a resolver problemas",
//             "Participo en proyectos que se tienen que resolver utilizando perspectivas Inter/multidisciplinarias",
//             "Organizo información para resolver problemas",
//             "Me agrada conocer perspectivas diferentes de un problema",
//             "Me inclino por estrategias para comprender las partes y el todo de un problema",
//             "Tengo la capacidad de Identificar los componentes esenciales de un problema para formular una pregunta de investigación",
//             "Conozco la estructura y los formatos para elaborar reportes de investigación que se utilizan en mi área o disciplina",
//             "Identifico la estructura de un artículo de investigación que se maneja en mi área o disciplina",
//             "Identifico los elementos para formular una pregunta de investigación",
//             "Diseño instrumentos de investigación coherentes con el método de investigación utilizado",
//             "Formulo y pruebo hipótesis de investigación",
//             "Me inclino a usar datos científicos para analizar problemas de investigación",
//             "Tengo la capacidad para analizar críticamente problemas desde diferentes perspectivas",
//             "Identifico la fundamentación de juicios propios y ajenos para reconocer argumentos falsos",
//             "Autoevalúo  el nivel de avance y logro de mis metas para hacer los ajustes necesarios",
//             "Utilizo razonamientos basados en el conocimiento científico para emitir juicios ante un problema",
//             "Me aseguro de revisar los lineamientos éticos de los proyectos en los que participo",
//             //Pregunta 18 repetida î
//             "Aprecio críticas en el desarrollo de proyectos para mejorarlos",
//             "Conozco los criterios para determinar un problema",
//             "Tengo la capacidad de identificar las variables, de diversas disciplinas, que pueden ayudar a responder preguntas",
//             "Aplico soluciones innovadoras a diversas problemáticas",
//             "Soluciono problemas interpretando datos de diferentes disciplinas",
//             "Analizo problemas de investigación contemplando el contexto para crear soluciones",
//             "Tiendo a evaluar con sentido crítico e innovador las soluciones derivadas de un problema",
//             */
//         ]
//         
//         return questionsText.enumerated().map { (index, text) in
//             Question(id: index, text: text)
//         }
//     }
// }
