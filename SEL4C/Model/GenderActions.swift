//
//  GenderActions.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 06/10/23.
//

import Foundation

import UIKit

struct GenderActions {
    typealias ValidateInputsHandler = () -> Void
    
    static func upgradeGender(_ action: UIAction, validateInputs: @escaping ValidateInputsHandler) {
//        let gender = action.title
        validateInputs()
    }
    
    static func createActions(validateInputs: @escaping ValidateInputsHandler) -> [UIAction] {
        let genders = ["Elige una opción", "Masculino", "Femenino", "No binario", "Prefiero no decir"]
        return genders.map { gender in
            return UIAction(title: gender) {action in upgradeGender(action, validateInputs: validateInputs)
            }
        }
    }
}
