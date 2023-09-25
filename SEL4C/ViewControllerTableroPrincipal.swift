//
//  ViewControllerTableroPrincipal.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 18/09/23.
//

import UIKit

class ViewControllerTableroPrincipal: UIViewController {
    
    //Título del tablero
    @IBOutlet weak var label_tituloPrincipal: UILabel!
    
    //Vistas dentro del tablero
    @IBOutlet weak var view_evaluaciones: UIView!
    @IBOutlet weak var view_actividadesmetodologia: UIView!
    
    //Btns para vistas
    @IBOutlet weak var btn_actividades: UIButton!
    @IBOutlet weak var btn_evaluaciones: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Dejando vista de actividades como principal
        view_actividadesmetodologia.isHidden = false
        view_evaluaciones.isHidden = true
        
        //Resaltar estilo de btn seleccionado
        let bottomBorder = CALayer()
        bottomBorder.backgroundColor = UIColor.orange.cgColor
        bottomBorder.frame = CGRect(x: 0, y: btn_actividades.frame.size.height - 2, width: btn_actividades.frame.size.width, height: 2) // Ajusta el grosor según tus necesidades
        btn_actividades.layer.addSublayer(bottomBorder)
    }
    
    //Funcion para mostrar la vista correspondiente al btn seleccionado
    @IBAction func buttonPressed(_ sender: UIButton) {
        // Oculta todas las vistas de inicio
        view_actividadesmetodologia.isHidden = true
        view_evaluaciones.isHidden = true

        // Muestra la vista correspondiente al botón presionado
        if sender.tag == 1 {
            //Mostrar vista de actividades
            view_actividadesmetodologia.isHidden = false
            
            //Estableciendo titulo
            label_tituloPrincipal.text = "Actividades"
            
            //Resaltar estilo de btn seleccionado
            let bottomBorder = CALayer()
            bottomBorder.backgroundColor = UIColor.orange.cgColor
            bottomBorder.frame = CGRect(x: 0, y: btn_actividades.frame.size.height - 2, width: btn_actividades.frame.size.width, height: 2) // Ajusta el grosor según tus necesidades
            btn_actividades.layer.addSublayer(bottomBorder)
            
            //Dejar de resaltar el btn cuando se seleccionó otro
            if let sublayers = btn_evaluaciones.layer.sublayers {
                for layer in sublayers {
                    if layer.backgroundColor == UIColor.orange.cgColor {
                        layer.removeFromSuperlayer()
                    }
                }
            }
        } else if sender.tag == 2 {
            //Mostrar vista de evaluaciones
            view_evaluaciones.isHidden = false
            
            //Estableciendo titulo
            label_tituloPrincipal.text = "Evaluaciones"
            
            //Resaltar estilo de btn seleccionado
            let bottomBorder = CALayer()
            bottomBorder.backgroundColor = UIColor.orange.cgColor
            bottomBorder.frame = CGRect(x: 0, y: btn_evaluaciones.frame.size.height - 2, width: btn_evaluaciones.frame.size.width, height: 2) // Ajusta el grosor según tus necesidades
            btn_evaluaciones.layer.addSublayer(bottomBorder)
            
            //Dejar de resaltar el btn cuando se seleccionó otro
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
