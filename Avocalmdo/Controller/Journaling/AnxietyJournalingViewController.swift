//
//  JournalingViewController.swift
//  Avocalmdo
//
//  Created by Ishaq Adheltyo on 13/04/22.
//

import UIKit
import CoreData

class AnxietyJournalingViewController: UIViewController {
    
    // Slider Input Components
    private var emojiIcon : [UIImage] = [UIImage(named: "cryFaceRound")!,UIImage(named: "sadFaceRound")!,UIImage(named: "neutralFaceRound")!,UIImage(named: "smileFaceRound")!,UIImage(named: "happyFaceRound")!]
    
    @IBOutlet weak var anxietyMeter: UISlider!
    @IBOutlet weak var activityMeter: UISlider!
    @IBOutlet weak var stressMeter: UISlider!
    @IBOutlet weak var todayCollectionView: UICollectionView!
   
    var journalingStruct : JournalingStruct = JournalingStruct()
    
    override func viewWillAppear(_ animated: Bool) {
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todayCollectionView.delegate = self
        todayCollectionView.dataSource = self
        journalingStruct.emojiTodayIndex = -1
        // Do any additional setup after loading the view.
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEmojiJournaling" {
            if let nextViewController = segue.destination as? EmojiJournalingViewController {
                nextViewController.journalingStruct = self.journalingStruct
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
            cell.emojiImageView.layer.borderColor = UIColor.white.cgColor
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
