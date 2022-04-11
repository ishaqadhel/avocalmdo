//
//  HomeViewController.swift
//  Avocalmdo
//
//  Created by Mikhael Adiputra on 11/04/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var uiSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
        imageView.isUserInteractionEnabled = true
        let tappedGesture = UITapGestureRecognizer(target: self, action: #selector(responseTapped(_:)))
        imageView.addGestureRecognizer(tappedGesture)
        let tapped = UITapGestureRecognizer(target: self, action: #selector(textFieldResponse(_:)))
        view.addGestureRecognizer(tapped)
    }
    
    @objc private func responseTapped(_ gesture : UITapGestureRecognizer) {
        print("umage")
        
    }
    
    @objc private func textFieldResponse(_ gesture : UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func testButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToJournaling", sender: self)
        let alert = UIAlertController(title: "Are you sure", message: "This will be recorded for today", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Yes", style: .default) { uialertaction in
            print("okay")
        }
        alert.addAction(okay)
        present(alert, animated: true) {
            print("selesai")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToJournaling" {
            if let nextViewController = segue.destination as? JournalingViewController  {
                nextViewController.access = true
            }
        }
    }
  
}
