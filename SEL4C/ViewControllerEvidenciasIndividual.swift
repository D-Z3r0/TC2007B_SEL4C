//
//  ViewControllerEvidenciasIndividual.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 24/09/23.
//

import UIKit
import MobileCoreServices
import AVFoundation
import WebKit
import MapKit

class ViewControllerEvidenciasIndividual: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate,AVAudioRecorderDelegate, UIGestureRecognizerDelegate, WKNavigationDelegate,UISearchBarDelegate, MKLocalSearchCompleterDelegate{
    
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
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    @IBOutlet weak var subtitleTextField: UITextView!
    
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var viewMap: MKMapView!
    var annotations: [MKPointAnnotation] = []
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    @IBOutlet weak var view_searchmap: UIView!
    @IBOutlet weak var view_descriptionmap: UIView!
    var getUser = Users()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self
        searchCompleter.delegate = self
        let defaults = UserDefaults.standard
        let userID = defaults.integer(forKey: "ID")
        idusar = userID
        
        Task{
            do{
                getUser = try await Users.getUser()
            }
            
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
                            view_searchmap.isHidden = true
                            view_descriptionmap.isHidden = true
                            // Configurar el botón btn_video para mostrar el menú
                            btn_video.addTarget(self, action: #selector(presentVideoOptions), for: .touchUpInside)
                        }else if tipo_entrega_result == "imagen"{
                            entrega_imagen.isHidden = false
                            entrega_video.isHidden = true
                            entrega_audio.isHidden = true
                            entrega_exitosa.isHidden = true
                            view_searchmap.isHidden = true
                            view_descriptionmap.isHidden = true
                            // Configurar el botón btn_video para mostrar el menú
                            btn_imagen.addTarget(self, action: #selector(presentImageOptions), for: .touchUpInside)
                        }else if tipo_entrega_result == "audio"{
                            entrega_audio.isHidden=false
                            entrega_imagen.isHidden = true
                            entrega_video.isHidden = true
                            entrega_exitosa.isHidden = true
                            view_searchmap.isHidden = true
                            view_descriptionmap.isHidden = true
                            // Configurar el botón btn_video para mostrar el menú
                            btn_audio.addTarget(self, action: #selector(presentAudioOptions), for: .touchUpInside)
                        }
                        
                        if modulo.id_modulo == 3 {
                            entrega_imagen.isHidden = false
                            entrega_video.isHidden = true
                            entrega_audio.isHidden = true
                            entrega_exitosa.isHidden = true
                            view_searchmap.isHidden = false
                            view_descriptionmap.isHidden = false
                            // Configurar el botón btn_video para mostrar el menú
                            btn_imagen.addTarget(self, action: #selector(presentImageOptions), for: .touchUpInside)
                        }
                        
                        if modulo.id_modulo == 4{
                            entrega_imagen.isHidden = false
                            entrega_video.isHidden = true
                            entrega_audio.isHidden = true
                            entrega_exitosa.isHidden = true
                            view_searchmap.isHidden = false
                            view_descriptionmap.isHidden = false
                            // Configurar el botón btn_video para mostrar el menú
                            btn_imagen.addTarget(self, action: #selector(presentImageOptions), for: .touchUpInside)
                        }
                    }else{
                        entrega_audio.isHidden=true
                        entrega_imagen.isHidden = true
                        entrega_video.isHidden = true
                        entrega_exitosa.isHidden = false
                        view_searchmap.isHidden = true
                        view_descriptionmap.isHidden = true
                    }
                }
            } catch {
                print("Error al cargar la actividad: \(error)")
            }
        }
        //Mostrar información del modulo seleccionado
        titulo_evidencia.text = titulo_modulo_resultado
        print("Evidencia del modulo: \(modulo_evidencia)")
    
    }
    
    // Método llamado cuando el usuario presiona el botón de búsqueda en el teclado virtual
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Cerrar el teclado virtual
        searchBar.resignFirstResponder()
        
        // Comprobar si se seleccionó una sugerencia de autocompletado
        if let selectedResult = searchResults.first {
            // Crear una solicitud de búsqueda local con la sugerencia seleccionada
            let request = MKLocalSearch.Request(completion: selectedResult)
            let search = MKLocalSearch(request: request)
            
            // Realizar la búsqueda y manejar los resultados
            search.start { (response, error) in
                if let error = error {
                    print("Error en la búsqueda: \(error.localizedDescription)")
                } else if let mapItems = response?.mapItems, let firstItem = mapItems.first {
                    // Obtener las coordenadas del lugar encontrado
                    let coordinates = firstItem.placemark.coordinate
                                        // Imprimir las coordenadas en la consola
                                        print("Latitud: \(coordinates.latitude), Longitud: \(coordinates.longitude)")
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
                    annotation.title = "Ubicación personalizada"
                    // Asignar el subtítulo ingresado por el usuario
                    annotation.subtitle = self.subtitleTextField.text
                    
                    // Agregar la nueva anotación al array de anotaciones
                    self.annotations.append(annotation)
                    
                    // Agregar todas las anotaciones al mapa
                    self.viewMap.addAnnotations(self.annotations)
                    
                    // Establecer el nivel de zoom para mostrar todas las anotaciones
                    self.viewMap.showAnnotations(self.annotations, animated: true)
                    /*
                    // Crear un marcador en el mapa
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinates
                    annotation.title = firstItem.name
                    
                    // Borrar marcadores anteriores y agregar el nuevo
                    self.viewMap.removeAnnotations(self.viewMap.annotations)
                    self.viewMap.addAnnotation(annotation)
                    
                    // Ajustar el mapa para mostrar el marcador
                    let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 1000, longitudinalMeters: 1000)
                    self.viewMap.setRegion(region, animated: true)*/
                }
            }
        }
    }

    // Método llamado cuando cambia el texto en el campo de búsqueda
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Actualizar las sugerencias de autocompletado en función del texto actual
        searchCompleter.queryFragment = searchText
    }

    // Método llamado cuando se obtienen resultados de autocompletado
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
    }

