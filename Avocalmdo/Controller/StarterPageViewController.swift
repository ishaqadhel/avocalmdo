//
//  StarterPageViewController.swift
//  Avocalmdo
//
//  Created by Mikhael Adiputra on 11/04/22.
//

import UIKit

class StarterPageViewController: UIViewController {

    @IBOutlet weak var greenTextBox: UIView!
    @IBOutlet weak var nameTextfield: UITextField!

    private let userDefaults = UserDefaults.standard
    private var userName: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        greenTextBox.layer.cornerRadius = 8
    }
    
    override func viewWillLayoutSubviews() {
        userName = userDefaults.string(forKey: "name")
        if userName != nil {
            segueToMain()
        }
    }
    
    private func segueToMain() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController =  storyboard.instantiateViewController(withIdentifier: "main")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if nameTextfield.hasText {
            userName = nameTextfield.text
            userDefaults.set(nameTextfield.text, forKey: "name")
            segueToMain()
        } else {
            nameTextfield.layer.cornerRadius = 8
            nameTextfield.layer.borderWidth = 1.0
            nameTextfield.layer.borderColor = UIColor.red.cgColor
            let alert = UIAlertController(title: "Name Empty", message: "Please add your name", preferredStyle: .alert)
            let okayButton = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(okayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}


