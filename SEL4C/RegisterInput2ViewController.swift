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
    
    let customFont = UIFont(name: "Poppins-SemiBold", size: 14.0)
    let customFont2 = UIFont(name: "Poppins-Regular", size: 15.0)
    let grades = ["Elige una opción","Pregrado (licenciatura, profesional, universidad, grado)", "Posgrado (maestría, doctorado)", "Educación continua"]
    let genders = ["Elige una opción", "Masculino", "Femenino", "No binario", "Prefiero no decir"]
    let disciplines = ["Elige una opción", "Ingeniería y Ciencias", "Humanidades y educación", "Ciencias sociales", "Ciencias de la salud", "Arquitectura, arte y diseño", "Negocios"]
    var countries: [String] = []
//    let gradeActions: [UIAction] = ["Elige una opción","Pregrado (licenciatura, profesional, universidad, grado)", "Posgrado (maestría, doctorado)", "Educación continua"].map { title in
//        return createPaddedAction(title: title)
//    }
    
    var gradeActions: [UIAction] = []
    var genderActions: [UIAction] = []
    var disciplinesActions: [UIAction] = []
    var countryActions: [UIAction] = []
    var isChecked = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        gradeActionList()
        disciplineActionList()
        genderActionList()
        countryActionList()
        gradeInput.showsMenuAsPrimaryAction = true
        gradeInput.changesSelectionAsPrimaryAction = true
        gradeInput.menu = UIMenu(children: gradeActions)
        disciplineInput.showsMenuAsPrimaryAction = true
        disciplineInput.changesSelectionAsPrimaryAction = true
        disciplineInput.menu = UIMenu(children: disciplinesActions)
        genderInput.showsMenuAsPrimaryAction = true
        genderInput.changesSelectionAsPrimaryAction = true
        genderInput.menu = UIMenu(children: genderActions)
        countryInput.showsMenuAsPrimaryAction = true
        countryInput.changesSelectionAsPrimaryAction = true
        countryInput.menu = UIMenu(children: countryActions)
        let attributedText = NSMutableAttributedString(string: "Acepto términos y condiciones")
        attributedText.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor: UIColor.white, NSAttributedString.Key.font: customFont!], range: NSMakeRange(0, attributedText.length))
        tcButton.setAttributedTitle(attributedText, for: .normal)
    }
    
    @IBAction func checkboxTapped() {
        isChecked.toggle()
        updateCheckboxImage()
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
    
    func getCountries(){
        for code in NSLocale.isoCountryCodes  {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
        }
    }
    
    func updateGrade(grade: String) {
        print(grade)
    }
    func updateDiscipline(discipline: String) {
        print(discipline)
    }
    func updateGender(gender: String) {
        print(gender)
    }
    func updateCountry(country: String) {
        print(country)
    }
    
    func gradeActionList(){
        for grade in grades {
            let action = UIAction(title: grade) { [weak self] _ in
                self?.updateGrade(grade: grade)
            }
            gradeActions.append(action)
        }
    }
    func disciplineActionList(){
        for discipline in disciplines {
            let action = UIAction(title: discipline) { [weak self] _ in
                self?.updateDiscipline(discipline: discipline)
            }
            disciplinesActions.append(action)
        }
    }
    func genderActionList(){
        for gender in genders {
            let action = UIAction(title: gender) { [weak self] _ in
                self?.updateGender(gender: gender)
            }
            genderActions.append(action)
        }
    }
    func countryActionList(){
        getCountries()
        for country in countries {
            let action = UIAction(title: country) { [weak self] _ in
                self?.updateCountry(country: country)
            }
            countryActions.append(action)
        }
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
