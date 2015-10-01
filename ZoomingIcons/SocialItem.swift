//
//  SocialItem.swift
//  ZoomingIcons
//
//  Created by Katherine Peterson on 2015-10-01.
//  Copyright © 2015 KatieExpatriated. All rights reserved.
//

import UIKit

class SocialItem: NSObject {
    
    var socialImage = UIImage()
    var socialColor = UIColor()
    var socialName = String()
    var socialSummary = String()
    
    convenience init(image:UIImage, color:UIColor, name:String, summary:String) {
        self.init()
        socialImage = image
        socialColor = color
        socialName = name
        socialSummary = summary
    }
}
