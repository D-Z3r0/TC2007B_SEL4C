//
//  ViewControllerEvaluaciones.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 18/09/23.
//

import UIKit

class ViewControllerEvaluaciones: UIViewController {

    @IBOutlet weak var btn_evaluacionInicial: UIButton!
    
    @IBOutlet weak var label_evaluacionInicial: UILabel!
    
    @IBOutlet weak var btn_evaluacionFinal: UIButton!
    
    @IBOutlet weak var label_evaluacionFinal: UILabel!
    
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
        
        label_evaluacionInicial.layer.shadowColor = UIColor.gray.cgColor // Shadow color
        label_evaluacionInicial.layer.shadowOpacity = 0.5 // Shadow opacity
        label_evaluacionInicial.layer.shadowOffset = CGSize(width: 0, height: 2) // Shadow offset
        label_evaluacionInicial.layer.shadowRadius = 4 // Shadow radius
        let maskLayer = CAShapeLayer()
        maskLayer.frame = label_evaluacionInicial.bounds
        maskLayer.path = UIBezierPath(
                    roundedRect: label_evaluacionInicial.bounds,
                    byRoundingCorners: [.bottomLeft, .bottomRight],
                    cornerRadii: CGSize(width: 10, height: 10)
                ).cgPath

        label_evaluacionInicial.layer.mask = maskLayer
        
        label_evaluacionFinal.layer.shadowColor = UIColor.gray.cgColor // Shadow color
        label_evaluacionFinal.layer.shadowOpacity = 0.5 // Shadow opacity
        label_evaluacionFinal.layer.shadowOffset = CGSize(width: 0, height: 2) // Shadow offset
        label_evaluacionFinal.layer.shadowRadius = 4 // Shadow radius
        let maskLayer2 = CAShapeLayer()
        maskLayer2.frame = label_evaluacionFinal.bounds
        maskLayer2.path = UIBezierPath(
                    roundedRect: label_evaluacionFinal.bounds,
                    byRoundingCorners: [.bottomLeft, .bottomRight],
                    cornerRadii: CGSize(width: 10, height: 10)
                ).cgPath

        label_evaluacionFinal.layer.mask = maskLayer2
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
