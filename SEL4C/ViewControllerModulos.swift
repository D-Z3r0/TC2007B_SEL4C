//
//  ViewControllerModulos.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 23/09/23.
//

import UIKit

class ViewControllerModulos: UIViewController {
    
    //Valor pasado del id de la actividad seleccionada
    var show_activity_results: Int = 0
    var actual_activity_results: Int = 0
    
    //Valores pasado de la información de la actividad seleccionada
    var titulo: String = ""
    var desc: String = ""
    
    //Imagen de la actividad seleccionada
    @IBOutlet weak var image_activity: UIImageView!
    
    //View de la presentación de información de la actividad seleccionada
    @IBOutlet weak var evidencias_actividad1: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Actividad mostrada: \(show_activity_results)")
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pasar a la vista de modulos la información de la actividad
        /*let sigVista = segue.destination as? ViewControllerModulosIndividual
        sigVista?.titulo_actividad_resultado = "Actividad \(show_activity_results)"*/
        
        let sigVista2 = segue.destination as? ViewControllerModulosIndividual
        sigVista2?.actividad_resultado = titulo
        
        /*let sigVista3 = segue.destination as? ViewControllerModulosIndividual
        sigVista3?.description_actividad = desc*/
        
        let sigVista4 = segue.destination as? ViewControllerModulosIndividual
        sigVista4?.activity_modules = show_activity_results
        
        let sigVista5 = segue.destination as? ViewControllerModulosIndividual
        sigVista5?.modulo_actual = actual_activity_results
    }

}