// Método llamado cuando se presiona el botón para guardar la captura del mapa
    @IBAction func saveMapScreenshot(_ sender: UIButton) {
        // Crear un renderizador de gráficos
        let renderer = UIGraphicsImageRenderer(size: viewMap.bounds.size)
        
        // Capturar el contenido del mapa como una imagen
        let image = renderer.image { _ in
            viewMap.drawHierarchy(in: viewMap.bounds, afterScreenUpdates: true)
        }
        
        // Guardar la imagen en la galería de fotos (puedes cambiar esto según tus necesidades)
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        // Añadir una alerta para informar al usuario que la captura se guardó con éxito
        let alertController = UIAlertController(title: "Mapa guardado", message: "La captura del mapa se ha guardado en la galería de fotos.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Entendido", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
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
        view_descriptionmap.isHidden = true
        view_searchmap.isHidden = true
    }
    
    // UIImagePickerControllerDelegate method for handling the selected/taken image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Configurar el activityIndicator
            activityIndicator.center = view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = .large
            activityIndicator.color = .blue
            view.addSubview(activityIndicator)
            
            // Comenzar la animación del activityIndicator
            activityIndicator.startAnimating()
        
        if let mediaType = info[.mediaType] as? String {
            if mediaType == kUTTypeImage as String {
                // Se seleccionó una imagen
                if let image = info[.originalImage] as? UIImage {
                    selectedImage = image
                    image_selected.image = selectedImage
            
                    Task{
                        do{
                            let datos = try await MultipartRequest.sendEvidence(user: "prueba", activity: "actividad1", evidence_name: "Usuario \(getUser.email) Actividad: \(actividad_modulo) de modulo \(modulo_evidencia)", idModulo: modulo_evidencia, imagen: image_selected.image!)
                            UserDefaults.standard.set(true, forKey: "actividad \(actividad_modulo) modulo \(modulo_evidencia)")
                            print("Image upload completed successfully")
                            DispatchQueue.main.async {
                                                    self.activityIndicator.stopAnimating()
                                                    self.activityIndicator.removeFromSuperview()
                                                }
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
                            let datos = try await MultipartRequestVideo.sendEvidence(user: "prueba", activity: "actividad1", evidenceName: "Usuario \(getUser.email) Actividad: \(actividad_modulo) de modulo \(modulo_evidencia)", idModulo: modulo_evidencia, videoPath: videoPath)
                            UserDefaults.standard.set(true, forKey: "actividad \(actividad_modulo) modulo \(modulo_evidencia)")
                            print("Video upload completed successfully")
                            DispatchQueue.main.async {
                                                    self.activityIndicator.stopAnimating()
                                                    self.activityIndicator.removeFromSuperview()
                                                }
                            showSuccessView()
                            let controller = UserProgressUpdateController()
                            try await controller.updateProgress(estadoActividad: false, estadoModulo: true, idUsuario: idusar, idActividad: actividad_modulo, idModulo: modulo_evidencia)
                        }catch{
                            print("Error sending video: \(error.localizedDescription)")
                        }
                    }
                }
            } else if mediaType == kUTTypeMovie as String {
                if let videoURL = info[.mediaURL] as? URL {
                    // Aquí puedes usar videoURL para acceder al video seleccionado
                    // Por ejemplo, puedes cargarlo a tu servidor o realizar otras acciones necesarias
                    do {
                        let videoPath = videoURL.path // Obtenemos la ruta del archivo desde la URL

                        // Envía el video a tu servidor utilizando MultipartRequestVideo u otra lógica que tengas
                        Task {
                            do {
                                let datos = try await MultipartRequestVideo.sendEvidence(user: "prueba", activity: "actividad1", evidenceName: "Usuario \(getUser.email) Actividad: \(actividad_modulo) de modulo \(modulo_evidencia)", idModulo: modulo_evidencia, videoPath: videoPath)
                                UserDefaults.standard.set(true, forKey: "actividad \(actividad_modulo) modulo \(modulo_evidencia)")
                                print("Video upload completed successfully")
                                DispatchQueue.main.async {
                                                        self.activityIndicator.stopAnimating()
                                                        self.activityIndicator.removeFromSuperview()
                                                    }
                                showSuccessView()
                                let controller = UserProgressUpdateController()
                                try await controller.updateProgress(estadoActividad: false, estadoModulo: true, idUsuario: idusar, idActividad: actividad_modulo, idModulo: modulo_evidencia)
                            } catch {
                                print("Error sending video: \(error.localizedDescription)")
                            }
                        }

                        // Realiza otras acciones necesarias con el video
                        print(videoURL)
                    } catch {
                        print("Error al obtener la ruta del video: \(error.localizedDescription)")
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
        // Configurar el activityIndicator
            activityIndicator.center = view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = .large
            view.addSubview(activityIndicator)
            
            // Comenzar la animación del activityIndicator
            activityIndicator.startAnimating()
        
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
                            let audioData = try Data(contentsOf: audioURL)
                            // Specify the user, activity, evidenceName, and idModulo as needed
                            let datos = try await MultipartRequestAudio.sendAudioEvidence(user: "prueba", activity: "actividad1", evidenceName: "Usuario \(getUser.email) Actividad: \(actividad_modulo) de modulo \(modulo_evidencia)", idModulo: 5, audioData: audioData)
                            print("Audio upload completed successfully")
                            DispatchQueue.main.async {
                                                    self.activityIndicator.stopAnimating()
                                                    self.activityIndicator.removeFromSuperview()
                                                }
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
