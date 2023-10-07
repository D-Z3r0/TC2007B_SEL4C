//
//  DisciplineActions.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 06/10/23.
//

import Foundation

import UIKit

struct DisciplineActions {
    typealias ValidateInputsHandler = () -> Void
    static func upgradeDiscipline(_ action: UIAction, validateInputs: @escaping ValidateInputsHandler) {
    //        let country = action.title
        validateInputs()
    }
    
    static func createActions(validateInputs: @escaping ValidateInputsHandler) -> [UIAction] {
        let disciplines = ["Elige una opción", "Ingeniería y Ciencias", "Humanidades y educación", "Ciencias sociales", "Ciencias de la salud", "Arquitectura, arte y diseño", "Negocios"]
        return disciplines.map { discipline in
            return UIAction(title: discipline) {action in upgradeDiscipline(action, validateInputs: validateInputs)
            }
        }
    }
}
