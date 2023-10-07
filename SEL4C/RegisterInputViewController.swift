//
//  RegisterInputViewController.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 19/09/23.
//

import UIKit

class RegisterInputViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var showPassword2: UIButton!
    @IBOutlet weak var showPassword1: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var inputConfirmPassword: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputUsername: UITextField!
    
    let customFont = UIFont(name: "Poppins-Regular", size: 15.0)
    let customFont2 = UIFont(name: "Poppins-Bold", size: 18.0)
    let customFont3 = UIFont(name: "Poppins-Regular", size: 13.0)
    
    var isPasswordVisible1 = false
    var isPasswordVisible2 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.hidesBackButton = true
        nextButton.isEnabled = false
        inputDesign(inputUsername)
        inputDesign(inputEmail)
        inputDesign(inputPassword)
        inputDesign(inputConfirmPassword)
        inputEmail.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        inputPassword.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        inputUsername.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        inputConfirmPassword.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        setPlaceholder(inputUsername, text: "sel4c2023", padding: 10)
        setPlaceholder(inputEmail, text: "selac@example.com", padding: 10)
        setPlaceholder(inputPassword, text: "min. 8 caracteres", padding: 10)
        setPlaceholder(inputConfirmPassword, text: "min. 8 caracteres", padding: 10)
        inputPassword.isSecureTextEntry = true
        inputConfirmPassword.isSecureTextEntry = true
        let attributedText = NSMutableAttributedString(string: "Inicia Sesión")
        attributedText.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor: UIColor.link, NSAttributedString.Key.font: customFont!], range: NSMakeRange(0, attributedText.length))
        loginButton.setAttributedTitle(attributedText, for: .normal)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
    }
    
    @IBAction func infoButtonTapped() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: customFont2!, .foregroundColor: UIColor.black]
        let attributedTitle = NSAttributedString(string: "Requisitos de la contraseña", attributes: titleAttributes)
        let message = "La contraseña debe tener al menos:\n• 8 caracteres\n• Una letra mayúscula\n• Un número\nPuedes usar caractéres especiales."
        let messageAttributes: [NSMutableAttributedString.Key: Any] = [
            .font: customFont3!,
            .foregroundColor: UIColor.black,
            .paragraphStyle: {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center
                paragraphStyle.lineSpacing = 5
                return paragraphStyle
            }(),
        ]
        let attributedMessage = NSMutableAttributedString(string: message, attributes: messageAttributes)
        let paragraphStyleLeft = NSMutableParagraphStyle()
        paragraphStyleLeft.alignment = .left
        paragraphStyleLeft.lineSpacing = 5
        attributedMessage.addAttribute(.paragraphStyle, value: paragraphStyleLeft, range: NSRange(location: 0, length: 84))
        alertController.setValue(attributedTitle, forKey: "attributedTitle")
        alertController.setValue(attributedMessage, forKey: "attributedMessage")
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
        isPasswordVisible1.toggle()
        if isPasswordVisible1 {
            showPassword1.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            inputPassword.isSecureTextEntry = false
        } else {
            showPassword1.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            inputPassword.isSecureTextEntry = true
        }
    }
    
    @IBAction func passwordVisibiltyButton2(){
        isPasswordVisible2.toggle()
        if isPasswordVisible2 {
            showPassword2.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            inputConfirmPassword.isSecureTextEntry = false
        } else {
            showPassword2.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            inputConfirmPassword.isSecureTextEntry = true
        }
    }
    
    @IBAction func registerButtonPressed() {
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginIdentifier") as? LoginViewController
            self.navigationController?.pushViewController(destinationVC!, animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let usernameText = inputUsername.text, let emailText = inputEmail.text, let passwordText = inputPassword.text, let passwordConfirmText = inputConfirmPassword.text {
            // Verificar las condiciones, por ejemplo, longitud mayor a 5 caracteres
            let isUsernameValid = usernameText.count > 1
            let isEmailValid = isValidEmail(emailText)
            let isPasswordValid = isValidPassword(passwordText)
            let isPasswordConfirmationValid = passwordText == passwordConfirmText

            // Habilitar el botón si todas las condiciones se cumplen
            nextButton.isEnabled = isUsernameValid && isEmailValid && isPasswordValid && isPasswordConfirmationValid
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        return email.count > 1 && email.contains("@")
    }

    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 8 && password.rangeOfCharacter(from: .uppercaseLetters) != nil && password.rangeOfCharacter(from: .decimalDigits) != nil
    }
    
    /*
    func updateCheckboxImage() {
            let symbolName =  ? "checkmark.square.fill" : "square"
            let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 18)
            let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)

            tcCheckbox.setImage(image, for: .normal)
    }*/
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destinationVC = segue.destination as? RegisterInput2ViewController
        destinationVC?.password = inputPassword.text!
        destinationVC?.username = inputUsername.text!
        destinationVC?.email = inputEmail.text!
    }
}
