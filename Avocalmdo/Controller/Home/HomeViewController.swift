//
//  HomeViewController.swift
//  Avocalmdo
//
//  Created by Mikhael Adiputra on 11/04/22.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
        
    // HeaderView Elements
    @IBOutlet weak var headerViewDate: UILabel!
    @IBOutlet weak var headerViewTitle: UILabel!

    // JournalingView Elements
    @IBOutlet var journalingViewArrowButton: UIButton!
    @IBOutlet weak var journalingView: UIView!
    @IBOutlet weak var journalingViewTitle: UILabel!
    @IBOutlet weak var journalingViewSubTitle: UILabel!
    
    @IBOutlet weak var journalingIconViewLeft: UIView!
    @IBOutlet weak var journalingIconViewMiddle: UIView!
    @IBOutlet weak var journalingIconViewRight: UIView!
    
    // QuotesView Elements
    @IBOutlet weak var quoteView: UIView!
    @IBOutlet weak var quoteViewText: UILabel!
    
    // FactsView Elements
    @IBOutlet weak var factsView: UIView!
    @IBOutlet weak var factsViewBackgroundImage: UIImageView!
    @IBOutlet weak var factsViewTitle: UILabel!
    @IBOutlet weak var factsViewText: UILabel!
    
    @IBOutlet weak var imageRight: UIImageView!
    @IBOutlet weak var imageMiddle: UIImageView!
    @IBOutlet weak var imageLeft: UIImageView!
    @IBOutlet weak var dateLabelJournal: UILabel!
    @IBOutlet weak var journalTitle: UILabel!
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let date = Date()
    private let userDefaults = UserDefaults.standard
    private var journal = [Journaling]()

    
    override func viewWillAppear(_ animated: Bool) {
        loadItem()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        journalingView.setShadowj()
        quoteView.setShadowj()
        factsView.setShadowj()
        journalingView.setRounded()
        quoteView.setRounded()
        factsView.setRounded()
        factsViewBackgroundImage.setRounded()
        journalingIconViewLeft.setRounded(cornerRadiusSize: 5)
        journalingIconViewMiddle.setRounded(cornerRadiusSize: 5)
        journalingIconViewRight.setRounded(cornerRadiusSize: 5)
        
        journalingView.isUserInteractionEnabled = true
        let tapped = UITapGestureRecognizer(target: self, action: #selector(responseJournal(_:)))
        journalingView.addGestureRecognizer(tapped)
        
        let todayDate = getTodayDate()
        let userName = userDefaults.string(forKey: "name")
        headerViewTitle.text = "Hello, \(userName!)!"
        headerViewDate.text  = todayDate
    }
    
    private func getTodayDate() -> String {
        let dateF = DateFormatter()
        dateF.dateFormat = "EEEE, MMM d yyyy"
        let todayDate = dateF.string(from: date)
        return todayDate
    }
    
    @objc private func responseJournal(_ gesture : UITapGestureRecognizer) {
        performSegue(withIdentifier: "goToJournaling", sender: self)
    }
    
    private func loadItem() {
        let request: NSFetchRequest<Journaling> = Journaling.fetchRequest()
        let todayDate = getTodayDate()
        let resultPredicate2 = NSPredicate(format: "dateDetail == %@", todayDate)
        request.predicate = resultPredicate2
       do {
           journal = try context.fetch(request)
        
           if journal.count != 0 {
               imageLeft.image = UIImage(data: journal[0].foodEmotion!)
               imageMiddle.image = UIImage(data: journal[0].todayEmotion!)
               imageRight.image = UIImage(data: journal[0].activityEmotion!)
               dateLabelJournal.text = todayDate
               journalTitle.text = "Today's Journal"
           }
       } catch {
           print("Fetching data Failed")
       }
    }
}
