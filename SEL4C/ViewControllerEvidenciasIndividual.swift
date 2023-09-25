//
//  ViewControllerEvidenciasIndividual.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 24/09/23.
//

import UIKit

class ViewControllerEvidenciasIndividual: UIViewController {
    
    //Valores pasado de la información del modulo
    var titulo_modulo_resultado: String = ""
    var modulo_resultado: String = ""
    var instrucciones_actividad: String = ""
    var tipo_entrega_result: String = ""
    var modulo_evidencia: Int = 0
    
    //Componente fijos con cambio de contenido
    @IBOutlet weak var titulo_evidencia: UILabel!
    @IBOutlet weak var titulo_modulo: UILabel!
    @IBOutlet weak var instrucciones: UILabel!
    
    //Componentes variantes dado el contenido
    @IBOutlet weak var entrega_video: UIView!
    @IBOutlet weak var btn_videoView: UIView!
    @IBOutlet weak var entrega_imagen: UIView!
    @IBOutlet weak var entrega_audio: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Mostrar información del modulo seleccionado
        titulo_evidencia.text = titulo_modulo_resultado
        titulo_modulo.text = modulo_resultado
        instrucciones.text = instrucciones_actividad
        print("Evidencia del modulo: \(modulo_evidencia)")
        
        //Hidden los tipos de entrega
        entrega_video.isHidden = true
        entrega_imagen.isHidden = true
        entrega_audio.isHidden = true
        
        //Mostrar espacio de entrega dado el tipo de entrega
        if tipo_entrega_result == "video"{
            entrega_video.isHidden = false
            entrega_imagen.isHidden = true
            entrega_audio.isHidden = true
        }else if tipo_entrega_result == "imagen"{
            entrega_imagen.isHidden = false
            entrega_video.isHidden = true
            entrega_audio.isHidden = true
        }else if tipo_entrega_result == "audio"{
            entrega_audio.isHidden=false
            entrega_imagen.isHidden = true
            entrega_video.isHidden = true
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
