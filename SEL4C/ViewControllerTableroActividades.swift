//
//  ViewControllerTableroActividades.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 22/09/23.
//

import UIKit

class ViewControllerTableroActividades: UIViewController {
    
    //Stack de lo mostrado en scroll view
    @IBOutlet weak var stack_view: UIStackView!
    
    //View de vista de diseño (prueba visual)
    @IBOutlet weak var view_prueba: UIView!
    
    //Componente de la view de vista de diseño (prueba visual)
    @IBOutlet weak var btn_actividad4: UIButton!
    @IBOutlet weak var label_actividad4: UILabel!
    @IBOutlet weak var estado_actividad4: UILabel!
    @IBOutlet weak var foco_actividad4: UIButton!
    
    //Variable para guardar el id de la actividad a presentar
    var show_activity: Int = 0

    /*
    //JSON de las actividades (prueba)
    let actividades: [[String: Any]] = [
        [
            "id_actividad": 1,
            "titulo": "Identificación",
            "imagen": "act1.png",
            "descripcion": "El propósito de esta actividad es ayudarte a identificar problemáticas sociales o ambientales dentro de tu entorno."
        ],
        [
            "id_actividad": 2,
            "titulo": "Investigación",
            "imagen": "act2.png",
            "descripcion": "El propósito de esta actividad es conocer acerca de los Objetivos de Desarrollo Sostenible y su relación con problemáticas locales y externas."
        ],
        [
            "id_actividad": 3,
            "titulo": "Actividad 3",
            "imagen": "act3.png",
            "descripcion": "El objetivo general de esta actividad es investigar y reflexionar sobre acciones concretas que se están llevando a cabo a nivel internacional, nacional o local para abordar un problema específico que has elegido"
        ],
        [
            "id_actividad": 4,
            "titulo": "Actividad 4",
            "imagen": "act4.png",
            "descripcion": "El objetivo general de esta actividad es recibir retroalimentación sobre una propuesta de solución a un problema social. Para lograr este objetivo, debes realizar una entrevista con una persona que pueda ofrecer comentarios sobre tu propuesta"
        ]
    ]*/
    
