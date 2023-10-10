//
//  ViewControllerEvInicialResultados.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 27/09/23.
//

import UIKit

class ViewControllerEvInicialResultados: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            do {
                let resultadoIndividual = try await ResultadoEvaluaciones.fetchResultadoEvaluacionesDetail(idUsuario: 1)
                print("Resultados cargados con éxito: \(resultadoIndividual)")
                resultado_competencia.text = "\(resultadoIndividual.competencia1)%"
                resultado_sub1.text = "\(resultadoIndividual.competencia2)%"
                resultado_sub2.text = "\(resultadoIndividual.competencia3)%"
                resultado_sub3.text = "\(resultadoIndividual.competencia4)%"
                resultado_sub4.text = "\(resultadoIndividual.competencia5)%"
                if let competencia1 = Float(resultadoIndividual.competencia1) {
                                competencia1Value = competencia1 / 100.0 // Supongo que los valores de competencia están en porcentaje
                                progress_competencia.progress = competencia1Value
                            }
                if let competencia2 = Float(resultadoIndividual.competencia2) {
                                    competencia2Value = competencia2 / 100.0
                                    progress_sub1.progress = competencia2Value // Configuramos progress_sub1
                                }
                if let competencia3 = Float(resultadoIndividual.competencia3) {
                                    competencia3Value = competencia3 / 100.0
                                    progress_sub2.progress = competencia3Value // Configuramos progress_sub1
                                }
                if let competencia4 = Float(resultadoIndividual.competencia4) {
                                    competencia4Value = competencia4 / 100.0
                                    progress_sub3.progress = competencia4Value // Configuramos progress_sub1
                                }
                if let competencia5 = Float(resultadoIndividual.competencia5) {
                                    competencia5Value = competencia5 / 100.0
                                    progress_sub4.progress = competencia5Value // Configuramos progress_sub1
                                }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
