//
//  ViewControllerEvInicialResultados.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 27/09/23.
//

import UIKit

class ViewControllerEvInicialResultados: UIViewController {
    
    @IBOutlet weak var btn_competencia: UIButton!
    @IBOutlet weak var btn_sub1: UIButton!
    @IBOutlet weak var btn_sub2: UIButton!
    @IBOutlet weak var btn_sub3: UIButton!
    @IBOutlet weak var btn_sub4: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        btn_competencia.layer.shadowColor = UIColor.gray.cgColor // Shadow color
        btn_competencia.layer.shadowOpacity = 0.5 // Shadow opacity
        btn_competencia.layer.shadowOffset = CGSize(width: 0, height: 2) // Shadow offset
        btn_competencia.layer.shadowRadius = 4 // Shadow radius
        
        btn_sub1.layer.shadowColor = UIColor.gray.cgColor // Shadow color
        btn_sub1.layer.shadowOpacity = 0.5 // Shadow opacity
        btn_sub1.layer.shadowOffset = CGSize(width: 0, height: 2) // Shadow offset
        btn_sub1.layer.shadowRadius = 4 // Shadow radius
        
        btn_sub2.layer.shadowColor = UIColor.gray.cgColor // Shadow color
        btn_sub2.layer.shadowOpacity = 0.5 // Shadow opacity
        btn_sub2.layer.shadowOffset = CGSize(width: 0, height: 2) // Shadow offset
        btn_sub2.layer.shadowRadius = 4 // Shadow radius
        
        btn_sub3.layer.shadowColor = UIColor.gray.cgColor // Shadow color
        btn_sub3.layer.shadowOpacity = 0.5 // Shadow opacity
        btn_sub3.layer.shadowOffset = CGSize(width: 0, height: 2) // Shadow offset
        btn_sub3.layer.shadowRadius = 4 // Shadow radius
        
        btn_sub4.layer.shadowColor = UIColor.gray.cgColor // Shadow color
        btn_sub4.layer.shadowOpacity = 0.5 // Shadow opacity
        btn_sub4.layer.shadowOffset = CGSize(width: 0, height: 2) // Shadow offset
        btn_sub4.layer.shadowRadius = 4 // Shadow radius
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
