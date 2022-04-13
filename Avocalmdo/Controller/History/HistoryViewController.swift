//
//  HistoryViewController.swift
//  Avocalmdo
//
//  Created by Ilham Wibowo on 13/04/22.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.backgroundView = UIImageView(image: UIImage(named: "backgroundWhite"))
        historyTableView.dataSource = self
        historyTableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryCell")
        // Do any additional setup after loading the view.
    }

}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as? HistoryTableViewCell {
            let journal = journals[indexPath.row]
            cell.dateLabel.text = journal.date
            cell.weatherEmoji.image = journal.emojiWeather
            cell.weatherLabel.text = journal.weather
            cell.activityMemoji.image = journal.emojiActivty
            cell.activityLabel.text = journal.activity
            cell.foodEmoji.image = journal.emojiFood
            cell.foodLabel.text = journal.food
            cell.todayEmoji.image = journal.emojiOfTheDay
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
    
}
