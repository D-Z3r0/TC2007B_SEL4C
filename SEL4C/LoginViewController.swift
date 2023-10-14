//
//  LoginViewController.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 18/09/23.
//

import UIKit

class LoginViewController: UIViewController{
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var showPassword: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    
    var userLogin = UserLogin()
    var loginController = LoginController()
    
    let customFont = UIFont(name: "Poppins-Regular", size: 15.0)
    var isPasswordVisible = false
    var validEMail = false
    var validPassword = false
    
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
        attributedText.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor: UIColor.link, NSAttributedString.Key.font: customFont!], range: NSMakeRange(0, attributedText.length))
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
        isPasswordVisible.toggle()
        if isPasswordVisible {
            showPassword.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            inputPassword.isSecureTextEntry = false
        } else {
            showPassword.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            inputPassword.isSecureTextEntry = true
        }
    }
    
    @IBAction func registerButtonPressed() {
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "Register1Identifier") as? RegisterInputViewController
            self.navigationController?.pushViewController(destinationVC!, animated: true)
//        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginRegisterIdentifier") as? Login2ViewController
//        present(destinationVC!, animated: true, completion: nil)
    }
    
    @IBAction func verifyInputs(_ button: UIButton) {
        let emailText = inputEmail.text
        let passwordText = inputPassword.text
        print(emailText!)
        print(passwordText!)
        if  emailText!.contains("@") && passwordText!.count > 1 {
            userLogin.email = emailText!
            userLogin.contrasena = passwordText!
            print(userLogin)
            Task{
                do{
                    let jsonResponse = try await loginController.userLogin(loginResponse: userLogin)
                    let userID = jsonResponse!["id"] as? Int
                    print(userID!)
                    UserDefaults.standard.set(userID, forKey: "ID")
                    evaluationNavigate()
                    UserDefaults.standard.set(true, forKey: "LOGGEDIN")
                }catch{
                    displayErrorUserResponses(UserError.itemNotFound, title: "No se encontro el usuario.")
                }
            } 
        }else {
            invalidInputsAlert()
        }
    }
    
    @IBAction func toqueEnPantalla(_ sender: Any) {
        inputPassword.resignFirstResponder()
            inputEmail.resignFirstResponder()
        }
    
    func evaluationNavigate(){
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "InitialEvaluationIdentifier") as? InitialEvaluationViewController
            self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
        
    func displayErrorUserResponses(_ error: Error, title: String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Continuar", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
    }
    
    func invalidInputsAlert() {
        let alertController = UIAlertController(title: "Datos inválidos", message: "Proporcione correctamente un correo y contraseña.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
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
