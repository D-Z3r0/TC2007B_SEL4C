//
//  GradeActions.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 06/10/23.
//

import Foundation

import UIKit

struct GradeActions {
    typealias ValidateInputsHandler = () -> Void

    static func upgradeGrade(_ action: UIAction, validateInputs: @escaping ValidateInputsHandler){
//        let grade = action.title
//        gradeInputButton.setTitle(grade, for: .normal)
//        print(gradeInputButton.titleLabel!.text!)
        validateInputs()
    }

    static func createActions(validateInputs: @escaping ValidateInputsHandler) -> [UIAction] {
        let grades = ["Elige una opción","Pregrado (licenciatura, profesional, universidad, grado)", "Posgrado (maestría, doctorado)", "Educación continua"]
        return grades.map { grade in
            return UIAction(title: grade) {action in upgradeGrade(action, validateInputs: validateInputs)
            }
        }
    }
}
