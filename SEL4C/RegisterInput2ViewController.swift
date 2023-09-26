//
//  RegisterInput2ViewController.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 21/09/23.
//

import UIKit

class RegisterInput2ViewController: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var tcButton: UIButton!
    @IBOutlet weak var tcCheckbox: UIButton!
    @IBOutlet weak var ageInput: UITextField!
    @IBOutlet weak var countryInput: UIButton!
    @IBOutlet weak var genderInput: UIButton!
    @IBOutlet weak var gradeInput: UIButton!
    @IBOutlet weak var institutionInput: UITextField!
    
//    let checkedImage = UIImage(named: "checkmark.square.fill")! as UIImage
//    let uncheckedImage = UIImage(named: "checkmark.square")! as UIImage
    let grades = ["Primaria", "Secundaria", "Preparatoria", "Universidad"]
    var countries: [String] = []
    var gradeActions: [UIAction] = []
    var countryActions: [UIAction] = []
    var isChecked = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateCheckboxImage()
        tcCheckbox.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        inputDesign(institutionInput)
        inputDesign(ageInput)
        setPlaceholder(institutionInput , text: "Tec de Monterrey", padding: 10)
        setPlaceholder(ageInput, text: "20", padding: 10)
        createGradeList()
        createCountryList()
        gradeInput.showsMenuAsPrimaryAction = true
        gradeInput.changesSelectionAsPrimaryAction = true
//        let optionClosure = {(action: UIAction) in
//            self.update(number: action.title)
//        }
        gradeInput.menu = UIMenu(children: gradeActions)
        countryInput.showsMenuAsPrimaryAction = true
        countryInput.changesSelectionAsPrimaryAction = true
        countryInput.menu = UIMenu(children: countryActions)
    }
    
    @IBAction func checkboxTapped() {
        isChecked.toggle()
        updateCheckboxImage()
    }
    
    func updateCheckboxImage() {
            let symbolName = isChecked ? "checkmark.square.fill" : "square"
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
    
    func setPlaceholder(_ textField: UITextField, text: String, padding: CGFloat) {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: textField.frame.height))
            textField.leftView = paddingView
            textField.leftViewMode = .always
            textField.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
    func update(number:String) {
        print(number)
    }
    
    func createGradeList(){
        for grade in grades {
            let action = UIAction(title: grade) { [weak self] _ in
                self?.update(number: grade)
            }
            gradeActions.append(action)
        }
    }
    
    func getCountries(){
        for code in NSLocale.isoCountryCodes  {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
        }
    }

    func createCountryList(){
        getCountries()
        for country in countries {
            let action = UIAction(title: country) { [weak self] _ in
                self?.update(number: country)
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
