//
//  HistoryTableViewCell.swift
//  Avocalmdo
//
//  Created by Ilham Wibowo on 13/04/22.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherEmoji: UIImageView!
    @IBOutlet weak var activityMemoji: UIImageView!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var foodEmoji: UIImageView!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var todayEmoji: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
