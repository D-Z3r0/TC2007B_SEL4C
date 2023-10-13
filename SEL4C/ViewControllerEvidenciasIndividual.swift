//
//  ViewControllerEvidenciasIndividual.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 24/09/23.
//

import UIKit
import MobileCoreServices
import AVFoundation

class ViewControllerEvidenciasIndividual: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate,AVAudioRecorderDelegate {
    
    //Valores pasado de la información del modulo
    var titulo_modulo_resultado: String = ""
    var modulo_resultado: String = ""
    var instrucciones_actividad: String = ""
    var tipo_entrega_result: String = ""
    var modulo_evidencia: Int = 0
    var actividad_modulo: Int = 0
    
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
    @IBOutlet weak var entrega_exitosa: UIView!
    
    var selectedImage: UIImage?
    var selectedVideoURL: URL?
    var selectedAudioData: Data?
    var selectedAudioURL: URL?
    
    var audioRecorder: AVAudioRecorder?
    @IBOutlet weak var image_selected: UIImageView!
    
    var moduloIndividual: Modulo_individual?
    var idusar: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let userID = defaults.integer(forKey: "ID")
        idusar = userID
        // Esto eliminará todos los valores almacenados en UserDefaults.standard
        
        //Hidden los tipos de entrega
        /*entrega_video.isHidden = true
        entrega_imagen.isHidden = true
        entrega_audio.isHidden = true
        entrega_exitosa.isHidden = true*/
        
