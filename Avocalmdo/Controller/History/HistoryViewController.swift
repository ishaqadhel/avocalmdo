//
//  HistoryViewController.swift
//  Avocalmdo
//
//  Created by Ilham Wibowo on 13/04/22.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    
    private var journalArray = [Journaling]()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewWillAppear(_ animated: Bool) {
        loadItem()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTableView.backgroundView = UIImageView(image: UIImage(named: "backgroundWhite"))
        historyTableView.dataSource = self
        historyTableView.delegate = self
        
        historyTableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryCell")
      
    }

    private func loadItem() {
        let request: NSFetchRequest<Journaling> = Journaling.fetchRequest()
        do {
            journalArray = try context.fetch(request)
        } catch {
           print("Fetching data Failed")
        }
        historyTableView.reloadData()
    }
}

extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journalArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as? HistoryTableViewCell {
            let journal = journalArray[indexPath.row]
            cell.dateLabel.text = journal.dateDetail
            cell.weatherEmoji.image = UIImage(data: journal.weatherEmotion!)
            cell.activityMemoji.image = UIImage(data: journal.activityEmotion!)
            cell.todayEmoji.image = UIImage(data: journal.todayEmotion!)
            cell.foodEmoji.image = UIImage(data: journal.foodEmotion!)
          
            return cell
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
}