    var actividades_json: [Actividad] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            do {
                actividades_json = try await Actividad.fetchActividades()
                for actividad_json in actividades_json {
                    print("ID actividad: \(actividad_json.id_actividad)")
                    print("Título actividad: \(actividad_json.titulo)")
                    if let imagen = actividad_json.imagen {
                        print("Imagen actividad: \(actividad_json)")
                    } else {
                        print("Imagen: No disponible")
                    }
                    print("Descripción actividad: \(actividad_json.descripcion)")
                    print("------------------------")
                    
                    //Creando una view para agregar al stack con los elementos del JSON
                    let containerView = UIView()
                    containerView.translatesAutoresizingMaskIntoConstraints = false
                    containerView.widthAnchor.constraint(equalToConstant: 393).isActive = true
                    containerView.heightAnchor.constraint(equalToConstant: 213.67).isActive = true
                    
                    // Crear el titutlo de la actividad
                    let label = UILabel()
                    label.text = "   \(actividad_json.titulo)"
                    label.translatesAutoresizingMaskIntoConstraints = false
                    configureLabel(label)
                    
                    //Crear el button de la actividad
                    let nuevoBoton = UIButton()
                    if let backgroundImage = UIImage(named: "imagen_actividad1") {
                        nuevoBoton.setBackgroundImage(backgroundImage, for: .normal)
                    }
                    configureButton(nuevoBoton)
                    
                    //Crear el button
                    let buttonN = UIButton()
                    configureButtonNormal(nuevoBoton)
                    
                    //Crear el estado de la actividad
                    let nuevo_estado = UILabel()
                    nuevo_estado.text = "En progreso"
                    nuevo_estado.translatesAutoresizingMaskIntoConstraints = false
                    configureEstado(nuevo_estado)
                    
                    //Crear el foco de estado de la actividad
                    let nuevo_foco = UIButton()
                    nuevo_foco.backgroundColor = UIColor.blue
                    configureEstadobtn(nuevo_foco)
                    
                    //Añadir elementos a view
                    containerView.addSubview(nuevoBoton)
                    containerView.addSubview(label)
                    containerView.addSubview(buttonN)
                    containerView.addSubview(nuevo_foco)
                    containerView.addSubview(nuevo_estado)
                    
                    //Añadir view a stack
                    stack_view.addArrangedSubview(containerView)
                    
                    //Constraints de elementos
                    label.translatesAutoresizingMaskIntoConstraints = false
                    nuevoBoton.translatesAutoresizingMaskIntoConstraints = false
                    nuevo_estado.translatesAutoresizingMaskIntoConstraints = false
                    nuevo_foco.translatesAutoresizingMaskIntoConstraints = false
                    buttonN.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([
                        nuevoBoton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 34),
                        nuevoBoton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
                        nuevoBoton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -14),
                        nuevoBoton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -34),
                        label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 34),
                        label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -11.33),
                        label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -34),
                        label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 159),
                        buttonN.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 163),
                        buttonN.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 34),
                        buttonN.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15.67),
                        nuevo_foco.leadingAnchor.constraint(equalTo: buttonN.trailingAnchor, constant: 8),
                        nuevo_foco.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -27.67),
                        nuevo_foco.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 174),
                        nuevo_foco.trailingAnchor.constraint(equalTo: nuevo_estado.leadingAnchor, constant: -8),
                        nuevo_estado.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 169),
                        nuevo_estado.leadingAnchor.constraint(equalTo: nuevo_foco.trailingAnchor, constant: -8),
                        nuevo_estado.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -22.33),
                        nuevo_estado.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -34),
                    ])
                    
                    // Añadir navegación a button para mostrar modulos
                    nuevoBoton.tag = actividad_json.id_actividad // Asignar el ID de la actividad como tag del button
                    
                    //Asignar funcion para hacer la navegacion
                    nuevoBoton.addTarget(self, action: #selector(navegarAActividad1(_:)), for: .touchUpInside)
                }
            } catch {
                print("Error al obtener las actividades: \(error.localizedDescription)")
            }
        }
        
        //Vista de prueba
        view_prueba.isHidden = true
        configureButton(btn_actividad4)
        configureLabel(label_actividad4)
        configureEstado(estado_actividad4)
        configureEstadobtn(foco_actividad4)
        
        /*
        //Recorrer JSON para agregar view con elementos
        for actividad in actividades {
            if let idActividad = actividad["id_actividad"] as? Int,
               let _ = actividad["titulo"] as? String,
               let _ = actividad["imagen"] as? String,
               let _ = actividad["descripcion"] as? String {
                
                //Creando una view para agregar al stack con los elementos del JSON
                let containerView = UIView()
                containerView.translatesAutoresizingMaskIntoConstraints = false
                containerView.widthAnchor.constraint(equalToConstant: 393).isActive = true
                containerView.heightAnchor.constraint(equalToConstant: 213.67).isActive = true
                
                // Crear el titutlo de la actividad
                let label = UILabel()
                label.text = "   Actividad \(idActividad)"
                label.translatesAutoresizingMaskIntoConstraints = false
                configureLabel(label)
                
                //Crear el button de la actividad
                let nuevoBoton = UIButton()
                if let backgroundImage = UIImage(named: "imagen_actividad1") {
                    nuevoBoton.setBackgroundImage(backgroundImage, for: .normal)
                }
                configureButton(nuevoBoton)
                
                //Crear el button
                let buttonN = UIButton()
                configureButtonNormal(nuevoBoton)
                
                //Crear el estado de la actividad
                let nuevo_estado = UILabel()
                nuevo_estado.text = "En progreso"
                nuevo_estado.translatesAutoresizingMaskIntoConstraints = false
                configureEstado(nuevo_estado)
                
                //Crear el foco de estado de la actividad
                let nuevo_foco = UIButton()
                nuevo_foco.backgroundColor = UIColor.blue
                configureEstadobtn(nuevo_foco)
                
                //Añadir elementos a view
                containerView.addSubview(nuevoBoton)
                containerView.addSubview(label)
                containerView.addSubview(buttonN)
                containerView.addSubview(nuevo_foco)
                containerView.addSubview(nuevo_estado)
                
                //Añadir view a stack
                stack_view.addArrangedSubview(containerView)
                
                //Constraints de elementos
                label.translatesAutoresizingMaskIntoConstraints = false
                nuevoBoton.translatesAutoresizingMaskIntoConstraints = false
                nuevo_estado.translatesAutoresizingMaskIntoConstraints = false
                nuevo_foco.translatesAutoresizingMaskIntoConstraints = false
                buttonN.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    nuevoBoton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 34),
                    nuevoBoton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
                    nuevoBoton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -14),
                    nuevoBoton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -34),
                    label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 34),
                    label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -11.33),
                    label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -34),
                    label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 159),
                    buttonN.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 163),
                    buttonN.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 34),
                    buttonN.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15.67),
                    nuevo_foco.leadingAnchor.constraint(equalTo: buttonN.trailingAnchor, constant: 8),
                    nuevo_foco.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -27.67),
                    nuevo_foco.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 174),
                    nuevo_foco.trailingAnchor.constraint(equalTo: nuevo_estado.leadingAnchor, constant: -8),
                    nuevo_estado.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 169),
                    nuevo_estado.leadingAnchor.constraint(equalTo: nuevo_foco.trailingAnchor, constant: -8),
                    nuevo_estado.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -22.33),
                    nuevo_estado.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -34),
                ])
                
                // Añadir navegación a button para mostrar modulos
                nuevoBoton.tag = idActividad // Asignar el ID de la actividad como tag del button
                
                //Asignar funcion para hacer la navegacion
                nuevoBoton.addTarget(self, action: #selector(navegarAActividad1(_:)), for: .touchUpInside)
            }
        }*/
    }
    
    //Funcion para hacer la navegación de las actividades a la vista de modulos
    @objc func navegarAActividad1(_ sender: UIButton) {
        // Almacena el tag del botón presionado en la variable de reconocimiento
        show_activity = sender.tag

        // Imprime el tag del botón presionado
        print("Tag del botón presionado: \(show_activity)")

        // Dado el btn seleccionado pasar el id de la actividad para mostrar sus modulos
        if let actividad1VC = self.storyboard?.instantiateViewController(withIdentifier: "Modulos") as? ViewControllerModulos {
            
            // Pasa el valor del ID de la actividad
            actividad1VC.show_activity_results = show_activity
            
            /*
            // Filtrar el arreglo para obtener actividades con id_actividad de la actividad seleccionada
            let actividadesFiltradas = actividades.filter { actividad in
                if let id = actividad["id_actividad"] as? Int {
                    actividad1VC.actual_activity_results = id
                    return id == show_activity
                }
                return false
            }

            // Mandar información de la actividad seleccionada
            for actividad in actividadesFiltradas {
                if let titulo = actividad["titulo"] as? String,
                   let _ = actividad["imagen"] as? String,
                   let descripcion = actividad["descripcion"] as? String {
                    actividad1VC.titulo = titulo
                    actividad1VC.desc = descripcion
                }
            }*/
            
            // Presentar la view de modulos
            //actividad1VC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(actividad1VC, animated: true)
            //self.present(actividad1VC, animated: true, completion: nil)
        }
    }
    
    //Estilos del button
    func configureButtonNormal(_ button: UIButton){
        button.widthAnchor.constraint(equalToConstant: 213).isActive = true
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    //Estilos del button de la actividad
    func configureButton(_ button: UIButton){
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.widthAnchor.constraint(equalToConstant: 325).isActive = true
        button.heightAnchor.constraint(equalToConstant: 187.67).isActive = true
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
    }
    
    //Estulos del label de la actividad
    func configureLabel(_ label: UILabel){
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowOpacity = 0.5
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.shadowRadius = 4
        /*
        let maskLayer = CAShapeLayer()
        maskLayer.frame = label.bounds
        maskLayer.path = UIBezierPath(
            roundedRect: label.bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: 10, height: 10)
        ).cgPath
        label.layer.mask = maskLayer*/
        
        label.backgroundColor = UIColor.white
        label.textColor = UIColor.black
        label.font = UIFont(name: "Poppins-Medium", size: 17.0)
        label.heightAnchor.constraint(equalToConstant: 41).isActive = true
        label.widthAnchor.constraint(equalToConstant: 325).isActive = true
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
    }
    
    //Estilos del label de estado de la actividad
    func configureEstado(_ estado: UILabel){
        estado.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1.0)
        estado.font = UIFont(name: "Poppins-Regular", size: 13.0)
        estado.widthAnchor.constraint(equalToConstant: 84).isActive = true
        estado.heightAnchor.constraint(equalToConstant: 22.33).isActive = true
    }
    
    //Estilos del foco de estado de la actividad
    func configureEstadobtn(_ estadobtn: UIButton){
        estadobtn.backgroundColor = UIColor.gray
        estadobtn.widthAnchor.constraint(equalToConstant: 12).isActive = true
        estadobtn.heightAnchor.constraint(equalToConstant: 12).isActive = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
    }*/

}
