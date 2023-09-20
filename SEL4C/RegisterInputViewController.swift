//
//  RegisterInputViewController.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 19/09/23.
//

import UIKit

class RegisterInputViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var inputConfirmPassword: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputUsername: UITextField!
    
    let customFont = UIFont(name: "Poppins-Regular", size: 15.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inputDesign(inputUsername)
        inputDesign(inputEmail)
        inputDesign(inputPassword)
        inputDesign(inputConfirmPassword)
        let attributedText = NSMutableAttributedString(string: "Inicia Sesión")
        attributedText.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor: UIColor.blue, NSAttributedString.Key.font: customFont!], range: NSMakeRange(0, attributedText.length))
        loginButton.setAttributedTitle(attributedText, for: .normal)
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
