//
//  SocialItemCell.swift
//  ZoomingIcons
//
//  Created by Katherine Peterson on 2015-10-01.
//  Copyright © 2015 KatieExpatriated. All rights reserved.
//

import UIKit

class SocialItemCell: UICollectionViewCell {
    @IBOutlet weak var viewColor: UIView!
    @IBOutlet weak var imageView: UIImageView!
    var cellSocialItem = SocialItem()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewColor.layer.cornerRadius = viewColor.frame.width/2
        viewColor.layer.masksToBounds = true
    }
    
    func setupCell(socialItem: SocialItem) {
        viewColor.backgroundColor = socialItem.socialColor
        imageView.image = socialItem.socialImage
    }
    
}
