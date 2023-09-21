//
//  ViewControllerActividadUno.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 20/09/23.
//

import UIKit

class ViewControllerActividadUno: UIViewController {

    @IBOutlet weak var view_actividadUno: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view_actividadUno.layer.cornerRadius = 10 // You can adjust the corner radius as needed
        view_actividadUno.layer.masksToBounds = true
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
