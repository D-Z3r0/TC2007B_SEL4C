//
//  ViewControllerModulosIndividual.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 23/09/23.
//

import UIKit

class ViewControllerModulosIndividual: UIViewController {
    //Stack de lo mostrado en scroll view
    @IBOutlet weak var stack_view: UIStackView!
    
    //Variable para guardar el id del modulo a presentar
    var show_module: Int = 0
    var modulo_actual: Int = 0
    
    //Valores pasado de la información de la actividad seleccionada
    var titulo_actividad_resultado: String = ""
    var actividad_resultado: String = ""
    var description_actividad: String = ""
    var activity_modules: Int = 0
    
    //Componente fijos con cambio de contenido
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var titulo_actividad: UILabel!
    @IBOutlet weak var descripcion_acti: UILabel!
    @IBOutlet weak var label_cantidad_modulos: UILabel!
    
    //View de vista de diseño (prueba visual)
    @IBOutlet weak var view_prueba: UIView!
    
    //Componente de la view de vista de diseño (prueba visual)
    @IBOutlet weak var btn_ev1: UIButton!
    @IBOutlet weak var btn_estado_ev1: UIButton!
    @IBOutlet weak var label_btn_ev1: UILabel!
    @IBOutlet weak var image_row_ev1: UIImageView!
    
    var actividadIndividual: Actividad_individual?
    var modulos_json: [Modulo] = []
    var processedCombinations = Set<String>()
    var ProgresosUsuarios_json: [ProgresoUsuario] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        let controller = UserProgressActivities()
        
        Task{
            do {
                try await controller.putProgressForUser(idUsuario: 1, actividad1: false, actividad2: true, actividad3: false, actividad4: false)
                print("Actualización exitosa")
            }catch {
                print("Error desconocido: \(error)")
            }
        }*/
        
