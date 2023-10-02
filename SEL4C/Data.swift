//
//  Data.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 01/10/23.
//

import Foundation

public extension Data {

    mutating func append(
        _ string: String,
        encoding: String.Encoding = .utf8
    ) {
        guard let data = string.data(using: encoding) else {
            return
        }
        append(data)
    }
}

