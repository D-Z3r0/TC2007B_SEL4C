//
//  ViewControllerActividadUno.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 19/09/23.
//

import UIKit

class ViewControllerActividadUno: UIViewController {

    @IBOutlet weak var principal_view: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        principal_view.layer.cornerRadius = 10 // Ajusta el radio de esquina según tus preferencias
        principal_view.clipsToBounds = true
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
