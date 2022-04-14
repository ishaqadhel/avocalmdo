//
//  HistoryTableViewCell.swift
//  Avocalmdo
//
//  Created by Ilham Wibowo on 13/04/22.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherEmoji: UIImageView!
    @IBOutlet weak var activityMemoji: UIImageView!
    @IBOutlet weak var foodEmoji: UIImageView!
    @IBOutlet weak var todayEmoji: UIImageView!
   
    override func layoutSubviews() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 8
        self.rightView.layer.cornerRadius = 5
        self.middleView.layer.cornerRadius = 5
        self.leftView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
