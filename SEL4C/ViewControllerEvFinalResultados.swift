//
//  ViewControllerEvFinalResultados.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 15/10/23.
//

import UIKit
import Charts

class ViewControllerEvFinalResultados: UIViewController {

    @IBOutlet weak var btn_competencia: UIButton!
    @IBOutlet weak var btn_sub1: UIButton!
    @IBOutlet weak var btn_sub2: UIButton!
    @IBOutlet weak var btn_sub3: UIButton!
    @IBOutlet weak var btn_sub4: UIButton!
    
    @IBOutlet weak var resultado_competencia: UILabel!
    @IBOutlet weak var resultado_sub1: UILabel!
    @IBOutlet weak var resultado_sub2: UILabel!
    @IBOutlet weak var resultado_sub3: UILabel!
    @IBOutlet weak var resultado_sub4: UILabel!

    @IBOutlet weak var progress_competencia: UIProgressView!
    @IBOutlet weak var progress_sub1: UIProgressView!
    @IBOutlet weak var progress_sub2: UIProgressView!
    @IBOutlet weak var progress_sub3: UIProgressView!
    @IBOutlet weak var progress_sub4: UIProgressView!
    
    var competencia1Value: Float = 0.0
    var competencia2Value: Float = 0.0
    var competencia3Value: Float = 0.0
    var competencia4Value: Float = 0.0
    var competencia5Value: Float = 0.0
    
    var resultadoIndividual: ResultadoIndividual?
    var values1: [CGFloat] = [0, 0, 0, 0]
    var values2: [CGFloat] = [0, 0, 0, 0]
    @IBOutlet weak var char_container: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UserDefaults.standard.set("1", forKey: "ID")
        let defaults = UserDefaults.standard
        let userID = defaults.integer(forKey: "ID")
        Task {
            do {
                let resultadoIndividual = try await ResultadoEvaluaciones.fetchResultadoEvaluacionesFinalDetail(idUsuario: 23)
                let resultadoIndividualinicial = try await ResultadoEvaluaciones.fetchResultadoEvaluacionesDetail(idUsuario: userID)
                print("Resultados cargados con éxito: \(resultadoIndividual)")
                resultado_competencia.text = "\(resultadoIndividual.competencia1)%"
                resultado_sub1.text = "\(resultadoIndividual.competencia2)%"
                resultado_sub2.text = "\(resultadoIndividual.competencia3)%"
                resultado_sub3.text = "\(resultadoIndividual.competencia4)%"
                resultado_sub4.text = "\(resultadoIndividual.competencia5)%"
                var updatedValues1 = [CGFloat]()
                var updatedValues2 = [CGFloat]()
                if let competencia1 = Float(resultadoIndividual.competencia1) {
                                competencia1Value = competencia1 / 100.0 // Supongo que los valores de competencia están en porcentaje
                                progress_competencia.progress = competencia1Value
                            }
                if let competencia2 = Float(resultadoIndividual.competencia2) {
                                    competencia2Value = competencia2 / 100.0
                                    progress_sub1.progress = competencia2Value // Configuramos progress_sub1
                    updatedValues1.append(CGFloat(competencia2))
                    updatedValues2.append(CGFloat(Float(resultadoIndividualinicial.competencia2)!))
                                }
                if let competencia3 = Float(resultadoIndividual.competencia3) {
                                    competencia3Value = competencia3 / 100.0
                                    progress_sub2.progress = competencia3Value // Configuramos progress_sub1
                    updatedValues1.append(CGFloat(competencia3))
                    updatedValues2.append(CGFloat(Float(resultadoIndividualinicial.competencia3)!))
                                }
                if let competencia4 = Float(resultadoIndividual.competencia4) {
                                    competencia4Value = competencia4 / 100.0
                                    progress_sub3.progress = competencia4Value // Configuramos progress_sub1
                    updatedValues1.append(CGFloat(competencia4))
                    updatedValues2.append(CGFloat(Float(resultadoIndividualinicial.competencia4)!))
                                }
                if let competencia5 = Float(resultadoIndividual.competencia5) {
                                    competencia5Value = competencia5 / 100.0
                                    progress_sub4.progress = competencia5Value // Configuramos progress_sub1
                    updatedValues1.append(CGFloat(competencia5))
                    updatedValues2.append(CGFloat(Float(resultadoIndividualinicial.competencia5)!))
                                }
                
                // Reemplazar los valores antiguos con los valores actualizados
                values1 = updatedValues1
                values2 = updatedValues2
                // Do any additional setup after loading the view.
                createStackedBarChart()
            } catch {
                print("Error al cargar el módulo: \(error)")
            }
        }

        
        // Do any additional setup after loading the view.
        btn_competencia.layer.shadowColor = UIColor.gray.cgColor // Shadow color
        btn_competencia.layer.shadowOpacity = 0.5 // Shadow opacity
        btn_competencia.layer.shadowOffset = CGSize(width: 0, height: 2) // Shadow offset
        btn_competencia.layer.shadowRadius = 4 // Shadow radius
        
