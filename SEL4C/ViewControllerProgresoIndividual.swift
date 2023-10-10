//
//  ViewControllerProgresoIndividual.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 25/09/23.
//

import UIKit
import Charts

class ViewControllerProgresoIndividual: UIViewController {
    
    @IBOutlet weak var chartContainerView: UIView!
    // Valores de las barras
        let values: [CGFloat] = [50, 10, 100, 0]

    var estadisticaIndividual: EstadisticaIndividual?
    @IBOutlet weak var completadas: UILabel!
    @IBOutlet weak var faltantes: UILabel!
    @IBOutlet weak var progreso: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            do {
                let estadisticaIndividual = try await Estadisticas.fetchEstadisticasDetail(idUsuario: 1)
                print("Resultados cargados con éxito: \(estadisticaIndividual)")
                completadas.text = "\(estadisticaIndividual.actividades) actividades"
                faltantes.text = "\(estadisticaIndividual.evidencias) actividades"
                progreso.text = "\(estadisticaIndividual.progreso)%"
            } catch {
                print("Error al cargar las estadisticas: \(error)")
            }
        }
        // Do any additional setup after loading the view.
        createStackedBarChart()
    }
    
    func createStackedBarChart() {
            let barWidth: CGFloat = 5
            let spacing: CGFloat = 40

            // Calcular el ancho total de la gráfica de barras
            let totalWidth = (barWidth + spacing) * CGFloat(values.count)

            // Posición inicial en la vista
            var xPosition: CGFloat = (chartContainerView.frame.width - totalWidth) / 2

            // Valor total para las barras de fondo (debe sumar 100)
            let totalValue: CGFloat = 100

            // Crear y agregar las barras de fondo (que suman al 100%)
            for value in values {
                let backgroundBarView = UIView()
                backgroundBarView.backgroundColor = UIColor.lightGray
                let backgroundValue = totalValue // Calcular el valor de fondo
                let backgroundHeight = (backgroundValue / totalValue) * chartContainerView.frame.height
                backgroundBarView.frame = CGRect(x: xPosition, y: chartContainerView.frame.height - backgroundHeight, width: barWidth, height: backgroundHeight)
                chartContainerView.addSubview(backgroundBarView)

                // Actualizar la posición X para la próxima barra
                xPosition += barWidth + spacing
            }

            // Reiniciar la posición X
            xPosition = (chartContainerView.frame.width - totalWidth) / 2

            // Crear y agregar las barras principales (valores originales)
            for value in values {
                let barView = UIView()
                
                if value == 100{
                    barView.backgroundColor = UIColor(red: 0x21 / 255.0, green: 0x4E / 255.0, blue: 0x7F / 255.0, alpha: 1.0)
                }else{
                    barView.backgroundColor = UIColor(red: CGFloat(0xFC) / 255.0, green: CGFloat(0xA3) / 255.0, blue: CGFloat(0x11) / 255.0, alpha: 1.0)
                }
                let barHeight = (value / totalValue) * chartContainerView.frame.height
                barView.frame = CGRect(x: xPosition, y: chartContainerView.frame.height - barHeight, width: barWidth, height: barHeight)
                chartContainerView.addSubview(barView)

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
