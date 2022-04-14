//
//  EmojiJournalingViewController.swift
//  Avocalmdo
//
//  Created by Ishaq Adheltyo on 13/04/22.
//

import UIKit

class EmojiJournalingViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    @IBOutlet weak var foodCollectionView: UICollectionView!
    @IBOutlet weak var activityCollectionView: UICollectionView!
    
    private var weatherIconArray : [UIImage] = [UIImage(named: "cloudyEmojiRound")!,UIImage(named: "rainingEmojiRound")!,UIImage(named: "slightCloudyEmojiRound")!,UIImage(named: "sunnyEmojiRound")!,UIImage(named: "thunderEmojiRound")!]
    private var activityIconArray : [UIImage] = [UIImage(named: "basketballEmojiRound")!,UIImage(named: "bookEmojiRound")!,UIImage(named: "micEmojiRound")!,UIImage(named: "paintEmojiRound")!,UIImage(named: "popcornEmojiRound")!]
    private var foodIconArray : [UIImage] = [UIImage(named: "burgerEmojiRound")!,UIImage(named: "cakeEmojiRound")!,UIImage(named: "chickenEmojiRound")!,UIImage(named: "chocolateEmojiRound")!,UIImage(named: "pizzaEmojiRound")!]
    
    private var colorIconArray : [UIImage] = [UIImage(named: "blackHeartEmojiRound")!,UIImage(named: "blueHeartEmojiRound")!,UIImage(named: "greenHeartEmojiRound")!,UIImage(named: "redHeartEmojiRound")!,UIImage(named: "yellowHeartEmojiRound")!]
    
    private let date = Date()
    
    var journalingStruct : JournalingStruct?
    
    override func viewWillAppear(_ animated: Bool) {
        journalingStruct!.weatherTodayIndex = -1
        journalingStruct!.foodTodayIndex = -1
        journalingStruct!.colorTodayIndex = -1
        journalingStruct!.activityTodayIndex = -1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateF = DateFormatter()
        dateF.dateFormat = "EEEE, MMM d yyyy"
        let todayDate = dateF.string(from: date)
        dateLabel.text = todayDate
        
        weatherCollectionView.delegate = self
        colorCollectionView.delegate = self
        foodCollectionView.delegate = self
        activityCollectionView.delegate = self
        
        weatherCollectionView.dataSource = self
        colorCollectionView.dataSource = self
        foodCollectionView.dataSource = self
        activityCollectionView.dataSource = self
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if journalingStruct!.colorTodayIndex != -1 && journalingStruct!.foodTodayIndex != -1 && journalingStruct!.activityTodayIndex != -1 && journalingStruct!.weatherTodayIndex != -1 {
            performSegue(withIdentifier: "goToDetailJournal", sender: self)
        }else {
            let alert = UIAlertController(title: "Missing Values!", message: "Please choose emoji for today", preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .cancel) { uialerta in
            }
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailJournal" {
            if let nextViewController = segue.destination as? QuestionJournalingViewController {
                nextViewController.journalingStruct = self.journalingStruct!
            }
        }
    }
}


extension EmojiJournalingViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == weatherCollectionView {
            return weatherIconArray.count
        }else if collectionView == activityCollectionView {
            return activityIconArray.count
        }else if collectionView == foodCollectionView {
            return foodIconArray.count
        }else {
            return colorIconArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emojiCell", for: indexPath) as! EmojiCollectionViewCell
        let index = indexPath.row
        var indexDynamic : Int?
        if collectionView == weatherCollectionView {
            cell.emojiImageView.image = weatherIconArray[index]
            indexDynamic = journalingStruct!.weatherTodayIndex
        }else if collectionView == activityCollectionView {
            cell.emojiImageView.image = activityIconArray[index]
            indexDynamic = journalingStruct!.activityTodayIndex
        }else if collectionView == foodCollectionView {
            cell.emojiImageView.image = foodIconArray[index]
            indexDynamic = journalingStruct!.foodTodayIndex
        }else {
            cell.emojiImageView.image = colorIconArray[index]
            indexDynamic = journalingStruct!.colorTodayIndex
        }
        
        if index == indexDynamic! {
            cell.emojiImageView.layer.borderWidth = 5.0
            cell.emojiImageView.layer.borderColor = UIColor.white.cgColor
            cell.emojiImageView.layer.cornerRadius = cell.emojiImageView.bounds.height/2
        }else {
            cell.emojiImageView.layer.borderWidth = 0
            cell.emojiImageView.layer.borderColor = UIColor.clear.cgColor
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let emotionData : UIImage?
        let index = indexPath.row
        if collectionView == weatherCollectionView {
            emotionData = self.weatherIconArray[index]
            journalingStruct!.weatherEmoticon = emotionData!.pngData()!
            journalingStruct!.weatherTodayIndex = index
        }else if collectionView == activityCollectionView {
            emotionData = self.activityIconArray[index]
            journalingStruct!.activityEmoticon = emotionData!.pngData()!
            journalingStruct!.activityTodayIndex = index
        }else if collectionView == foodCollectionView {
            emotionData = self.foodIconArray[index]
            journalingStruct!.foodEmotion = emotionData!.pngData()!
            journalingStruct!.foodTodayIndex = index
        }else {
            emotionData = self.colorIconArray[index]
            journalingStruct!.colorEmotion = emotionData!.pngData()!
            journalingStruct!.colorTodayIndex = index
        }
        collectionView.reloadData()
    }
}
