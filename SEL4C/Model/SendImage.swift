//
//  SendImage.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 01/10/23.
//

import Foundation
import UIKit

public struct MultipartRequest {
    
    public let boundary: String
    
    private let separator: String = "\r\n"
    private var data: Data

    public init(boundary: String = UUID().uuidString) {
        self.boundary = boundary
        self.data = .init()
    }
    
    private mutating func appendBoundarySeparator() {
        data.append("--\(boundary)\(separator)")
    }
    
    private mutating func appendSeparator() {
        data.append(separator)
    }

    private func disposition(_ key: String) -> String {
        "Content-Disposition: form-data; name=\"\(key)\""
    }

    public mutating func add(
        key: String,
        value: String
    ) {
        appendBoundarySeparator()
        data.append(disposition(key) + separator)
        appendSeparator()
        data.append(value + separator)
    }

    public mutating func add(
        key: String,
        fileName: String,
        fileMimeType: String,
        fileData: Data
    ) {
        appendBoundarySeparator()
        data.append(disposition(key) + "; filename=\"\(fileName)\"" + separator)
        data.append("Content-Type: \(fileMimeType)" + separator + separator)
        data.append(fileData)
        appendSeparator()
    }

    public var httpContentTypeHeaderValue: String {
        "multipart/form-data; boundary=\(boundary)"
    }

    public var httpBody: Data {
        var bodyData = data
        bodyData.append("--\(boundary)--")
        return bodyData
    }
}

extension MultipartRequest {
    
    static func sendEvidence(user:String, activity:String, evidence_name:String, idModulo: Int, imagen: UIImage) async throws -> Data {
        var multipart = MultipartRequest()
        
        // Convierte el ID del módulo a una cadena y agrégalo como campo
        let idModuloString = String(idModulo)
        multipart.add(key: "id_modulo", value: idModuloString)
        
        for field in [
            "user": user,
            "activity": activity,
            "evidence_name": evidence_name
        ] {
            multipart.add(key: field.key, value: field.value)
        }
        
        multipart.add(
            key: "archivo_res",
            fileName: evidence_name+".png",
            fileMimeType: "image/png",
            fileData: imagen.pngData()!
        )

        let url = URL(string: "http://54.205.255.125:8000/api/user/evidences/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(multipart.httpContentTypeHeaderValue, forHTTPHeaderField: "Content-Type")
        request.httpBody = multipart.httpBody

        let (data, response) = try await URLSession.shared.data(for: request)

        print((response as! HTTPURLResponse).statusCode)
        print(String(data: data, encoding: .utf8)!)
        return data
    }
    
    static func sendEvidenceTest(user: String, activity: String, evidence_name: String, idModulo: Int, imagen: UIImage) async throws -> Int {
        var multipart = MultipartRequest()
        
        // Convierte el ID del módulo a una cadena y agrégalo como campo
        let idModuloString = String(idModulo)
        multipart.add(key: "id_modulo", value: idModuloString)
        
        for field in [
            "user": user,
            "activity": activity,
            "evidence_name": evidence_name
        ] {
            multipart.add(key: field.key, value: field.value)
        }
        
        multipart.add(
            key: "archivo_res",
            fileName: evidence_name + ".png",
            fileMimeType: "image/png",
            fileData: imagen.pngData()!
        )

        let url = URL(string: "http://127.0.0.1:8000/api/user/evidences/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(multipart.httpContentTypeHeaderValue, forHTTPHeaderField: "Content-Type")
        request.httpBody = multipart.httpBody

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NSError(domain: "HTTPErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Respuesta no válida del servidor"])
        }
        
        return httpResponse.statusCode
    }

}


