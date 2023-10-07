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
    
    let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 5)
    let symbolAfterConfiguration = UIImage.SymbolConfiguration(pointSize: 5)
    var selectedImage: UIImage?
    var isEditable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
// Ajusta el punto de tamaño según tus necesidades
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
        if isEditable {
            // Habilita los campos y botones para editar
            enableFieldsAndButtons()
            editProfile.setTitle("Guardar", for: .normal)
        } else {
            // Guarda los cambios y deshabilita los campos y botones
            disableFieldsAndButtons()
            editProfile.setTitle("Editar", for: .normal)
            
        }
    }
    
    @IBAction func logout(){
        UserDefaults.standard.set(false, forKey: "LOGGEDIN")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func enableFieldsAndButtons() {
        usernameInput.isEnabled = true
        emailInput.isEnabled = true
        institutionInput.isEnabled = true
        gradeInput.isEnabled = true
        disciplineInput.isEnabled = true
        genderInput.isEnabled = true
        ageInput.isEnabled = true
        countryInput.isEnabled = true
        photoInput.isEnabled = true
        // Habilita otros campos y botones según sea necesario
    }

    func disableFieldsAndButtons() {
        usernameInput.isEnabled = false
        emailInput.isEnabled = false
        institutionInput.isEnabled = false
        gradeInput.isEnabled = false
        disciplineInput.isEnabled = false
        genderInput.isEnabled = false
        ageInput.isEnabled = false
        countryInput.isEnabled = false
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
