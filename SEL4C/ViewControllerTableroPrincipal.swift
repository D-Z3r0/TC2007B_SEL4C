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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view_actividades.isHidden = false
        view_evaluaciones.isHidden = true
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        // Oculta todas las vistas
        view_actividades.isHidden = true
        view_evaluaciones.isHidden = true

        // Muestra la vista correspondiente al botón presionado
        if sender.tag == 1 {
            view_actividades.isHidden = false
            label_tituloPrincipal.text = "Actividades"
        } else if sender.tag == 2 {
            view_evaluaciones.isHidden = false
            label_tituloPrincipal.text = "Evaluaciones"
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
