//
//  Users.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 02/10/23.
//

import Foundation

struct Users: Codable {
    var username: String = ""
    var email:String = ""
    var contrasena: String = ""
    var photo: String? = nil
    var grado_ac: String = ""
    var institucion: String = ""
    var genero: String = ""
    var edad: Int = 0
    var pais: String = ""
}
