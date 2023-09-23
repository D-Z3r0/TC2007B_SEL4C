//
//  ViewControllerActividades.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 20/09/23.
//

import UIKit

class ViewControllerActividades: UIViewController {

    @IBOutlet weak var stack_view: UIStackView!
    
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
        configureButton(btn_actividad1)
        configureLabel(label_actividad1)
        
        configureButton(btn_actividad2)
        configureLabel(label_actividad2)
        
        configureButton(btn_actividad3)
        configureLabel(label_actividad3)
        
        configureButton(btn_actividad4)
        configureLabel(label_actividad4)
    }
    
    func configureButton(_ button: UIButton){
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.widthAnchor.constraint(equalToConstant: 325).isActive = true
        button.heightAnchor.constraint(equalToConstant: 186).isActive = true
    }
    
    func configureLabel(_ label: UILabel){
        let maskLayer = CAShapeLayer()
        maskLayer.frame = label.bounds
        maskLayer.path = UIBezierPath(
            roundedRect: label.bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: 10, height: 10)
        ).cgPath
        
        label.backgroundColor = UIColor.white
        label.layer.mask = maskLayer
        label.textColor = UIColor.black
        label.font = UIFont(name: "Poppins-Medium", size: 17.0)
        label.heightAnchor.constraint(equalToConstant: 41).isActive = true
        label.widthAnchor.constraint(equalToConstant: 325).isActive = true
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
