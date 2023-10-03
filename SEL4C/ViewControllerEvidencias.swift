//
//  ViewControllerEvidencias.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 24/09/23.
//

import UIKit

class ViewControllerEvidencias: UIViewController {
    
    //Valor pasado del id de la actividad y modulo seleccionado
    var show_module_results: Int = 0
    var modulo_actual_results: Int = 0
    var show_activity_module_results: Int = 0
    
    //Valores pasado de la información del modulo
    var titulo_res: String = ""
    var Instrucciones_res: String = ""
    var multimedia_res: String = ""
    
    @IBOutlet weak var view_evidenciasind: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Modulo mostrado: \(modulo_actual_results)")
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pasar a la vista de evidencias la información del modulo
        if (show_module_results == modulo_actual_results){
            let sigVista = segue.destination as? ViewControllerEvidenciasIndividual
            sigVista?.titulo_modulo_resultado = "Identificación"
            
           /* let sigVista2 = segue.destination as? ViewControllerEvidenciasIndividual
            sigVista2?.modulo_resultado = titulo_res*/
            
            /*let sigVista3 = segue.destination as? ViewControllerEvidenciasIndividual
            sigVista3?.instrucciones_actividad = Instrucciones_res*/
            
            let sigVista5 = segue.destination as? ViewControllerEvidenciasIndividual
            sigVista5?.tipo_entrega_result = multimedia_res
            
            let sigVista4 = segue.destination as? ViewControllerEvidenciasIndividual
            sigVista4?.modulo_evidencia = show_module_results
            
            let sigVista6 = segue.destination as? ViewControllerEvidenciasIndividual
            sigVista6?.actividad_modulo = show_activity_module_results
            
        }
    }

}
