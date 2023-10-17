//
//  ViewControllerEvFinal.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 27/09/23.
//

import UIKit

class ViewControllerEvFinal: UIViewController {

    @IBOutlet weak var view_evFaltante: UIView!
    @IBOutlet weak var view_evCompleta: UIView!
    var ProgresoActividades_json : ProgresoActividad?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let userID = defaults.integer(forKey: "ID")
        view_evCompleta.isHidden = true
        view_evFaltante.isHidden = true
        Task{
            do{
                ProgresoActividades_json = try await ProgresoActividad.fetchProgresoActividades(id_usuario: userID)
                if(ProgresoActividades_json?.actividad1 == false || ProgresoActividades_json?.actividad2 == false || ProgresoActividades_json?.actividad3 == false || ProgresoActividades_json?.actividad4 == false){
                    view_evFaltante.isHidden = false
                    view_evCompleta.isHidden = true
                }else{
                    view_evFaltante.isHidden = true
                    view_evCompleta.isHidden = false
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
