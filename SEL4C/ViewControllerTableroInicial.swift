//
//  ViewControllerTableroInicial.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 03/09/23.
//

import UIKit

class ViewControllerTableroInicial: UIViewController {
    @IBOutlet weak var imageChange: UIImageView!
    @IBOutlet weak var btnEvaluaciones: UIButton!
    @IBOutlet weak var btnActividades: UIButton!
    @IBOutlet weak var btnEvaluacionFinal: UIButton!
    @IBOutlet weak var btnAct2: UIButton!
    
    @IBOutlet weak var btnEvaluacionInicial: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnEvaluacionInicial.isEnabled = false
        btnEvaluacionFinal.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn1Pressed(_ sender: UIButton) {
        imageChange.image = UIImage(named: "6 - tableroEvaluaciones")
        btnAct2.isEnabled = true
        btnEvaluacionInicial.isEnabled = false
        btnEvaluacionFinal.isEnabled = false
    }
        
    @IBAction func btn2Pressed(_ sender: UIButton) {
        imageChange.image = UIImage(named: "6.8 - tableroEv")
        btnAct2.isEnabled = false
        btnEvaluacionInicial.isEnabled = true
        btnEvaluacionFinal.isEnabled = true
    }
    
    @IBAction func btn3Pressed(_ sender: UIButton) {
        imageChange.image = UIImage(named: "6.9 - tableroRecursos")
        btnAct2.isEnabled = false
        btnEvaluacionInicial.isEnabled = false
        btnEvaluacionFinal.isEnabled = false
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
