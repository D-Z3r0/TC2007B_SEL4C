//
//  LoginInputViewController.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 18/09/23.
//

import UIKit

class LoginInputViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    
    let customFont = UIFont(name: "Poppins-Regular", size: 15.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inputEmail.attributedPlaceholder = NSAttributedString(string: "sel4c@example.com", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        inputPassword.attributedPlaceholder = NSAttributedString(string: "min. 8 caractéres", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        inputDesign(inputEmail)
        inputDesign(inputPassword)
        let attributedText = NSMutableAttributedString(string: "Regístrate")
        attributedText.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor: UIColor.blue, NSAttributedString.Key.font: customFont!], range: NSMakeRange(0, attributedText.length))
        registerButton.setAttributedTitle(attributedText, for: .normal)
    }
    
    func inputDesign(_ textField: UITextField) {
            textField.layer.cornerRadius = 17
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.white.cgColor
            textField.layer.masksToBounds = true
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
