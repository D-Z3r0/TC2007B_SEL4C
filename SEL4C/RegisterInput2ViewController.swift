//
//  RegisterInput2ViewController.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 21/09/23.
//

import UIKit

class RegisterInput2ViewController: UIViewController, UIPickerViewDelegate{

    @IBOutlet weak var disciplineInput: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var tcButton: UIButton!
    @IBOutlet weak var tcCheckbox: UIButton!
    @IBOutlet weak var ageInput: UITextField!
    @IBOutlet weak var countryInput: UIButton!
    @IBOutlet weak var genderInput: UIButton!
    @IBOutlet weak var gradeInput: UIButton!
    @IBOutlet weak var institutionInput: UITextField!
    
    var users = Users()
    var signupController = SignupController()
    var username:String = ""
    var email:String = ""
    var password:String = ""
    
    let customFont = UIFont(name: "Poppins-SemiBold", size: 14.0)
    let customFont2 = UIFont(name: "Poppins-Regular", size: 15.0)
//    let grades = ["Elige una opción","Pregrado (licenciatura, profesional, universidad, grado)", "Posgrado (maestría, doctorado)", "Educación continua"]
//    let genders = ["Elige una opción", "Masculino", "Femenino", "No binario", "Prefiero no decir"]
//    let disciplines = ["Elige una opción", "Ingeniería y Ciencias", "Humanidades y educación", "Ciencias sociales", "Ciencias de la salud", "Arquitectura, arte y diseño", "Negocios"]
//    let gradeActions: [UIAction] = ["Elige una opción","Pregrado (licenciatura, profesional, universidad, grado)", "Posgrado (maestría, doctorado)", "Educación continua"].map { title in
//        return createPaddedAction(title: title)
//    }
    
//    var gradeActions: [UIAction] = []
//    var genderActions: [UIAction] = []
//    var disciplinesActions: [UIAction] = []
//    var countryActions: [UIAction] = []
    var isChecked = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        registerButton.isEnabled = false
        print(email)
        print(password)
        print(username)
        updateCheckboxImage()
//        tcCheckbox.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        inputDesign(institutionInput)
        inputDesign(ageInput)
        buttonDesign(gradeInput)
        buttonDesign(genderInput)
        buttonDesign(countryInput)
        buttonDesign(disciplineInput)
//        applyTextStyle(gradeInput)
        setPlaceholder(institutionInput , text: "Tec de Monterrey", padding: 10)
        setPlaceholder(ageInput, text: "20", padding: 10)
//        let gradeActions = GradeActions.createActions(handler: upgradeGrade)
//        let genderActions = GenderActions.createActions(handler: upgradeGender)
//        let disciplineActions = DisciplineActions.createActions(handler: upgradeDiscipline)
//        let countryActions = CountryActions.createActions(handler: upgradeCountry)
        institutionInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        ageInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        gradeInput.showsMenuAsPrimaryAction = true
        gradeInput.changesSelectionAsPrimaryAction = true
        gradeInput.menu = UIMenu(children: GradeActions.createActions { [weak self] in
            self?.validateInputs()
        })
        disciplineInput.showsMenuAsPrimaryAction = true
        disciplineInput.changesSelectionAsPrimaryAction = true
        disciplineInput.menu = UIMenu(children: DisciplineActions.createActions { [weak self] in
            self?.validateInputs()
        })
        genderInput.showsMenuAsPrimaryAction = true
        genderInput.changesSelectionAsPrimaryAction = true
        genderInput.menu = UIMenu(children: GenderActions.createActions { [weak self] in
            self?.validateInputs()
        })
        countryInput.showsMenuAsPrimaryAction = true
        countryInput.changesSelectionAsPrimaryAction = true
        countryInput.menu = UIMenu(children: CountryActions.createActions { [weak self] in
            self?.validateInputs()
        })
        let attributedText = NSMutableAttributedString(string: "Acepto términos y condiciones")
        attributedText.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor: UIColor.white, NSAttributedString.Key.font: customFont!], range: NSMakeRange(0, attributedText.length))
        tcButton.setAttributedTitle(attributedText, for: .normal)
    }
    
    @IBAction func checkboxTapped() {
        isChecked.toggle()
        updateCheckboxImage()
        validateInputs()
    }
    
    @IBAction func userSignup(){
        users.username = username
        users.contrasena = password
        users.email = email
        users.grado_ac = (gradeInput.titleLabel?.text)!
        users.institucion = institutionInput.text!
        users.genero = (genderInput.titleLabel?.text)!
        users.edad = Int(ageInput.text!)!
//        users.pais = (countryInput.titleLabel?.text)!
        users.pais = "opcion1"
        Task{
            do{
                try await signupController.userSignup(signupResponse:users)
                evaluationNavigate()
                UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
            }catch{
                displayErrorUserResponses(UserSignUpError.itemNotFound, title: "No se encontro el usuario.")
            }
        }
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
    
//    @IBAction func handleGradeMenuSelection(_ sender: UIAction) {
//            // Actualiza el título del botón con el texto seleccionado
//            gradeInput.setTitle(sender.title, for: .normal)
//    }
    
    func updateCheckboxImage() {
        let symbolName = isChecked ? "checkmark.square.fill" : "checkmark.square"
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 18)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        tcCheckbox.setImage(image, for: .normal)
    }
    func inputDesign(_ textField: UITextField) {
        textField.layer.cornerRadius = 18
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.masksToBounds = true
    }
    func buttonDesign(_ button: UIButton) {
        button.layer.cornerRadius = 18
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.masksToBounds = true
    }
    
