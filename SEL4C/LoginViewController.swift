//
//  LoginViewController.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 06/09/23.
//

import UIKit

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

class LoginViewController: UIViewController {

    @IBOutlet var viewmain: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view1.isHidden = true
        view2.isHidden = false
        
    }
    
    @IBAction func hideView2(_ sender: UIButton) {
        view1.isHidden = false
        view2.isHidden = true
        viewmain.backgroundColor = UIColor(hex: 003087)
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