        Task{
            do {
                moduloIndividual = try await Modulo.fetchModulosDetail(id_actividad: actividad_modulo, id_modulo: modulo_evidencia)
                
                if let modulo = moduloIndividual {
                    /*
                    // Eliminar todos los valores almacenados en UserDefaults.standard
                    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)

                    // Sincronizar UserDefaults para asegurarse de que los cambios se apliquen de inmediato
                    UserDefaults.standard.synchronize()*/
                    let defaults = UserDefaults.standard
                    let isUserLogged = defaults.bool(forKey: "actividad \(modulo.id_actividad) modulo \(modulo.id_modulo)")
                    print("Modulo cargado con éxito: \(modulo)")
                    titulo_modulo.text = modulo.titulo_mod
                    if let data = modulo.instrucciones.data(using: .utf16),
                       let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                        instrucciones.attributedText = attributedString
                    }
                    tipo_entrega_result = modulo.tipo_multimedia
                    if !(isUserLogged){
                        if tipo_entrega_result == "video"{
                            entrega_video.isHidden = false
                            entrega_imagen.isHidden = true
                            entrega_audio.isHidden = true
                            entrega_exitosa.isHidden = true
                            // Configurar el botón btn_video para mostrar el menú
                            btn_video.addTarget(self, action: #selector(presentVideoOptions), for: .touchUpInside)
                        }else if tipo_entrega_result == "imagen"{
                            entrega_imagen.isHidden = false
                            entrega_video.isHidden = true
                            entrega_audio.isHidden = true
                            entrega_exitosa.isHidden = true
                            // Configurar el botón btn_video para mostrar el menú
                            btn_imagen.addTarget(self, action: #selector(presentImageOptions), for: .touchUpInside)
                        }else if tipo_entrega_result == "audio"{
                            entrega_audio.isHidden=false
                            entrega_imagen.isHidden = true
                            entrega_video.isHidden = true
                            entrega_exitosa.isHidden = true
                            // Configurar el botón btn_video para mostrar el menú
                            btn_audio.addTarget(self, action: #selector(presentAudioOptions), for: .touchUpInside)
                        }
                    }else{
                        entrega_audio.isHidden=true
                        entrega_imagen.isHidden = true
                        entrega_video.isHidden = true
                        entrega_exitosa.isHidden = false
                    }
                }
            } catch {
                print("Error al cargar la actividad: \(error)")
            }
        }
        //Mostrar información del modulo seleccionado
        titulo_evidencia.text = titulo_modulo_resultado
        //titulo_modulo.text = modulo_resultado
        //instrucciones.text = instrucciones_actividad
        print("Evidencia del modulo: \(modulo_evidencia)")
    
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
         if UIImagePickerController.isSourceTypeAvailable(.camera) {
             let imagePicker = UIImagePickerController()
             imagePicker.delegate = self
             imagePicker.sourceType = .camera
             
             // Configura para captura de video
             imagePicker.mediaTypes = [kUTTypeMovie as String]
             
             // Puedes configurar otras propiedades aquí, como la calidad del video, la duración máxima, etc.
             
             // Presenta el controlador de captura de video
             present(imagePicker, animated: true, completion: nil)
         } else {
             // La cámara no está disponible en este dispositivo
             // Puedes mostrar un mensaje de error al usuario
             print("La cámara no está disponible en este dispositivo.")
         }
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
    
    func showSuccessView() {
        entrega_imagen.isHidden = true
        entrega_video.isHidden = true
        entrega_audio.isHidden = true
        entrega_exitosa.isHidden = false
    }
    
    // UIImagePickerControllerDelegate method for handling the selected/taken image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let mediaType = info[.mediaType] as? String {
            if mediaType == kUTTypeImage as String {
                // Se seleccionó una imagen
                if let image = info[.originalImage] as? UIImage {
                    selectedImage = image
                    image_selected.image = selectedImage
            
                    Task{
                        do{
                            let datos = try await MultipartRequest.sendEvidence(user: "prueba", activity: "actividad1", evidence_name: "Actividad: \(actividad_modulo) de modulo \(modulo_evidencia)", idModulo: modulo_evidencia, imagen: image_selected.image!)
                            UserDefaults.standard.set(true, forKey: "actividad \(actividad_modulo) modulo \(modulo_evidencia)")
                            print("Image upload completed successfully")
                            showSuccessView()
                            let controller = UserProgressUpdateController()
                            try await controller.updateProgress(estadoActividad: false, estadoModulo: true, idUsuario: idusar, idActividad: actividad_modulo, idModulo: modulo_evidencia)
                        }catch{
                            print("Error sending image: \(error.localizedDescription)")
                        }
                    }
                }
            } else if mediaType == kUTTypeMovie as String {
                // Se seleccionó un video
                if let videoURL = info[.mediaURL] as? URL {
                    selectedVideoURL = videoURL
                    let videoPath = videoURL.path // Obtenemos la ruta del archivo desde la URL
                    
                    Task{
                        do{
                            let datos = try await MultipartRequestVideo.sendEvidence(user: "prueba", activity: "actividad1", evidenceName: "Actividad: \(actividad_modulo) de modulo \(modulo_evidencia)", idModulo: modulo_evidencia, videoPath: videoPath)
                            UserDefaults.standard.set(true, forKey: "actividad \(actividad_modulo) modulo \(modulo_evidencia)")
                            print("Video upload completed successfully")
                            showSuccessView()
                            let controller = UserProgressUpdateController()
                            try await controller.updateProgress(estadoActividad: false, estadoModulo: true, idUsuario: idusar, idActividad: actividad_modulo, idModulo: modulo_evidencia)
                        }catch{
                            print("Error sending video: \(error.localizedDescription)")
                        }
                    }
                }
            } else if mediaType == kUTTypeAudio as String {
                // Handle selected audio
                if let audioURL = info[.mediaURL] as? URL {
                    // Send the selected audio as a multipart request
                    Task {
                        do {
                            let audioData = try Data(contentsOf: audioURL)

                            let datos = try await MultipartRequestAudio.sendAudioEvidence(user: "prueba", activity: "actividad1",evidenceName: "Actividad: \(actividad_modulo) de modulo \(modulo_evidencia)", idModulo: modulo_evidencia, audioData: audioData)
                            print("actividad_modulo: \(actividad_modulo)")
                            print("modulo_evidencia: \(modulo_evidencia)")
                            UserDefaults.standard.set(true, forKey: "actividad \(actividad_modulo) modulo \(modulo_evidencia)")
                            print("Audio upload completed successfully")
                            showSuccessView()
                            let controller = UserProgressUpdateController()
                            try await controller.updateProgress(estadoActividad: false, estadoModulo: true, idUsuario: idusar, idActividad: actividad_modulo, idModulo: modulo_evidencia)
                        } catch {
                            print("Error sending audio: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }

        // Cierra el controlador de selección de medios
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Función para tomar una foto
    func recordAudio() {
    }
    
    // Función para seleccionar un video de la galería
    func pickVideoFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = ["public.movie"] // Especifica que deseas seleccionar videos
        present(imagePicker, animated: true, completion: nil)
    }

    
    // Función para seleccionar una imagen de la galería
    func pickImageFromLibrary() {
        let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = ["public.image"] // Especifica que deseas seleccionar imágenes
            present(imagePicker, animated: true, completion: nil)
    }
    
    // Función para seleccionar un archivo de audio de la galería
    func pickAudioFromLibrary() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.audio], asCopy: true)
            documentPicker.delegate = self
            documentPicker.allowsMultipleSelection = false // Si solo se permite seleccionar un archivo

            present(documentPicker, animated: true, completion: nil)
    }

    // Delegate method for UIDocumentPickerViewController
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let audioURL = urls.first {
                // Aquí puedes usar audioURL para acceder al archivo de audio seleccionado
                // Por ejemplo, puedes copiarlo a una ubicación de tu aplicación o procesarlo de alguna otra manera
                do {
                    // Leer el archivo de audio en un Data
                    let audioData = try Data(contentsOf: audioURL)

                    // Guardar el Data en una variable o en otro lugar según tus necesidades
                    // En este ejemplo, lo guardamos en una propiedad selectedAudioData
                    self.selectedAudioData = audioData

                    // También puedes guardar la URL si la necesitas para reproducir o cargar el audio
                    self.selectedAudioURL = audioURL

                    // Send the selected audio data to your server using MultipartRequestAudio
                    Task {
                        do {
                            // Specify the user, activity, evidenceName, and idModulo as needed
                            let _ = try await MultipartRequestAudio.sendAudioEvidence(user: "prueba", activity: "actividad1", evidenceName: "Actividad: \(actividad_modulo) de modulo \(modulo_evidencia)", idModulo: 5, audioData: audioData)
                            print("Audio upload completed successfully")
                            UserDefaults.standard.set(true, forKey: "actividad \(actividad_modulo) modulo \(modulo_evidencia)")
                            showSuccessView()
                            let controller = UserProgressUpdateController()
                            try await controller.updateProgress(estadoActividad: false, estadoModulo: true, idUsuario: idusar, idActividad: actividad_modulo, idModulo: modulo_evidencia)
                        } catch {
                            print("Error sending audio data: \(error.localizedDescription)")
                        }
                    }

                    print(audioURL)

                    // Puedes realizar otras acciones necesarias aquí con el audio
                } catch {
                    print("Error al leer el archivo de audio: \(error.localizedDescription)")
                }
            }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