//    func applyTextStyle(_ button: UIButton) {
//        let attributedString = NSAttributedString(string: button.title(for: .normal) ?? "", attributes: [
//            .font: customFont2!,
//            .foregroundColor: UIColor.white,
//            
//        ])
//        button.setAttributedTitle(attributedString, for: .normal)
//        button.configuration?.titlePadding = 10
//    }
    
    func setPlaceholder(_ textField: UITextField, text: String, padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
//    func getCountries(){
//        for code in NSLocale.isoCountryCodes  {
//            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
//            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
//            countries.append(name)
//        }
//    }
    
//    func updateGrade(_ sender: UIAction) {
//        genderInput.setTitle(sender.title, for: .normal)
////        validateInputs()
//    }
//    func updateDiscipline(discipline: String) {
//        print(discipline)
//    }
//    func updateGender(gender: String) {
//        print(gender)
//    }
//    func updateCountry(country: String) {
//        print(country)
//    }
//    func upgradeGrade(_ action: UIAction) {
//        let grade = action.title // Accedemos directamente al valor, no necesitas "if let"
//        gradeInput.setTitle(grade, for: .normal)
//        validateInputs()
//    }
//    func upgradeDiscipline(_ action: UIAction) {
//        let discipline = action.title // Accedemos directamente al valor, no necesitas "if let"
//        disciplineInput.setTitle(discipline, for: .normal)
//        validateInputs()
//    }
//    func upgradeGender(_ action: UIAction) {
//        let gender = action.title // Accedemos directamente al valor, no necesitas "if let"
//        genderInput.setTitle(gender, for: .normal)
//        validateInputs()
//    }
//    func upgradeCountry(_ action: UIAction) {
//        let country = action.title // Accedemos directamente al valor, no necesitas "if let"
//        countryInput.setTitle(country, for: .normal)
//        validateInputs()
//    }
    
//    func gradeActionList(){
//        for grade in grades {
//            let action = UIAction(title: grade) { [weak self] _ in
//                self?.updateGrade(action)
//            }
//            gradeActions.append(action)
//        }
//    }
//    func disciplineActionList(){
//        for discipline in disciplines {
//            let action = UIAction(title: discipline) { [weak self] _ in
//                self?.updateDiscipline(discipline: discipline)
//            }
//            disciplinesActions.append(action)
//        }
//    }
//    func genderActionList(){
//        for gender in genders {
//            let action = UIAction(title: gender) { [weak self] _ in
//                self?.updateGender(gender: gender)
//            }
//            genderActions.append(action)
//        }
//    }
//    func countryActionList(){
//        getCountries()
//        for country in countries {
//            let action = UIAction(title: country) { [weak self] _ in
//                self?.updateCountry(country: country)
//            }
//            countryActions.append(action)
//        }
//    }
//    func gradeActionList(){
//        for grade in grades {
//            let action = UIAction(title: grade, handler: upgradeGrade)
//            gradeActions.append(action)
//        }
//    }
//    func disciplineActionList(){
//        for discipline in disciplines {
//            let action = UIAction(title: discipline, handler: upgradeDiscipline)
//            disciplinesActions.append(action)
//        }
//    }
//    func genderActionList(){
//        for gender in genders {
//            let action = UIAction(title: gender, handler: upgradeGender)
//            genderActions.append(action)
//        }
//    }
//    func countryActionList(){
//        getCountries()
//        for country in countries {
//            let action = UIAction(title: country, handler: upgradeCountry)
//            countryActions.append(action)
//        }
//    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        validateInputs()
    }
    
    func isNumeric(_ str: String) -> Bool {
        return Int(str) != nil
    }
    
    func validateInputs() {
        let isInstitutionValid = institutionInput.text!.count > 1
        let isAgeValid = isNumeric(ageInput.text!)
        let isGenderValid = genderInput.title(for: .normal) != "Elige una opción"
        let isGradeValid = gradeInput.title(for: .normal) != "Elige una opción"
        let isCountryValid = countryInput.title(for: .normal) != "Elige una opción"
        
        let isAllValid = isInstitutionValid && isAgeValid && isChecked && isGenderValid && isGradeValid && isCountryValid
        
        // Habilitar o deshabilitar el botón de registro según las validaciones
        registerButton.isEnabled = isAllValid
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
