//
//  Login2ViewController.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 18/09/23.
//

import UIKit

class Login2ViewController: UIViewController {
    var tagFromButton: Int = 0
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if tagFromButton == 1 {
            view2.isHidden = true
        }else {
            view1.isHidden = true
        }
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
