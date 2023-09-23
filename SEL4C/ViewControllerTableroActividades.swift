//
//  ViewControllerTableroActividades.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 22/09/23.
//

import UIKit

class ViewControllerTableroActividades: UIViewController {
    
    @IBOutlet weak var stack_view: UIStackView!
    
    @IBOutlet weak var view_prueba: UIView!
    
    @IBOutlet weak var btn_actividad4: UIButton!
    @IBOutlet weak var label_actividad4: UILabel!
    @IBOutlet weak var estado_actividad4: UILabel!
    @IBOutlet weak var foco_actividad4: UIButton!
    
    let actividades: [[String: Any]] = [
        [
            "id_actividad": 1,
            "titulo": "Actividad 1",
            "imagen": "act1.png",
            "descripcion": "El propósito de esta actividad es ayudarte a identificar problemáticas sociales o ambientales dentro de tu entorno."
        ],
        [
            "id_actividad": 2,
            "titulo": "Actividad 2",
            "imagen": "act2.png",
            "descripcion": "Descripción de otra actividad"
        ],
        [
            "id_actividad": 3,
            "titulo": "Actividad 3",
            "imagen": "act3.png",
            "descripcion": "Descripción de otra actividad más"
        ],
        [
            "id_actividad": 4,
            "titulo": "Actividad 4",
            "imagen": "act4.png",
            "descripcion": "Descripción de la última actividad"
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view_prueba.isHidden = true
        configureButton(btn_actividad4)
        configureLabel(label_actividad4)
        configureEstado(estado_actividad4)
        configureEstadobtn(foco_actividad4)

        for actividad in actividades {
            if let _ = actividad["id_actividad"] as? Int,
                   let titulo = actividad["titulo"] as? String,
               let _ = actividad["imagen"] as? String,
               let _ = actividad["descripcion"] as? String {
                //Creando la view a agregar al stack
                let containerView = UIView()
                containerView.translatesAutoresizingMaskIntoConstraints = false
                containerView.widthAnchor.constraint(equalToConstant: 393).isActive = true
                containerView.heightAnchor.constraint(equalToConstant: 213.67).isActive = true
                
                // Crear el titutlo a agregar al view
                let label = UILabel()
                label.text = "   \(titulo)"
                label.translatesAutoresizingMaskIntoConstraints = false
                configureLabel(label)
                
                //Crear el button a agregar al view
                let nuevoBoton = UIButton()
                if let backgroundImage = UIImage(named: "imagen_actividad1") {
                    nuevoBoton.setBackgroundImage(backgroundImage, for: .normal)
                }
                configureButton(nuevoBoton)
                
                //Crear el estado a agregar al view
                let nuevo_estado = UILabel()
                nuevo_estado.text = "En progreso"
                nuevo_estado.translatesAutoresizingMaskIntoConstraints = false
                configureEstado(nuevo_estado)
                
                //Crear el foco de estado a agregar al view
                let nuevo_foco = UIButton()
                nuevo_foco.backgroundColor = UIColor.blue
                configureEstadobtn(nuevo_foco)
                
                //Añadir elementos a view
                containerView.addSubview(nuevoBoton)
                containerView.addSubview(label)
                containerView.addSubview(nuevo_foco)
                containerView.addSubview(nuevo_estado)
                
                
                //Añadir view a stack
                stack_view.addArrangedSubview(containerView)
                
                //Constraints de elementos
                label.translatesAutoresizingMaskIntoConstraints = false
                nuevoBoton.translatesAutoresizingMaskIntoConstraints = false
                nuevo_estado.translatesAutoresizingMaskIntoConstraints = false
                nuevo_foco.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 34), // Leading + 34
                    label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -11.33), // Bottom + 11.33
                    label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -34), // Trailing + 34
                    label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 159),
                    nuevoBoton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
                    nuevoBoton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -14),
                    nuevoBoton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 34),
                    nuevoBoton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -34),
                    nuevo_estado.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 169),
                    nuevo_estado.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -22.33),
                    nuevo_estado.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 275),
                    nuevo_estado.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -34),
                    nuevo_foco.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 173),
                    nuevo_foco.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -26.67),
                    nuevo_foco.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 255),
                    nuevo_foco.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -126),
                ])
                
                // Configurar la acción de navegación para el botón
                nuevoBoton.addTarget(self, action: #selector(navegarAActividad1), for: .touchUpInside)
            }
        }
    }
    
    @objc func navegarAActividad1() {
        // Obtener una referencia al ViewController "Actividad1"
        if let actividad1VC = self.storyboard?.instantiateViewController(withIdentifier: "Actividad1") {
            // Presentar el ViewController "Actividad1" modally
            actividad1VC.modalPresentationStyle = .fullScreen
            self.present(actividad1VC, animated: true, completion: nil)
        }
    }

    
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
    
    func configureEstado(_ estado: UILabel){
        estado.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1.0)
        estado.font = UIFont(name: "Poppins-Regular", size: 13.0)
        estado.widthAnchor.constraint(equalToConstant: 84).isActive = true
        estado.heightAnchor.constraint(equalToConstant: 22.33).isActive = true
    }
    
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
        // Pass the selected object to the new view controller.
    }
    */

}
