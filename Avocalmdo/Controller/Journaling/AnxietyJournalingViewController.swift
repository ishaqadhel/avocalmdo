//
//  JournalingViewController.swift
//  Avocalmdo
//
//  Created by Ishaq Adheltyo on 13/04/22.
//

import UIKit
import CoreData

protocol returnJurnalStruct {
    func returnJurnalStruct(journaling : JournalingStruct, isReady : Bool)
}

class AnxietyJournalingViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    private var emojiIcon : [UIImage] = [UIImage(named: "cryFaceRound")!,UIImage(named: "sadFaceRound")!,UIImage(named: "neutralFaceRound")!,UIImage(named: "smileFaceRound")!,UIImage(named: "happyFaceRound")!]
    
    @IBOutlet weak var anxietyMeter: UISlider!
    @IBOutlet weak var activityMeter: UISlider!
    @IBOutlet weak var stressMeter: UISlider!
    @IBOutlet weak var todayCollectionView: UICollectionView!
   
    var journalingStruct : JournalingStruct = JournalingStruct()
    var isReady = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todayCollectionView.delegate = self
        todayCollectionView.dataSource = self
        pageControl.layer.cornerRadius = 8
        if isReady == false {
            journalingStruct.emojiTodayIndex = -1
            journalingStruct.weatherTodayIndex = -1
            journalingStruct.foodTodayIndex = -1
            journalingStruct.colorTodayIndex = -1
            journalingStruct.activityTodayIndex = -1
        }else {
            anxietyMeter.setValue(Float(journalingStruct.anxietyMeter), animated: false)
            activityMeter.setValue(Float(journalingStruct.activityMeter), animated: false)
            stressMeter.setValue(Float(journalingStruct.stressMeter), animated: false)
        }
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    @IBAction func anxietyMeterPressed(_ sender: UISlider) {
        responseSlider(sender: sender)
    }
    @IBAction func hardAnxietyPresed(_ sender: UISlider) {
        responseSlider(sender: sender)
    }
    @IBAction func stressMeterPressed(_ sender: UISlider) {
       responseSlider(sender: sender)
    }
    
    private func responseSlider (sender : UISlider) {
        if sender.value >= 0.75 {
            sender.setValue(Float(1.0), animated: true)
        }else if sender.value <= 0.25 {
            sender.setValue(Float(0.0), animated: true)
        }else {
            sender.setValue(Float(0.5), animated: true)
        }
        if sender == anxietyMeter {
            journalingStruct.anxietyMeter = sender.value
        }else if sender == activityMeter {
            journalingStruct.activityMeter = sender.value
        }else if sender == stressMeter {
            journalingStruct.stressMeter = sender.value
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if journalingStruct.emojiTodayIndex == -1 {
            let alert = UIAlertController(title: "Missing Values!", message: "Please choose emoji for today", preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .cancel) { uialerta in
            }
            alert.addAction(action)
            present(alert, animated: true)
        }else {
            performSegue(withIdentifier: "goToEmojiJournaling", sender: self)
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        if self.journalingStruct.emojiTodayIndex != -1 {
            let alert   = UIAlertController(title: "Are you sure?", message: "All of the unsaved data will be lost", preferredStyle: .alert)
            let discard = UIAlertAction(title: "Discard Changes", style: .destructive) { UIAlertAction in
                self.navigationController?.popViewController(animated: true)
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
                alert.addAction(discard)
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
        }else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEmojiJournaling" {
            if let nextViewController = segue.destination as? EmojiJournalingViewController {
                nextViewController.journalingStruct = self.journalingStruct
                nextViewController.delegate = self
            }
        }
    }
}

extension AnxietyJournalingViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojiIcon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emojiCell", for: indexPath) as! EmojiCollectionViewCell
        let index = indexPath.row
        if index == journalingStruct.emojiTodayIndex {
            cell.emojiImageView.layer.borderWidth = 5.0
            cell.emojiImageView.layer.borderColor = UIColor.systemGreen.cgColor
            cell.emojiImageView.layer.cornerRadius = cell.emojiImageView.bounds.height/2
        }else {
            cell.emojiImageView.layer.borderWidth = 0
            cell.emojiImageView.layer.borderColor = UIColor.clear.cgColor
        }
        cell.emojiImageView.image = emojiIcon[index]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let todayEmotionData = emojiIcon[indexPath.row]
        journalingStruct.todayEmotion = todayEmotionData.pngData()!
        journalingStruct.emojiTodayIndex = indexPath.row
        todayCollectionView.reloadData()
    }
    
}

extension AnxietyJournalingViewController : returnJurnalStruct {
    func returnJurnalStruct(journaling: JournalingStruct, isReady : Bool) {
        self.journalingStruct = journaling
        self.isReady = isReady
    }
}
