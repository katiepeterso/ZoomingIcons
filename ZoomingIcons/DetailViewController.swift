//
//  DetailViewController.swift
//  ZoomingIcons
//
//  Created by Katherine Peterson on 2015-10-01.
//  Copyright © 2015 KatieExpatriated. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailSummaryLabel: UILabel!
    @IBOutlet var detailView: UIView!
    var detailSocialItem = SocialItem()
    
    convenience init(socialItem:SocialItem) {
        self.init()
        detailSocialItem = socialItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        detailImageView.image = detailSocialItem.socialImage
        detailNameLabel.text = detailSocialItem.socialName
        detailSummaryLabel.text = detailSocialItem.socialSummary
        detailView.backgroundColor = detailSocialItem.socialColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backToMenu(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }

}

