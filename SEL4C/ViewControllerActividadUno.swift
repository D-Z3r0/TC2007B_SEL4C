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
    
    @IBOutlet weak var label_btnev1Act1: UILabel!
    @IBOutlet weak var label_btnev2Act1: UILabel!
    @IBOutlet weak var label_btnev3Act1: UILabel!
    
    @IBOutlet weak var view_btnev1Act1: UIView!
    
    var button_press: Int = 0
    
    let customBlueColor = UIColor(red: 0.0 / 255.0, green: 48.0 / 255.0, blue: 135.0 / 255.0, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view_actividadUno.layer.cornerRadius = 10 // You can adjust the corner radius as needed
        view_actividadUno.layer.masksToBounds = true
        
        configureButton(btn_ev1deAct1)
        configureButton(btn_ev2deAct1)
        configureButton(btn_ev3deAct1)
        
        configureLabel(label_btnev1Act1)
        configureLabel(label_btnev2Act1)
        configureLabel(label_btnev3Act1)
        
        configureView(view_btnev1Act1)
    }
    
    func configureButton(_ button: UIButton) {
        button.layer.cornerRadius = 20
        button.backgroundColor = customBlueColor
        button.widthAnchor.constraint(equalToConstant: 342).isActive = true
        button.heightAnchor.constraint(equalToConstant: 58).isActive = true
    }
    
    func configureLabel(_ label: UILabel) {
        label.textColor = UIColor.white
        label.font = UIFont(name: "Poppins-ExtraBold", size: 13.0)
    }
    
    func configureView(_ view: UIView) {
        view.widthAnchor.constraint(equalToConstant: 396).isActive = true
        view.heightAnchor.constraint(equalToConstant: 70).isActive = true
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
