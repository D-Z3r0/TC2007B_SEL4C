//
//  ViewControllerTableroPrincipal.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 18/09/23.
//

import UIKit

class ViewControllerTableroPrincipal: UIViewController {
    
    @IBOutlet weak var label_tituloPrincipal: UILabel!
    
    @IBOutlet weak var view_actividades: UIView!
    
    @IBOutlet weak var view_evaluaciones: UIView!
    
    @IBOutlet weak var view_actividadesmetodologia: UIView!
    
    @IBOutlet weak var btn_actividades: UIButton!
    
    @IBOutlet weak var btn_evaluaciones: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view_actividadesmetodologia.isHidden = false
        view_evaluaciones.isHidden = true
        let bottomBorder = CALayer()
        bottomBorder.backgroundColor = UIColor.orange.cgColor // Cambia el color a naranja o el que desees
        bottomBorder.frame = CGRect(x: 0, y: btn_actividades.frame.size.height - 2, width: btn_actividades.frame.size.width, height: 2) // Ajusta el grosor según tus necesidades
        btn_actividades.layer.addSublayer(bottomBorder)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        // Oculta todas las vistas
        view_actividadesmetodologia.isHidden = true
        view_evaluaciones.isHidden = true

        // Muestra la vista correspondiente al botón presionado
        if sender.tag == 1 {
            view_actividadesmetodologia.isHidden = false
            label_tituloPrincipal.text = "Actividades"
            let bottomBorder = CALayer()
            bottomBorder.backgroundColor = UIColor.orange.cgColor // Cambia el color a naranja o el que desees
            bottomBorder.frame = CGRect(x: 0, y: btn_actividades.frame.size.height - 2, width: btn_actividades.frame.size.width, height: 2) // Ajusta el grosor según tus necesidades
            btn_actividades.layer.addSublayer(bottomBorder)
            
            if let sublayers = btn_evaluaciones.layer.sublayers {
                            for layer in sublayers {
                                if layer.backgroundColor == UIColor.orange.cgColor {
                                    layer.removeFromSuperlayer()
                                }
                            }
                        }
        } else if sender.tag == 2 {
            view_evaluaciones.isHidden = false
            label_tituloPrincipal.text = "Evaluaciones"
            
            let bottomBorder = CALayer()
            bottomBorder.backgroundColor = UIColor.orange.cgColor // Cambia el color a naranja o el que desees
            bottomBorder.frame = CGRect(x: 0, y: btn_evaluaciones.frame.size.height - 2, width: btn_evaluaciones.frame.size.width, height: 2) // Ajusta el grosor según tus necesidades
            btn_evaluaciones.layer.addSublayer(bottomBorder)
            
            if let sublayers = btn_actividades.layer.sublayers {
                            for layer in sublayers {
                                if layer.backgroundColor == UIColor.orange.cgColor {
                                    layer.removeFromSuperlayer()
                                }
                            }
                        }
        }
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
