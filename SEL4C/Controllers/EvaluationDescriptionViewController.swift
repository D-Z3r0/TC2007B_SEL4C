//
//  EvaluationDescriptionViewController.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 19/10/23.
//

import UIKit

class EvaluationDescriptionViewController: UIViewController {
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var titleText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
//        let domain = Bundle.main.bundleIdentifier!
//        UserDefaults.standard.removePersistentDomain(forName: domain)
        let defaults = UserDefaults.standard
        let evaluationSolved = defaults.bool(forKey: "INEVSOLVED")
        if (evaluationSolved) {
            goToHomeScreen()
        }
        // Do any additional setup after loading the view.
    }
    
    func goToHomeScreen() {
        print("siguiente")
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreen") as! UITabBarController
        self.navigationController?.pushViewController(destinationVC, animated: true)
        print("listo")
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
