//
//  CountryActions.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 06/10/23.
//

import Foundation

import UIKit

var countries: [String] = []

struct CountryActions {
    typealias ValidateInputsHandler = () -> Void
    
    static func upgradeCountry(_ action: UIAction, validateInputs: @escaping ValidateInputsHandler) {
    //        let country = action.title
        validateInputs()
    }
    
    static func createActions(validateInputs: @escaping ValidateInputsHandler) -> [UIAction] {
        getCountries()
//        let countries = ["Elige una opción", "País 1", "País 2", "País 3"]
        return countries.map { country in
            return UIAction(title: country) {action in upgradeCountry(action, validateInputs: validateInputs)}
        }
    }
}

func getCountries(){
    for code in NSLocale.isoCountryCodes  {
        let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
        countries.append(name)
    }
}
