//
//  BeginViewController.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 06/09/23.
//

import UIKit

class BeginViewController: UIViewController {

    @IBOutlet var viewmain: UIView!
    @IBOutlet weak var button1: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        /*
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)*/
        let isUserLogged = defaults.bool(forKey: "LOGGEDIN")
        if (isUserLogged) {
            //El usuario ya está logueado, navegar a home screen
            goToHomeScreen()
        }
        // Do any additional setup after loading the view.
    }
    
    func goToHomeScreen() {
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreen") as! UITabBarController
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
//    @IBAction func loginButtonPressed() {
//        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginRegisterIdentifier") as? Login2ViewController
//            self.navigationController?.pushViewController(destinationVC!, animated: true)
//        destinationVC!.tagFromButton = 1
//    }
//
//    @IBAction func registerButtonPressed() {
//        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginRegisterIdentifier") as? Login2ViewController
//            self.navigationController?.pushViewController(destinationVC!, animated: true)
//        destinationVC!.tagFromButton = 2
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
