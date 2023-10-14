//
//  InitialEvaluationViewController.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 02/10/23.
//

import UIKit

class InitialEvaluationViewController: UIViewController {
    var collectedResponses: [(id: Int, value: Int)] = []
    var responseIDCounter = 0 // Un contador para asignar IDs únicos
    @IBOutlet weak var textQuestion: UILabel!
    @IBOutlet weak var progressEcomplexity: UIProgressView!
    // Botones de Opciones
    @IBOutlet weak var buttonNadaAcuerdo: UIButton!
    @IBOutlet weak var buttonPocoAcuderdo: UIButton!
    @IBOutlet weak var buttonNiAcuerdo: UIButton!
    @IBOutlet weak var buttonDeAcuerdo: UIButton!
    @IBOutlet weak var buttonMuyAcuerdo: UIButton!
    
    let padding: CGFloat = 20
    let fontSize: CGFloat = 30 // Tamaño del font deseado
    var engine=EcomplexityEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        textStyle(textQuestion)
        /*
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)*/
        let defaults = UserDefaults.standard
        let evaluationSolved = defaults.bool(forKey: "INEVSOLVED")
        //UserDefaults.standard.set("1", forKey: "ID")
        if (evaluationSolved) {
            goToHomeScreen()
        }else{
            Task{
                do{
                    let questions = try await Question.fetchQuestions()
                    updateUI(with: questions)
                }catch{
                    displayError(QuestionError.itemNotFound, title: "No se pudo accer a las preguntas")
                }
            }
        }
    }
    
    func updateUI(with questions:Questions){
        DispatchQueue.main.async {
            self.engine.initialize(q: questions)
            self.progressEcomplexity.progress = self.engine.getProgress()
            self.textQuestion.text = self.engine.getTextQuestion()
        }
    }
    
    func displayError(_ error: Error, title: String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    
    func sendAnswers() {
        var responsesDict: [[String: Any]] = []
        
        for (index, response) in collectedResponses.enumerated() {
            let responseDict: [String: Any] = [
                "id": index + 1,
                "respuesta": response.value
            ]
            responsesDict.append(responseDict)
        }
        
        Task{
            do {
//                let jsonData = try JSONSerialization.data(withJSONObject: responsesDict, options: .prettyPrinted)
//                if let jsonString = String(data: jsonData, encoding: .utf8) {
//                    print(jsonString) // Imprime el JSON en la consola
//                }
                try await Question.sendQuestions(questions: responsesDict, evalutaion_id: 1)
            } catch {
                print("Error al convertir a JSON: \(error)")
            }
        }
    }
    
    func goToHomeScreen() {
        print("siguiente")
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreen") as! UITabBarController
        self.navigationController?.pushViewController(destinationVC, animated: true)
        print("listo")
    }

    
    @IBAction func userAnswer(_ sender: UIButton) {
        var numericValue: Int
        
        let answer = sender.titleLabel?.text
        switch answer!{
        case let str where str.contains("Nada de acuerdo"):
            numericValue = 1
            //print(numericValue)
        case let str where str.contains("Poco de acuerdo"):
            numericValue = 2
            //print(numericValue)
        case let str where str.contains("Neutral"):
            numericValue = 3
            //print(numericValue)
        case let str where str.contains("De acuerdo"):
            numericValue = 4
            //print(numericValue)
        default:
            numericValue = 5
            //print(numericValue)
        }
        
        sender.backgroundColor = UIColor.clear
        buttonDeAcuerdo.isEnabled = false
        buttonNiAcuerdo.isEnabled = false
        buttonMuyAcuerdo.isEnabled = false
        buttonNadaAcuerdo.isEnabled = false
        buttonPocoAcuderdo.isEnabled = false
        
        if engine.nextQuestion(){
            let alert = UIAlertController(title: "Fin del cuestionario", message: "Vamos a pasar a la siguiente etapa", preferredStyle: .alert)
            let continueAction = UIAlertAction(title: "Continuar", style: .default) { [weak self] _ in
                self?.goToHomeScreen()
                UserDefaults.standard.set(true, forKey: "INEVSOLVED")
            }
            alert.addAction(continueAction)
            present(alert,animated: true)
            self.sendAnswers()
        }else{
            Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(self.nextQuestion), userInfo: nil, repeats: false)
        }
        collectedResponses.append((id: responseIDCounter, value: numericValue))
        responseIDCounter += 1
        //print("Counter:\(responseIDCounter)")
        //print(collectedResponses)
    }
    
    func textStyle(_ label: UILabel){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.firstLineHeadIndent = padding
        paragraphStyle.headIndent = padding
        paragraphStyle.tailIndent = 0
        paragraphStyle.lineSpacing = 10

        let attributedString = NSMutableAttributedString(string: label.text ?? "")
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.attributedText = attributedString
    }
    
    @objc func nextQuestion(){
        textQuestion.text = engine.getTextQuestion()
        progressEcomplexity.progress = engine.getProgress()
        buttonDeAcuerdo.backgroundColor = UIColor.white
        buttonNiAcuerdo.backgroundColor = UIColor.white
        buttonMuyAcuerdo.backgroundColor = UIColor.white
        buttonNadaAcuerdo.backgroundColor = UIColor.white
        buttonPocoAcuderdo.backgroundColor = UIColor.white
        
        buttonDeAcuerdo.isEnabled = true
        buttonNiAcuerdo.isEnabled = true
        buttonMuyAcuerdo.isEnabled = true
        buttonNadaAcuerdo.isEnabled = true
        buttonPocoAcuderdo.isEnabled = true
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
