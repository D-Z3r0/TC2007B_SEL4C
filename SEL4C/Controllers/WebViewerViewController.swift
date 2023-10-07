//
//  WebViewerViewController.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 27/09/23.
//

import UIKit
import WebKit
//import SafariServices

class WebViewerViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        let safeAreaFrame = CGRect(x:0, y:0, width: 393, height: 842)
        webView = WKWebView(frame: safeAreaFrame, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        if let url = URL(string: "https://www.apple.com") {
//            let safariViewController = SFSafariViewController(url: url)
//            present(safariViewController, animated: true, completion: nil)
//        }
        let myURL = URL(string:"https://tec.mx/es/aviso-de-privacidad-sel4c")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        webView.allowsBackForwardNavigationGestures = true
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
