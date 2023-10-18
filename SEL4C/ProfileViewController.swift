//
//  ProfileViewController.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 04/10/23.
//

import UIKit
import UniformTypeIdentifiers
import AVFoundation

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var signoutButton: UIButton!
    @IBOutlet weak var editProfile: UIButton!
    @IBOutlet weak var countryInput: UIButton!
    @IBOutlet weak var ageInput: UITextField!
    @IBOutlet weak var photoInput: UIButton!
    @IBOutlet weak var gradeInput: UIButton!
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var genderInput: UIButton!
    @IBOutlet weak var disciplineInput: UIButton!
    @IBOutlet var institutionInput: UITextField!
    @IBOutlet var emailInput: UITextField!
    
    let customFont = UIFont(name: "Poppins-SemiBold", size: 12.0)
    var users = Users()
    var getUser = Users()
//    var sendUser = SignupController()
    
    let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 5)
    let symbolAfterConfiguration = UIImage.SymbolConfiguration(pointSize: 5)
    var selectedImage: UIImage?
    var isEditable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UserDefaults.standard.set(1, forKey: "ID")
        emailInput.isEnabled = false
        countryInput.isEnabled = false
        editProfile.contentHorizontalAlignment = .left
        Task{
            do{
                getUser = try await Users.getUser()
//                print(getUser)
                updateUI(user: getUser)
            }catch{
                displayError(GetUserError.itemNotFound, title: "No se pudo accer a las preguntas")
            }
        }

        let resizedSymbolImage = UIImage(systemName: "person.circle.fill", withConfiguration: symbolConfiguration)
        photoInput.setImage(resizedSymbolImage, for: .normal)
        
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
        disableFieldsAndButtons()
//        gradeInput.setBackgroundColor(UIColor.white, for: .normal)
//        gradeInput.setBackgroundColor(UIColor.white, for: .disabled)
//        if (gradeInput.isEnabled) {
//            gradeInput.backgroundColor = UIColor.white
//        } else {
//            gradeInput.backgroundColor = UIColor.white
//        }
    }
    
    @IBAction func toggleEditing() {
        isEditable.toggle()
        let attributes: [NSAttributedString.Key: Any] = [
                .font: customFont!,
                .foregroundColor: UIColor.white
        ]
        if isEditable {
            // Habilita los campos y botones para editar
            enableFieldsAndButtons()
            editProfile.setTitle("Guardar", for: .normal)
            let attributedTitle = NSAttributedString(string: "Guardar", attributes: attributes)
                    editProfile.setAttributedTitle(attributedTitle, for: .normal)
        } else {
            // Guarda los cambios y deshabilita los campos y botones
            updateUser()
            disableFieldsAndButtons()
            let attributedTitle = NSAttributedString(string: "Editar información", attributes: attributes)
                    editProfile.setAttributedTitle(attributedTitle, for: .normal)
        }
    }
    
    @IBAction func logout(){
        UserDefaults.standard.set(false, forKey: "LOGGEDIN")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func updateUI(user:Users){
        DispatchQueue.main.async {
            self.usernameInput.text = user.username
            self.emailInput.text = user.email
            self.institutionInput.text = user.institucion
            self.ageInput.text = String(user.edad)
            self.gradeInput.setTitle(user.grado_ac, for: .normal)
            self.disciplineInput.setTitle(user.disciplina, for: .normal)
            self.genderInput.setTitle(user.genero, for: .normal)
            self.countryInput.setTitle(user.pais, for: . normal)
        }
    }
    
    func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continuar", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateUser(){
        users.id_usuario = getUser.id_usuario
        users.contrasena = getUser.contrasena
        users.email = emailInput.text!
        users.username = usernameInput.text!
        users.grado_ac = (gradeInput.titleLabel!.text)!
        users.institucion = institutionInput.text!
        users.genero = (genderInput.titleLabel!.text)!
        users.edad = Int(ageInput.text!)!
        users.pais = (countryInput.titleLabel!.text)!
        users.disciplina = (disciplineInput.titleLabel!.text!)
        print(users)
        Task{
            do{
                try await Users.putUser(user:users)
            }catch{
                displayError(GetUserError.itemNotFound, title: "No se encontro el usuario.")
            }
        }
    }
    
    func enableFieldsAndButtons() {
        usernameInput.isEnabled = true
//        emailInput.isEnabled = true
        institutionInput.isEnabled = true
        gradeInput.isEnabled = true
        disciplineInput.isEnabled = true
        genderInput.isEnabled = true
        ageInput.isEnabled = true
//        countryInput.isEnabled = true
        photoInput.isEnabled = true
        // Habilita otros campos y botones según sea necesario
    }

    func disableFieldsAndButtons() {
        usernameInput.isEnabled = false
//        emailInput.isEnabled = false
        institutionInput.isEnabled = false
        gradeInput.isEnabled = false
        disciplineInput.isEnabled = false
        genderInput.isEnabled = false
        ageInput.isEnabled = false
//        countryInput.isEnabled = false
        photoInput.isEnabled = false
        // Deshabilita otros campos y botones según sea necesario
    }
    
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
        let isAllValid = isInstitutionValid && isAgeValid && isGenderValid && isGradeValid && isCountryValid
        editProfile.isEnabled = isAllValid
    }
    
    @IBAction func presentImageOptions() {
        let alertController = UIAlertController(title: "Elegir Imagen", message: "Selecciona una opción", preferredStyle: .actionSheet)

        // Opción para tomar una foto
        let takePhotoAction = UIAlertAction(title: "Tomar Foto", style: .default) { (_) in
            self.takePhoto()
        }

        // Opción para seleccionar una imagen de la galería
        let pickFromLibraryAction = UIAlertAction(title: "Seleccionar de la Biblioteca", style: .default) { (_) in
            self.pickImageFromLibrary()
        }

        // Opción para cancelar
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)

        // Agregar las opciones al controlador de alerta
        alertController.addAction(takePhotoAction)
        alertController.addAction(pickFromLibraryAction)
        alertController.addAction(cancelAction)

        // Presentar el menú de opciones
        present(alertController, animated: true, completion: nil)
    }
    
    func takePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.cameraCaptureMode = .photo // Configura para captura de foto

            // Presenta el controlador de captura de foto
            present(imagePicker, animated: true, completion: nil)
        } else {
            // La cámara no está disponible en este dispositivo
            // Puedes mostrar un mensaje de error al usuario
            print("La cámara no está disponible en este dispositivo.")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
            photoInput.setImage(selectedImage, for: .normal)
                    /*
                    Task{
                        do{
                            let datos = try await MultipartRequest.sendEvidence(user: "usuario.prueba", activity: "activity1", evidenceName: "evidencia1", image: image_selected.image!)
                            print("se hizo la llamada")
                        }catch{
                            print("falló la llamada")
                        }
                    }*/
        }
        // Cierra el controlador de selección de medios
        picker.dismiss(animated: true, completion: nil)
    }
    
    func pickImageFromLibrary() {
        let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = ["public.image"] // Especifica que deseas seleccionar imágenes
            present(imagePicker, animated: true, completion: nil)
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

//extension UIButton {
//
//    open override var isEnabled: Bool{
//        didSet {
//            alpha = isEnabled ? 1.0 : 1.0
//        }
//    }
//
//}
