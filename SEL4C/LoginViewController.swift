//
//  LoginViewController.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 18/09/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var showPassword: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    
    let customFont = UIFont(name: "Poppins-Regular", size: 15.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.hidesBackButton = true
        setPlaceholder(inputEmail, text: "sel4c@example.com", padding: 10)
        setPlaceholder(inputPassword, text: "min. 8 caractéres", padding: 10)
        inputDesign(inputEmail)
        inputDesign(inputPassword)
        inputPassword.isSecureTextEntry = true
        let attributedText = NSMutableAttributedString(string: "Regístrate")
        attributedText.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor: UIColor.blue, NSAttributedString.Key.font: customFont!], range: NSMakeRange(0, attributedText.length))
        registerButton.setAttributedTitle(attributedText, for: .normal)
    }
    
    func inputDesign(_ textField: UITextField) {
            textField.layer.cornerRadius = 18
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.white.cgColor
            textField.layer.masksToBounds = true
    }
    func setPlaceholder(_ textField: UITextField, text: String, padding: CGFloat) {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: textField.frame.height))
            textField.leftView = paddingView
            textField.leftViewMode = .always
            textField.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
    @IBAction func passwordVisibilty(){
        inputPassword.isSecureTextEntry.toggle()
    }
    
    @IBAction func registerButtonPressed() {
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "Register1Identifier") as? RegisterInputViewController
            self.navigationController?.pushViewController(destinationVC!, animated: true)
//        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginRegisterIdentifier") as? Login2ViewController
//        present(destinationVC!, animated: true, completion: nil)
    }

    // MARK: - Navigation

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//        if let destinationVC = segue.destination as? Login2ViewController {
//            destinationVC.tagFromButton = 2
//        }
    }
    */

}
