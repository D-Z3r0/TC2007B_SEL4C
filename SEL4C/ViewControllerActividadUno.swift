//
//  ViewControllerActividadUno.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 20/09/23.
//

import UIKit

class ViewControllerActividadUno: UIViewController {

    @IBOutlet weak var view_actividadUno: UIView!
    
    @IBOutlet weak var btn_ev1deAct1: UIButton!
    @IBOutlet weak var btn_ev2deAct1: UIButton!
    @IBOutlet weak var btn_ev3deAct1: UIButton!
    
    var button_press: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view_actividadUno.layer.cornerRadius = 10 // You can adjust the corner radius as needed
        view_actividadUno.layer.masksToBounds = true
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
            button_press = 1
            print("El valor es 1")
        }
    
    @IBAction func btnEv2Pressed(_ sender: UIButton) {
            button_press = 2
            print("El valor es 2")
        }
    
    @IBAction func btnEv3Pressed(_ sender: UIButton) {
            button_press = 3
            print("El valor es 3")
        }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let sigVista = segue.destination as? ViewControllerEvAct1
        sigVista?.button_press_resultados = button_press
    }

}