        Task{
            do {
                actividadIndividual = try await Actividad.fetchActividadesDetail(id_actividad: activity_modules)

                if let actividad = actividadIndividual {
                    print("Actividad cargada con éxito: \(actividad)")
                    titulo.text = "   Actividad \(actividad.id_actividad)"
                    descripcion_acti.text = actividad.descripcion
                    titulo_actividad.text = actividad.titulo
                }
            } catch {
                print("Error al cargar la actividad: \(error)")
            }
            
            do {
                modulos_json = try await Modulo.fetchModulos(id_actividad: activity_modules)
                for actividad_json in modulos_json {
                    /*
                     // Crear una instancia de UserProgressActivities
                     let userProgress = UserProgressController()
                     
                     // Llamar a la función postProgressForUser con datos de ejemplo
                     do {
                     try await userProgress.postProgressForUser(
                     idUsuario: 1,
                     idActividad: actividad_json.id_actividad,
                     idModulo: actividad_json.id_modulo,
                     estadoActividad: false,
                     estadoModulo: false
                     )
                     print("Solicitud exitosa") // Esto se imprimirá si la solicitud es exitosa
                     } catch {
                     print("Error al realizar la solicitud: \(error)") // Manejar errores si ocurren
                     }*/
                    
                    
                    print("ID modulo: \(actividad_json.id_modulo)")
                    print("ID activodad del modulo: \(actividad_json.id_modulo)")
                    print("Titulo modulo: \(actividad_json.titulo_mod)")
                    print("Instrucciones modulo: \(actividad_json.id_actividad)")
                    print(actividad_json.tipo_multimedia)
                    if let imagen = actividad_json.imagen_mod {
                        print("Imagen actividad: \(actividad_json)")
                    } else {
                        print("Imagen: No disponible")
                    }
                    //Creando una view para agregar al stack con los elementos del JSON
                    let containerView = UIView()
                    containerView.translatesAutoresizingMaskIntoConstraints = false
                    containerView.widthAnchor.constraint(equalToConstant: 393).isActive = true
                    containerView.heightAnchor.constraint(equalToConstant: 73).isActive = true
                    
                    // Crear el titutlo del modulo
                    let label = UILabel()
                    label.text = "   \(actividad_json.titulo_mod)"
                    label.translatesAutoresizingMaskIntoConstraints = false
                    configureTitulo(label)
                    
                    // Crear el button del modulo
                    let nuevoBoton = UIButton()
                    configureButton(nuevoBoton)
                    
                    //Crear el foco de estado del modulo
                    let nuevo_foco = UIButton()
                    configureEstadobtn(nuevo_foco)
                    
                    ProgresosUsuarios_json = try await ProgresoUsuario.fetchProgresoUsuarios(id_usuario: 1)
                    
                    let progresosFiltrados = ProgresosUsuarios_json.filter { progreso in
                        return progreso.id_actividad == actividad_json.id_actividad && progreso.estado_modulo == true
                    }
                    
                    for filtrados in progresosFiltrados{
                        if filtrados.id_modulo == actividad_json.id_modulo{
                            nuevo_foco.backgroundColor = UIColor.green
                        }
                    }
                    
                    let progresosFil = ProgresosUsuarios_json.filter { progreso in
                        return progreso.id_actividad == actividad_json.id_actividad
                    }
                    
                    let todosTienenEstadoModuloTrue = progresosFil.allSatisfy { $0.estado_modulo == true }
                    var progreso_json: ProgresoActividad?
                    progreso_json = try await ProgresoActividad.fetchProgresoActividades(id_usuario: 1)
                    
                    if progreso_json?.actividad1 == true && actividad_json.id_actividad == 1{
                        nuevo_foco.backgroundColor = UIColor.green
                    }
                    
                    if todosTienenEstadoModuloTrue {
                        if actividad_json.id_actividad == 2{
                            let controller = UserProgressActivities()
                            Task{
                                do {
                                    try await controller.putProgressForUser(idUsuario: 1, actividad1: false, actividad2: true, actividad3: false, actividad4: false)
                                    print("Actualización exitosa")
                                }catch {
                                    print("Error desconocido: \(error)")
                                }
                            }
                        }
                        print("Todos los elementos tienen estado_modulo en true")
                    } else {
                        print("Al menos un elemento no tiene estado_modulo en true")
                    }


                    //Crear la image de flecha del modulo
                    let nuevo_image = UIImageView()
                    configureImagebtn(nuevo_image)
                    
                    //Añadir elementos a view
                    containerView.addSubview(nuevoBoton)
                    containerView.addSubview(label)
                    containerView.addSubview(nuevo_foco)
                    containerView.addSubview(nuevo_image)
                    
                    
                    //Añadir view a stack
                    stack_view.addArrangedSubview(containerView)
                    
                    //Constraints de elementos
                    label.translatesAutoresizingMaskIntoConstraints = false
                    nuevoBoton.translatesAutoresizingMaskIntoConstraints = false
                    nuevo_foco.translatesAutoresizingMaskIntoConstraints = false
                    nuevo_image.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([
                        label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 25),
                        label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 72),
                        label.trailingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: -89),
                        label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),
                        
                        nuevoBoton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 6),
                        nuevoBoton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 34),
                        nuevoBoton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -34),
                        nuevoBoton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -6),
                        
                        nuevo_foco.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 29),
                        nuevo_foco.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 52),
                        nuevo_foco.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -329),
                        nuevo_foco.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -32),
                        
                        nuevo_image.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 19),
                        nuevo_image.leadingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 312),
                        nuevo_image.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -54),
                        nuevo_image.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -21)
                    ])
                    
                    // Configurar la acción de navegación para el botón
                    nuevoBoton.tag = actividad_json.id_modulo // Asignar el ID de la actividad como tag
                    nuevoBoton.addTarget(self, action: #selector(navegarAEvidencias(_:)), for: .touchUpInside)
                }
            } catch {
                print("Error al cargar el modulo: \(error)")
            }
        }
        
        //Mostrar información de la actividad seleccionada
        //titulo.text = titulo_actividad_resultado
        //titulo_actividad.text = actividad_resultado
        //descripcion_acti.text = description_actividad
        
        print("Modulos de la actividad: \(activity_modules)")
        
        //Vista de prueba
        view_prueba.isHidden = true
        configureButton(btn_ev1)
        configureTitulo(label_btn_ev1)
        configureEstadobtn(btn_estado_ev1)
        configureImagebtn(image_row_ev1)
    }
    
    //Funcion para hacer la navegación de los modulos a la vista de evidencias
    @objc func navegarAEvidencias(_ sender: UIButton) {
            // Almacena el tag del botón presionado en la variable
            show_module = sender.tag

            // Imprime el tag del botón presionado
            print("Modulo seleccionada en tablero: \(show_module)")

            // Obtén una referencia al ViewController "Evidencias"
            if let actividad1VC = self.storyboard?.instantiateViewController(withIdentifier: "Evidencias") as? ViewControllerEvidencias {
                // Pasa el valor del tag al ViewController "Evidencias"
                actividad1VC.show_module_results = show_module
                actividad1VC.show_activity_module_results = activity_modules
                actividad1VC.modulo_actual_results = show_module
                
                // Presenta el ViewController "Evidencias" modally
                //actividad1VC.modalPresentationStyle = .fullScreen
                //self.present(actividad1VC, animated: true, completion: nil)
                navigationController?.pushViewController(actividad1VC, animated: true)
            }
    }
    
    //Estilos de la imagen del modulo
    func configureImagebtn(_ image: UIImageView){
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = UIColor.white
        image.widthAnchor.constraint(equalToConstant: 27).isActive = true
        image.heightAnchor.constraint(equalToConstant: 29.33).isActive = true
    }
    
    //Estilos del btn de estado del modulo
    func configureEstadobtn(_ estadobtn: UIButton){
        estadobtn.backgroundColor = UIColor.gray
        estadobtn.widthAnchor.constraint(equalToConstant: 12).isActive = true
        estadobtn.heightAnchor.constraint(equalToConstant: 12).isActive = true
    }
    
    //Estilos del btn del modulo
    func configureButton(_ button: UIButton){
        button.backgroundColor = UIColor(red: 0/255, green: 48/255, blue: 135/255, alpha: 1.0)
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.widthAnchor.constraint(equalToConstant: 325).isActive = true
        button.heightAnchor.constraint(equalToConstant: 61).isActive = true
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
    }
    
    //Estilos del titulo del modulo
    func configureTitulo(_ label: UILabel){
        label.textColor = UIColor.white
        label.font = UIFont(name: "Poppins-ExtraBold", size: 13.0)
        label.widthAnchor.constraint(equalToConstant: 232).isActive = true
        label.heightAnchor.constraint(equalToConstant: 24).isActive = true
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
