//
//  LoginViewController.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 06/09/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var viewmain: UIView!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        button1.tag = 1
        button2.tag = 2
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destinationVC = segue.destination as? Login2ViewController
        if let button = sender as? UIButton {
            destinationVC?.tagFromButton = button.tag
        }
    }
}
