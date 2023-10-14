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
    var values: [CGFloat] = [50, 10, 100, 0]

    var estadisticaIndividual: EstadisticaIndividual?
    @IBOutlet weak var completadas: UILabel!
    @IBOutlet weak var faltantes: UILabel!
    @IBOutlet weak var progreso: UILabel!
    var ProgresosUsuarios_json: [ProgresoUsuario] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //UserDefaults.standard.set("1", forKey: "ID")
        let defaults = UserDefaults.standard
        let userID = defaults.integer(forKey: "ID")
        let controller = EstadisticasPut()
        
        Task {
            
            do{
                ProgresosUsuarios_json = try await ProgresoUsuario.fetchProgresoUsuarios(id_usuario: userID)
                ProgresosUsuarios_json = try await ProgresoUsuario.fetchProgresoUsuarios(id_usuario: userID)
                var countTrue = 0
                var countFalse = 0
                
                for progresoUsuario in ProgresosUsuarios_json {
                    if progresoUsuario.estado_modulo {
                        countTrue += 1
                    } else {
                        countFalse += 1
                    }
                }
                
                let porcentaje = (countTrue*100)/(countTrue + countFalse)
                try await  controller.putEstadisticasUser(idUsuario: userID, actividades: countTrue, evidencias: countFalse, progreso: porcentaje)
            }
            
            do {
                let estadisticaIndividual = try await Estadisticas.fetchEstadisticasDetail(idUsuario: userID)
                print("Resultados cargados con éxito: \(estadisticaIndividual)")
                completadas.text = "\(estadisticaIndividual.actividades) actividades"
                faltantes.text = "\(estadisticaIndividual.evidencias) actividades"
                progreso.text = "\(estadisticaIndividual.progreso)%"
            } catch {
                print("Error al cargar las estadisticas: \(error)")
            }
        }
        Task{
            ProgresosUsuarios_json = try await ProgresoUsuario.fetchProgresoUsuarios(id_usuario: userID)
            // Supongamos que deseas contar cuántos tienen id_actividad = 1, 2, 3 y 4.
            let idActividadesAContar = [1, 2, 3, 4]

            // Inicializar un diccionario para realizar un seguimiento de los conteos.
            var actividadCounts = [Int: Int]()

            for progresoUsuario in ProgresosUsuarios_json {
                if idActividadesAContar.contains(progresoUsuario.id_actividad) && progresoUsuario.estado_modulo {
                    // Aumentar el contador para esta actividad
                    actividadCounts[progresoUsuario.id_actividad, default: 0] += 1
                }
            }

            // Actualizar los valores en función de los conteos
            var updatedValues = [CGFloat]()

            for idActividad in idActividadesAContar {
                let count = actividadCounts[idActividad] ?? 0
                updatedValues.append(CGFloat(count))
            }

            // Reemplazar los valores antiguos con los valores actualizados
            values = updatedValues
            // Do any additional setup after loading the view.
            createStackedBarChart()
        }
    }
    
    func createStackedBarChart() {
        let barWidth: CGFloat = 5
        let spacing: CGFloat = 40

        // Calcular el ancho total de la gráfica de barras
        let totalWidth = (barWidth + spacing) * CGFloat(values.count)

        // Posición inicial en la vista
        var xPosition: CGFloat = (chartContainerView.frame.width - totalWidth) / 2

        // Valor total para las barras de fondo (debe sumar 100)
        let totalValue: CGFloat = 3

        // Títulos de las barras
        let titles = ["Act1", "Act2", "Act3", "Act4"] // Agrega tantos títulos como barras tengas

        // Crear y agregar las barras de fondo (que suman al 100%)
        for (index, value) in values.enumerated() {
            let backgroundBarView = UIView()
            backgroundBarView.backgroundColor = UIColor.lightGray
            let backgroundValue = totalValue // Calcular el valor de fondo
            let backgroundHeight = (backgroundValue / totalValue) * chartContainerView.frame.height
            backgroundBarView.frame = CGRect(x: xPosition, y: chartContainerView.frame.height - backgroundHeight, width: barWidth, height: backgroundHeight)
            chartContainerView.addSubview(backgroundBarView)

            // Crear una etiqueta para el título
                let titleLabel = UILabel()
                titleLabel.text = titles[index]
                titleLabel.textAlignment = .center
                titleLabel.adjustsFontSizeToFitWidth = true // Para que el texto se ajuste si es demasiado largo
                titleLabel.minimumScaleFactor = 0.5 // Ajusta según tus necesidades
                titleLabel.frame = CGRect(x: xPosition, y: chartContainerView.frame.height, width: barWidth*4, height: 30) // Ajusta el ancho y la altura según tus necesidades
                chartContainerView.addSubview(titleLabel)

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
            } else {
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
