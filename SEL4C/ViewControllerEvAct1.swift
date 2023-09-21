//
//  ViewControllerEvAct1.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 21/09/23.
//

import UIKit

class ViewControllerEvAct1: UIViewController {
    
    var button_press_resultados: Int = 0
    
    @IBOutlet weak var view_reflexionInicial: UIView!
    
    @IBOutlet weak var view_resgistro: UIView!
    
    @IBOutlet weak var view_entrevista: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view_reflexionInicial.isHidden = true
        view_entrevista.isHidden = true
        view_resgistro.isHidden = true
        
        // Do any additional setup after loading the view.
        if (button_press_resultados == 1){
            view_reflexionInicial.isHidden = false
            view_entrevista.isHidden = true
            view_resgistro.isHidden = true
        }else if (button_press_resultados == 2){
            view_entrevista.isHidden =
            false
            view_reflexionInicial.isHidden = true
            view_resgistro.isHidden = true
        }else if (button_press_resultados == 3){
            view_resgistro.isHidden = false
            view_reflexionInicial.isHidden = true
            view_entrevista.isHidden = true
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
