//
//  SendAudio.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 03/10/23.
//

import Foundation
import UIKit
import AVFoundation

public struct MultipartRequestAudio {
    
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

extension MultipartRequestAudio {
    
    static func sendAudioEvidence(user: String, activity: String, evidenceName: String, idModulo: Int, audioData: Data) async throws -> Data {
        var multipart = MultipartRequestAudio()
        
        // Convierte el ID del módulo a una cadena y agrégalo como campo
        let idModuloString = String(idModulo)
        multipart.add(key: "id_modulo", value: idModuloString)
        
        for field in [
            "user": user,
            "activity": activity,
            "evidence_name": evidenceName
        ] {
            multipart.add(key: field.key, value: field.value)
        }
        
        // Specify the appropriate audio MIME type and file name here
        multipart.add(
            key: "archivo_res",
            fileName: evidenceName + ".mp3", // Change the file extension if needed
            fileMimeType: "audio/mp3",
            fileData: audioData
        )

        let url = URL(string: "http://127.0.0.1:8000/api/user/evidences/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(multipart.httpContentTypeHeaderValue, forHTTPHeaderField: "Content-Type")
        request.httpBody = multipart.httpBody

        let (data, response) = try await URLSession.shared.data(for: request)

        print((response as! HTTPURLResponse).statusCode)
        print(String(data: data, encoding: .utf8)!)
        return data
    }
}
