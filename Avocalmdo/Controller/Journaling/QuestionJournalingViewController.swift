//
//  QuestionJournalingViewController.swift
//  Avocalmdo
//
//  Created by Ishaq Adheltyo on 13/04/22.
//

import UIKit
import CoreData

class QuestionJournalingViewController: UIViewController {

    @IBOutlet weak var montageCollectionView: UICollectionView!
    @IBOutlet weak var nextSaveButton: UIButton!
    @IBOutlet weak var emojiImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var activityStressTextview: UITextView!
    @IBOutlet weak var feelOvercomeTextview: UITextView!
    
    @IBOutlet weak var feelLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var menuCounter = 0
    private let date = Date()
    
    var journalingStruct : JournalingStruct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        montageCollectionView.delegate = self
        montageCollectionView.dataSource = self
   
        emojiImageView.image = UIImage(data: journalingStruct!.todayEmotion)
        
        let tapped = UITapGestureRecognizer(target: self, action: #selector(dismissView(_:)))
        view.addGestureRecognizer(tapped)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        feelOvercomeTextview.layer.cornerRadius = 14
        activityStressTextview.layer.cornerRadius = 14
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/2
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            UIView.animate(withDuration: 0.5, delay: 0) { [self] in
                self.view.frame.origin.y = 0
            }
        }
    }
    
    @objc private func dismissView (_ gesture : UITapGestureRecognizer) {
        if self.view.frame.origin.y != 0 {
            UIView.animate(withDuration: 0.5, delay: 0) { [self] in
                self.view.frame.origin.y = 0
            }
        }
        self.view.endEditing(true)
    }
    
    @IBAction func nextSavePressed(_ sender: UIButton) {
        if self.menuCounter == 0 {
            if feelOvercomeTextview.text?.count != 0 && activityStressTextview.text?.count != 0 {
                
                journalingStruct!.activityToday = activityStressTextview.text!
                journalingStruct!.feelingToday = feelOvercomeTextview.text!
                feelOvercomeTextview.text = ""
                activityStressTextview.text = ""
                activityLabel.text = "What blockers or stress do you have?"
                feelLabel.text = "How did you overcome the stress"
                nextSaveButton.isEnabled = false
                saveButton.isEnabled = true
                menuCounter = menuCounter + 1
                
                UIView.animate(withDuration: 0.1, delay: 0, options: .transitionCrossDissolve) { [self] in
                    nextSaveButton.alpha = 0.0
                    saveButton.alpha = 1.0
                }
                
            }else {
                let alert = UIAlertController(title: "Missing Values!", message: "Please write your story for today", preferredStyle: .alert)
                let action = UIAlertAction(title: "Dismiss", style: .cancel) { uialerta in
                }
                alert.addAction(action)
                present(alert, animated: true)
            }
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if feelOvercomeTextview.text?.count != 0 && activityStressTextview.text?.count != 0 {
            journalingStruct!.blockerToday = activityStressTextview.text!
            journalingStruct!.overcomeStress = feelOvercomeTextview.text!
            
            let alert = UIAlertController(title: "Save Item?", message: "Are you sure want to save today's journal?", preferredStyle: .alert)
            let save = UIAlertAction(title: "Save", style: .default) { UIAlertAction in
               
                let entity = NSEntityDescription.entity(forEntityName: "Journaling", in: self.context)
                let newEntry = NSManagedObject(entity: entity!, insertInto: self.context)
                
                self.saveData(entryDBObj: newEntry)
                self.navigationController!.popToRootViewController(animated: true)
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(save)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            
        }else {
            let alert = UIAlertController(title: "Missing Values!", message: "Please write your story for today", preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .cancel) { uialerta in
            }
            alert.addAction(action)
            present(alert, animated: true)
        }
     
    }
    
    private func saveData(entryDBObj:NSManagedObject){
        entryDBObj.setValue(self.journalingStruct!.activityEmoticon, forKey: "activityEmotion")
        entryDBObj.setValue(self.journalingStruct!.activityMeter, forKey: "activityMeter")
        entryDBObj.setValue(self.journalingStruct!.activityToday, forKey: "activityToday")
        entryDBObj.setValue(self.journalingStruct!.activityMeter, forKey: "activityMeter")
        entryDBObj.setValue(self.journalingStruct!.blockerToday, forKey: "blockerToday")
        entryDBObj.setValue(self.journalingStruct!.colorEmotion, forKey: "colorEmotion")
        entryDBObj.setValue(self.date, forKey: "date")
        let dateF = DateFormatter()
        dateF.dateFormat = "EEEE, MMM d yyyy"
        let todayDate = dateF.string(from: self.date)
        entryDBObj.setValue(todayDate, forKey: "dateDetail")
        entryDBObj.setValue(self.journalingStruct!.feelingToday, forKey: "feelingToday")
        entryDBObj.setValue(self.journalingStruct!.foodEmotion, forKey: "foodEmotion")
        entryDBObj.setValue(self.journalingStruct!.overcomeStress, forKey: "overcomeStress")
        entryDBObj.setValue(self.journalingStruct!.stressMeter, forKey: "stressMeter")
        entryDBObj.setValue(self.journalingStruct!.todayEmotion, forKey: "todayEmotion")
        entryDBObj.setValue(self.journalingStruct!.weatherEmoticon, forKey: "weatherEmotion")
        
        do {
            try context.save()
        } catch {
            print("Storing data Failed")
        }
    }
}

extension QuestionJournalingViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emojiCell", for: indexPath) as! EmojiCollectionViewCell
        let index = indexPath.row
        switch index {
        case 0:
            cell.emojiImageView.image =  UIImage(data: self.journalingStruct!.weatherEmoticon)
        case 1:
            cell.emojiImageView.image =  UIImage(data: self.journalingStruct!.activityEmoticon)
        case 2:
            cell.emojiImageView.image =  UIImage(data: self.journalingStruct!.foodEmotion)
        case 3:
            cell.emojiImageView.image =  UIImage(data: self.journalingStruct!.colorEmotion)
        default:
            print("default")
        }
        cell.emojiImageView.backgroundColor = UIColor.clear
        return cell
    }
    
}
