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
    
    //JSON de modulos de actividades (prueba)
    let modulos_actividades: [[String: Any]] = [
        [
            "id_modulo": 1,
            "id_actividad": 1,
            "titulo_mod": "Reflexión Inicial",
            "instrucciones": "Haz una lluvia de ideas sobre problemas sociales o ambientales que se dan en tu entorno. ¿Cuáles identificas? Mínimo deben poder identificar 5 problemáticas. ¿Cómo te afectan estos problemas? ¿Has escuchado que le afecten a alguien cercano? ¿Por qué se consideran un problema? ¿Qué debes entregar? Conclusión de la reflexión inicial",
            "imagen_mod": "act1.png",
            "estado": "c",
            "tipo_multimedia": "video"
        ],
        [
            "id_modulo": 2,
            "id_actividad": 1,
            "titulo_mod": "Entrevista",
            "instrucciones": "Ahora, entrevista a una persona respecto a la misma idea: ¿Qué problemas ambientales o sociales identificas en tu casa, colonia o ciudad o país? ¿Por qué son un problema? ¿Quiénes intervienen en el problema? ¿Te has visto afectado por este problema? ¿Cómo? ¿Qué debes entregar? Conclusión de la entrevista",
            "imagen_mod": "act2.png",
            "estado": "p",
            "tipo_multimedia": "audio"
        ],
        [
            "id_modulo": 3,
            "id_actividad": 1,
            "titulo_mod": "Registro de observaciones",
            "instrucciones": "Por último, has un recorrido por tu colonia o ciudad y registra lo que ves relacionado con la situación ambiental o social. Busca identificar situaciones que no te agraden o problemas ya identificados. ¿Que viste? ¿Dónde lo viste? ¿Había alguien ocasionándolo o atendiéndolo? ¿Qué debes entregar? Tabla con el registro de lo observado",
            "imagen_mod": "act3.png",
            "estado": "i",
            "tipo_multimedia": "imagen"
        ],
        [
            "id_modulo": 4,
            "id_actividad": 2,
            "titulo_mod": "Observaciones",
            "instrucciones": "Reflexiona acerca de los problemas que identificaste en la Actividad 1. Teniéndolos en mente, haz una investigación sobre los Objetivos de Desarrollo Sostenible. Te sugerimos los siguientes enlaces: https://youtu.be/MCKH5xk8X-g. https://www.undp.org/es/sustainable-development-goals Revisa cada uno de los objetivos y sus metas e investiga como es que estos se relacionan con los problemas que identificaste. ¿Cuál es el ODS que consideras se relaciona mejor con cada problematica? ¿Cómo se relaciona con estos temas? ¿Hay alguna meta de dicho ODS que de manera concreta hable de esta relación? ¿Qué debes entregar? Relación entre ODS y problemas ambientales",
            "imagen_mod": "act2_mod1.png",
            "estado": "c",
            "tipo_multimedia": "NA"
        ],
        [
            "id_modulo": 5,
            "id_actividad": 2,
            "titulo_mod": "Problemáticas",
            "instrucciones": "Los ODS nos permiten comprender como es que estas problemáticas son consideradas Retos y Desafíos para todo el Mundo, sin embargo, es importante que podamos conocer cuál es la situación actual. Como segunda parte de esta actividad, te pedimos que de las 5 problemáticas identificadas en la actividad 1, elijas 3 y realices una investigación que responda las siguientes preguntas: ¿Cuál es la situación de estas problemáticas a nivel internacional, regional, nacional y local? ¿Hay registro de afectaciones en la vida de las personas? ¿Qué tanto afecta a tu localidad? Con esta investigación, reflexiona sobre cuál es la problemática que consideras valioso atender. Debes conseguir elegir 1.Para apoyarte en este proceso de elección, te sugerimos considerar: Que sea un problema que afecte directamente a tu entorno Que tenga un impacto en la calidad de vida de las personas Que sea una problemática cercana a nosotros o a alguien que conozcamos ¿Qué debes entregar? Investigación sobre la situación internacional, nacional y local de las problemáticas",
            "imagen_mod": "act2_mod2.png",
            "estado": "p",
            "tipo_multimedia": "video"
        ],
        [
            "id_modulo": 6,
            "id_actividad": 2,
            "titulo_mod": "Árbol",
            "instrucciones": "Como último punto de esta actividad, y habiendo elegido 1 problemática, es necesario que hagas un Árbol de Causas y Una vez hecha esta reflexión, haz una investigación que considere por lo menos 3 posibles causas del problema seleccionado, así como 5 posibles consecuencias. Es relevante que se tomes en cuenta sus consecuencias en el entorno, la sociedad, las personas, la economía u cualquier otra área de abordaje. Aunque se sugiere que la investigación sea documental, también es posible que te apoyes con entrevistas a especialistas, profesores, familiares o conocedores del tema. Una vez se haya hecho esta investigación, podrás hacer tu árbol de causas y consecuencias. El tronco del árbol es el problema seleccionado; las raíces son las causas; las ramas y hojas son las consecuencias. Puedes dividir las consecuencias por su impacto internacional, nacional y local. Se sugiere que esta representación sea gráfica y con base en las herramientas propias que tengas. En la parte inferior del árbol se sugiere respondas lo siguiente: A partir de esta información, ¿Por qué es importante atender este problema? ¿Qué debes entregar? Árbol de causas y consecuencias del problema seleccionado",
            "imagen_mod": "act2_mod3.png",
            "estado": "i",
            "tipo_multimedia": "imagen"
        ]
    ]
    
    var actividadIndividual: Actividad_individual?
    var modulos_json: [Modulo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task{
            do {
                actividadIndividual = try await Actividad.fetchActividadesDetail(id_actividad: activity_modules)

                if let actividad = actividadIndividual {
                    print("Actividad cargada con éxito: \(actividad)")
                    titulo.text = actividad.titulo
                    descripcion_acti.text = actividad.descripcion
                    titulo_actividad.text = "FALTA"
                }
            } catch {
                print("Error al cargar la actividad: \(error)")
            }
            
            do {
                modulos_json = try await Modulo.fetchModulos(id_actividad: activity_modules)
                for actividad_json in modulos_json {
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
                    nuevo_foco.backgroundColor = UIColor.blue
                    configureEstadobtn(nuevo_foco)
                    
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
        
        //Recorrer JSON para agregar view con elementos
        for modulo in modulos_actividades {
            if let idModulo = modulo["id_modulo"] as? Int,
                   let idActividad = modulo["id_actividad"] as? Int,
               let titulo_de_modulo = modulo["titulo_mod"] as? String,
               let _ = modulo["instrucciones"] as? String,
               let _ = modulo["imagen_mod"] as? String,
               let _ = modulo["estado"] as? String,
               let _ = modulo["tipo_multimedia"] as? String{
                if(activity_modules == idActividad){
                    
                    //Creando una view para agregar al stack con los elementos del JSON
                    let containerView = UIView()
                    containerView.translatesAutoresizingMaskIntoConstraints = false
                    containerView.widthAnchor.constraint(equalToConstant: 393).isActive = true
                    containerView.heightAnchor.constraint(equalToConstant: 73).isActive = true
                    
                    // Crear el titutlo del modulo
                    let label = UILabel()
                    label.text = "   \(titulo_de_modulo)"
                    label.translatesAutoresizingMaskIntoConstraints = false
                    configureTitulo(label)
                    
                    // Crear el button del modulo
                    let nuevoBoton = UIButton()
                    configureButton(nuevoBoton)
                    
                    //Crear el foco de estado del modulo
                    let nuevo_foco = UIButton()
                    nuevo_foco.backgroundColor = UIColor.blue
                    configureEstadobtn(nuevo_foco)
                    
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
                    nuevoBoton.tag = idModulo // Asignar el ID de la actividad como tag
                    nuevoBoton.addTarget(self, action: #selector(navegarAEvidencias(_:)), for: .touchUpInside)
                }
            }
        }
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
                
                // Filtrar el arreglo para obtener actividades con id_actividad de la actividad seleccionada
                let modulosFiltradas = modulos_actividades.filter { modulo in
                    if let id = modulo["id_modulo"] as? Int {
                        actividad1VC.modulo_actual_results = sender.tag
                        return id == show_module
                    }
                    return false
                }
                
                // Mandar información de la actividad seleccionada
                for modulo in modulosFiltradas {
                    if let titulo_de_modulo = modulo["titulo_mod"] as? String,
                       let instrucciones_de_modulo = modulo["instrucciones"] as? String,
                       let _ = modulo["imagen_mod"] as? String,
                       let media = modulo["tipo_multimedia"] as? String{
                        actividad1VC.titulo_res = titulo_de_modulo
                        actividad1VC.Instrucciones_res = instrucciones_de_modulo
                        actividad1VC.multimedia_res = media
                    }
                }
                
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
