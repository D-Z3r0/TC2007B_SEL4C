//
//  ViewControllerEvFinalFaltante.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 14/10/23.
//

import UIKit

class ViewControllerEvFinalFaltante: UIViewController {

    var ProgresoActividades_json : ProgresoActividad?
    @IBOutlet weak var btn_evFinal: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let userID = defaults.integer(forKey: "ID")

        Task{
            do{
                ProgresoActividades_json = try await ProgresoActividad.fetchProgresoActividades(id_usuario: userID)
                if(ProgresoActividades_json?.actividad1 == false || ProgresoActividades_json?.actividad2 == false || ProgresoActividades_json?.actividad3 == false || ProgresoActividades_json?.actividad4 == false){
                    let alertController = UIAlertController(title: "Se deben completar todas las actividades para acceder a la evaluación final.", message: nil, preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Entendido", style: .default, handler: nil))
                            present(alertController, animated: true, completion: nil)
                    btn_evFinal.isEnabled = false
                }else{
                    let alertController = UIAlertController(title: "Realice la evaluación final para medir sus subcompetencias finales.", message: nil, preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Entendido", style: .default, handler: nil))
                            present(alertController, animated: true, completion: nil)
                    btn_evFinal.isEnabled = true
                }
            }catch {
                print("Error al obtener las actividades: \(error.localizedDescription)")
            }
        }
        // Do any additional setup after loading the view.
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
