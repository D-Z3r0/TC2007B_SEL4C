//
//  ViewControllerEvidenciasIndividual.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 24/09/23.
//

import UIKit
import MobileCoreServices

class ViewControllerEvidenciasIndividual: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate {
    
    //Valores pasado de la información del modulo
    var titulo_modulo_resultado: String = ""
    var modulo_resultado: String = ""
    var instrucciones_actividad: String = ""
    var tipo_entrega_result: String = ""
    var modulo_evidencia: Int = 0
    
    //Componente fijos con cambio de contenido
    @IBOutlet weak var titulo_evidencia: UILabel!
    @IBOutlet weak var titulo_modulo: UILabel!
    @IBOutlet weak var instrucciones: UILabel!
    
    //Componentes variantes dado el contenido
    @IBOutlet weak var entrega_video: UIView!
    @IBOutlet weak var btn_video: UIButton!
    @IBOutlet weak var entrega_imagen: UIView!
    @IBOutlet weak var entrega_audio: UIView!
    @IBOutlet weak var btn_imagen: UIButton!
    @IBOutlet weak var btn_audio: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Mostrar información del modulo seleccionado
        titulo_evidencia.text = titulo_modulo_resultado
        titulo_modulo.text = modulo_resultado
        instrucciones.text = instrucciones_actividad
        print("Evidencia del modulo: \(modulo_evidencia)")
        
        //Hidden los tipos de entrega
        entrega_video.isHidden = true
        entrega_imagen.isHidden = true
        entrega_audio.isHidden = true
        
        //Mostrar espacio de entrega dado el tipo de entrega
        if tipo_entrega_result == "video"{
            entrega_video.isHidden = false
            entrega_imagen.isHidden = true
            entrega_audio.isHidden = true
            // Configurar el botón btn_video para mostrar el menú
            btn_video.addTarget(self, action: #selector(presentVideoOptions), for: .touchUpInside)
        }else if tipo_entrega_result == "imagen"{
            entrega_imagen.isHidden = false
            entrega_video.isHidden = true
            entrega_audio.isHidden = true
            // Configurar el botón btn_video para mostrar el menú
            btn_imagen.addTarget(self, action: #selector(presentImageOptions), for: .touchUpInside)
        }else if tipo_entrega_result == "audio"{
            entrega_audio.isHidden=false
            entrega_imagen.isHidden = true
            entrega_video.isHidden = true
            // Configurar el botón btn_video para mostrar el menú
            btn_audio.addTarget(self, action: #selector(presentAudioOptions), for: .touchUpInside)
        }
    }
    
    // Función para mostrar el menú de opciones de video
        @objc func presentVideoOptions() {
            let alertController = UIAlertController(title: "Elegir Video", message: "Selecciona una opción", preferredStyle: .actionSheet)

            // Opción para grabar un video
            let recordAction = UIAlertAction(title: "Grabar Video", style: .default) { (_) in
                self.recordVideo()
            }

            // Opción para seleccionar un video de la galería
            let pickFromLibraryAction = UIAlertAction(title: "Seleccionar de la Biblioteca", style: .default) { (_) in
                self.pickVideoFromLibrary()
            }

            // Opción para cancelar
            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)

            // Agregar las opciones al controlador de alerta
            alertController.addAction(recordAction)
            alertController.addAction(pickFromLibraryAction)
            alertController.addAction(cancelAction)

            // Presentar el menú de opciones
            present(alertController, animated: true, completion: nil)
        }
    
    // Función para mostrar el menú de opciones de imágenes
    @objc func presentImageOptions() {
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
    
    // Función para mostrar el menú de opciones de audio
    @objc func presentAudioOptions() {
        let alertController = UIAlertController(title: "Elegir Audio", message: "Selecciona una opción", preferredStyle: .actionSheet)

        // Opción para grabar un audio
        let recordAction = UIAlertAction(title: "Grabar Audio", style: .default) { (_) in
            self.recordAudio()
        }

        // Opción para seleccionar un audio de la biblioteca
        let pickFromLibraryAction = UIAlertAction(title: "Seleccionar de la Biblioteca", style: .default) { (_) in
            self.pickAudioFromLibrary()
        }

        // Opción para cancelar
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)

        // Agregar las opciones al controlador de alerta
        alertController.addAction(recordAction)
        alertController.addAction(pickFromLibraryAction)
        alertController.addAction(cancelAction)

        // Presentar el menú de opciones
        present(alertController, animated: true, completion: nil)
    }

    
    // Función para grabar un video
        func recordVideo() {
            // Aquí puedes implementar la lógica para iniciar la grabación de video con la cámara
            // Asegúrate de configurar y mostrar la interfaz de grabación según tus necesidades
        }
    
    // Función para tomar una foto
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

    
    // Función para tomar una foto
        func recordAudio() {
            // Aquí puedes implementar la lógica para iniciar la grabación de video con la cámara
            // Asegúrate de configurar y mostrar la interfaz de grabación según tus necesidades
        }

    
        // Función para seleccionar un video de la galería
        func pickVideoFromLibrary() {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeMovie as String] // Especifica que deseas seleccionar videos
            present(imagePicker, animated: true, completion: nil)
        }
    
    // Función para seleccionar una imagen de la galería
    func pickImageFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String] // Especifica que deseas seleccionar imágenes
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Función para seleccionar un archivo de audio de la galería
        func pickAudioFromLibrary() {
            let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.audio"], in: .import)
            documentPicker.delegate = self
            documentPicker.allowsMultipleSelection = false // Si solo se permite seleccionar un archivo

            present(documentPicker, animated: true, completion: nil)
        }

        // Delegate method for UIDocumentPickerViewController
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            if let audioURL = urls.first {
                // Aquí puedes usar audioURL para acceder al archivo de audio seleccionado
                // Por ejemplo, puedes copiarlo a una ubicación de tu aplicación o procesarlo de alguna otra manera
                print("URL del archivo de audio seleccionado: \(audioURL)")
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
