//
//  ViewControllerActividades.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 20/09/23.
//

import UIKit

class ViewControllerActividades: UIViewController {

    @IBOutlet weak var btn_actividad1: UIButton!
    @IBOutlet weak var label_actividad1: UILabel!
    
    @IBOutlet weak var btn_actividad2: UIButton!
    @IBOutlet weak var label_actividad2: UILabel!
    
    @IBOutlet weak var btn_actividad3: UIButton!
    @IBOutlet weak var label_actividad3: UILabel!
    
    @IBOutlet weak var btn_actividad4: UIButton!
    @IBOutlet weak var label_actividad4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        applyShadow(to: btn_actividad1)
        roundBottomCorners(of: label_actividad1)
        
        applyShadow(to: btn_actividad2)
        roundBottomCorners(of: label_actividad2)
        
        applyShadow(to: btn_actividad3)
        roundBottomCorners(of: label_actividad3)
        
        applyShadow(to: btn_actividad4)
        roundBottomCorners(of: label_actividad4)
    }
    func applyShadow(to view: UIView) {
            view.layer.shadowColor = UIColor.gray.cgColor
            view.layer.shadowOpacity = 0.5
            view.layer.shadowOffset = CGSize(width: 0, height: 2)
            view.layer.shadowRadius = 4
        }
        
    func roundBottomCorners(of view: UIView) {
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = UIBezierPath(
            roundedRect: view.bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: 10, height: 10)
        ).cgPath

        view.layer.mask = maskLayer
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
