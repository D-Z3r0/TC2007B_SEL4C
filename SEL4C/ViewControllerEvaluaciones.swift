//
//  ViewControllerEvaluaciones.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 18/09/23.
//

import UIKit

class ViewControllerEvaluaciones: UIViewController {

    @IBOutlet weak var btn_evaluacionInicial: UIButton!
    
    @IBOutlet weak var btn_evaluacionFinal: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btn_evaluacionInicial.layer.shadowColor = UIColor.gray.cgColor // Shadow color
        btn_evaluacionInicial.layer.shadowOpacity = 0.5 // Shadow opacity
        btn_evaluacionInicial.layer.shadowOffset = CGSize(width: 0, height: 2) // Shadow offset
        btn_evaluacionInicial.layer.shadowRadius = 4 // Shadow radius
        

        btn_evaluacionFinal.layer.shadowColor = UIColor.gray.cgColor // Shadow color
        btn_evaluacionFinal.layer.shadowOpacity = 0.5 // Shadow opacity
        btn_evaluacionFinal.layer.shadowOffset = CGSize(width: 0, height: 2) // Shadow offset
        btn_evaluacionFinal.layer.shadowRadius = 4 // Shadow radius
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