        btn_sub1.layer.shadowColor = UIColor.gray.cgColor // Shadow color
        btn_sub1.layer.shadowOpacity = 0.5 // Shadow opacity
        btn_sub1.layer.shadowOffset = CGSize(width: 0, height: 2) // Shadow offset
        btn_sub1.layer.shadowRadius = 4 // Shadow radius
        
        btn_sub2.layer.shadowColor = UIColor.gray.cgColor // Shadow color
        btn_sub2.layer.shadowOpacity = 0.5 // Shadow opacity
        btn_sub2.layer.shadowOffset = CGSize(width: 0, height: 2) // Shadow offset
        btn_sub2.layer.shadowRadius = 4 // Shadow radius
        
        btn_sub3.layer.shadowColor = UIColor.gray.cgColor // Shadow color
        btn_sub3.layer.shadowOpacity = 0.5 // Shadow opacity
        btn_sub3.layer.shadowOffset = CGSize(width: 0, height: 2) // Shadow offset
        btn_sub3.layer.shadowRadius = 4 // Shadow radius
        
        btn_sub4.layer.shadowColor = UIColor.gray.cgColor // Shadow color
        btn_sub4.layer.shadowOpacity = 0.5 // Shadow opacity
        btn_sub4.layer.shadowOffset = CGSize(width: 0, height: 2) // Shadow offset
        btn_sub4.layer.shadowRadius = 4 // Shadow radius
        // Do any additional setup after loading the view.
    }
    
    func createStackedBarChart() {
        let barWidth: CGFloat = 25 // Ancho de cada barra
        let spacing: CGFloat = 20 // Espacio entre barras
        let labelHeight: CGFloat = 30 // Altura de la etiqueta de título

        // Calcular el ancho total de la gráfica de barras
        let totalWidth = (barWidth + spacing) * CGFloat(values1.count)

        // Posición inicial en la vista
        var xPosition: CGFloat = (char_container.frame.width - totalWidth) / 2

        // Títulos de las barras
        let titles = ["Act1", "Act2", "Act3", "Act4"] // Agrega tantos títulos como barras tengas

        // Crear y agregar las barras principales (values1)
        for (index, value) in values1.enumerated() {
            let barView = UIView()
            barView.backgroundColor = UIColor(red: 0x21 / 255.0, green: 0x4E / 255.0, blue: 0x7F / 255.0, alpha: 1.0)
            let barHeight = (value / 100.0) * (char_container.frame.height - labelHeight)
            barView.frame = CGRect(x: xPosition, y: char_container.frame.height - barHeight - labelHeight, width: barWidth, height: barHeight)
            char_container.addSubview(barView)

            // Crear una etiqueta para el título
            let titleLabel = UILabel()
            titleLabel.text = titles[index]
            titleLabel.textAlignment = .center
            titleLabel.adjustsFontSizeToFitWidth = true
            titleLabel.minimumScaleFactor = 0.5
            titleLabel.frame = CGRect(x: xPosition, y: char_container.frame.height - labelHeight, width: barWidth, height: labelHeight)
            char_container.addSubview(titleLabel)

            // Actualizar la posición X para la próxima barra
            xPosition += barWidth + spacing
        }

        // Reiniciar la posición X para las barras de values2
        xPosition = (char_container.frame.width - totalWidth) / 2

        // Crear y agregar las barras secundarias (values2)
        for (index, value) in values2.enumerated() {
            let barView = UIView()
            barView.backgroundColor = UIColor(red: CGFloat(0xFC) / 255.0, green: CGFloat(0xA3) / 255.0, blue: CGFloat(0x11) / 255.0, alpha: 1.0)
            let barHeight = (value / 100.0) * (char_container.frame.height - labelHeight)
            barView.frame = CGRect(x: xPosition, y: char_container.frame.height - barHeight - labelHeight, width: barWidth, height: barHeight)
            char_container.addSubview(barView)

            // Actualizar la posición X para la próxima barra
            xPosition += barWidth + spacing
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
