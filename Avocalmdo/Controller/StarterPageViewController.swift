//
//  StarterPageViewController.swift
//  Avocalmdo
//
//  Created by Mikhael Adiputra on 11/04/22.
//

import UIKit

class StarterPageViewController: UIViewController {

    private let userDefaults = UserDefaults.standard
    @IBOutlet weak var nameTextfield: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        nameTextfield.changeTextfield()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillLayoutSubviews() {
        let userName = userDefaults.string(forKey: "name")
        if (userName != nil) {
            segueToMain()
        }
    }
    
    private func segueToMain() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc =  storyboard.instantiateViewController(withIdentifier: "main")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if nameTextfield.text?.count != 0 {
            userDefaults.set(nameTextfield.text!, forKey: "name")
            segueToMain()
        }else {
            self.nameTextfield.backgroundColor = UIColor.systemRed.withAlphaComponent(0.25)
        }
    }
    
}
