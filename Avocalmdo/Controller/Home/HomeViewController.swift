//
//  HomeViewController.swift
//  Avocalmdo
//
//  Created by Mikhael Adiputra on 11/04/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
        
    // HeaderView Elements
    @IBOutlet weak var headerViewDate: UILabel!
    @IBOutlet weak var headerViewTitle: UILabel!

    // JournalingView Elements
    @IBOutlet weak var journalingView: UIView!
    @IBOutlet weak var journalingViewTitle: UILabel!
    @IBOutlet weak var journalingViewSubTitle: UILabel!
    
    @IBOutlet weak var journalingIconViewLeft: UIView!
    @IBOutlet weak var journalingIconViewMiddle: UIView!
    @IBOutlet weak var journalingIconViewRight: UIView!
    @IBOutlet weak var journalingIconViewLeftText: UILabel!
    @IBOutlet weak var journalingIconViewMiddleText: UILabel!
    @IBOutlet weak var journalingIconViewRightText: UILabel!
    
    // QuotesView Elements
    @IBOutlet weak var quoteView: UIView!
    @IBOutlet weak var quoteViewText: UILabel!
    
    // FactsView Elements
    @IBOutlet weak var factsView: UIView!
    @IBOutlet weak var factsViewBackgroundImage: UIImageView!
    @IBOutlet weak var factsViewTitle: UILabel!
    @IBOutlet weak var factsViewText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
        
        // Apply Styles on 3 Root View On Home
        journalingView.setRounded()
        quoteView.setRounded()
        factsView.setRounded()
        factsViewBackgroundImage.setRounded()
        journalingIconViewLeft.setRounded(cornerRadiusSize: 5)
        journalingIconViewMiddle.setRounded(cornerRadiusSize: 5)
        journalingIconViewRight.setRounded(cornerRadiusSize: 5)
    }

}
