//
//  RegisterInputViewController.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 19/09/23.
//

import UIKit

class RegisterInputViewController: UIViewController {

    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var showPassword2: UIButton!
    @IBOutlet weak var showPassword1: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var inputConfirmPassword: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputUsername: UITextField!
    
    let customFont = UIFont(name: "Poppins-Regular", size: 15.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.hidesBackButton = true
        inputDesign(inputUsername)
        inputDesign(inputEmail)
        inputDesign(inputPassword)
        inputDesign(inputConfirmPassword)
        setPlaceholder(inputUsername, text: "sel4c2023", padding: 10)
        setPlaceholder(inputEmail, text: "selac@example.com", padding: 10)
        setPlaceholder(inputPassword, text: "min. 8 caracteres", padding: 10)
        setPlaceholder(inputConfirmPassword, text: "min. 8 caracteres", padding: 10)
        inputPassword.isSecureTextEntry = true
        inputConfirmPassword.isSecureTextEntry = true
        let attributedText = NSMutableAttributedString(string: "Inicia Sesión")
        attributedText.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor: UIColor.blue, NSAttributedString.Key.font: customFont!], range: NSMakeRange(0, attributedText.length))
        loginButton.setAttributedTitle(attributedText, for: .normal)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
    }
    
    @IBAction func infoButtonTapped() {
            // Puedes mostrar una alerta informativa aquí
            let alertController = UIAlertController(title: "Requisitos de contraseña", message: "La contraseña debe tener al menos 8 caracteres.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
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
    
    @IBAction func passwordVisibiltyButton1(){
        inputPassword.isSecureTextEntry.toggle()
        
    }
    @IBAction func passwordVisibiltyButton2(){
        inputConfirmPassword.isSecureTextEntry.toggle()
    }
    
    @IBAction func registerButtonPressed() {
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginIdentifier") as? LoginViewController
            self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    /*
    func updateCheckboxImage() {
            let symbolName =  ? "checkmark.square.fill" : "square"
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 18)
            let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)

            tcCheckbox.setImage(image, for: .normal)
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
