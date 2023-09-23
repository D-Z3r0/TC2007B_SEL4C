//
//  ViewControllerEv1Act1.swift
//  SEL4C
//
//  Created by Sofía Donlucas on 21/09/23.
//

import UIKit

class ViewControllerEv1Act1: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var selectedVideoURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pickVideo(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = ["public.movie"] // Specify that you want to pick videos
        present(imagePicker, animated: true, completion: nil)
    }

    // UIImagePickerControllerDelegate method to handle the selected video
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let videoURL = info[.mediaURL] as? URL {
            // Handle the selected video URL here
            selectedVideoURL = videoURL
            print("Selected video URL: \(videoURL)")
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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
