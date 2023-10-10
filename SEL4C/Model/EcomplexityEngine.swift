//
//  EcomplexityEngine.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 06/10/23.
//

import Foundation

struct EcomplexityEngine{
    var questionIndex = 0
    var questions=Questions()
    mutating func initialize(q:Questions){
        questions = q
    }
    func getTextQuestion()->String{
        return questions[questionIndex].contenido
    }
    func getProgress()->Float{
        let progress = Float(questionIndex+1)/Float(questions.count)
        return progress
    }
    mutating func nextQuestion()->Bool{
        if questionIndex+1 < questions.count{
            questionIndex += 1
            return false
        }
        else{
            questionIndex=0
            return true
        }
    }
}
