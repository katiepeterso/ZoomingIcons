//
//  MenuViewController.swift
//  ZoomingIcons
//
//  Created by Katherine Peterson on 2015-10-01.
//  Copyright © 2015 KatieExpatriated. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MenuViewController: UICollectionViewController {
    
    var socialItems = [SocialItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let twitter = SocialItem(image: UIImage(named: "icon-twitter")!, color: UIColor(red: 0.255, green: 0.557, blue: 0.910, alpha: 1), name: "Twitter", summary: "Twitter is an online social networking service that enables users to send and read short 140-character messages called \"tweets\".")
        let facebook = SocialItem(image: UIImage(named: "icon-facebook")!, color: UIColor(red: 0.239, green: 0.353, blue: 0.588, alpha: 1), name: "Facebook", summary: "Facebook (formerly thefacebook) is an online social networking service headquartered in Menlo Park, California. Its name comes from a colloquialism for the directory given to students at some American universities.")
        let youtube = SocialItem(image: UIImage(named: "icon-youtube")!, color: UIColor(red: 0.729, green: 0.188, blue: 0.180, alpha: 1), name: "Youtube", summary: "YouTube is a video-sharing website headquartered in San Bruno, California. The service was created by three former PayPal employees in February 2005 and has been owned by Google since late 2006. The site allows users to upload, view, and share videos.")
        let vimeo = SocialItem(image: UIImage(named: "icon-vimeo")!, color: UIColor(red: 0.329, green: 0.737, blue: 0.988, alpha: 1), name: "Vimeo", summary: "Vimeo is a U.S.-based video-sharing website on which users can upload, share and view videos. Vimeo was founded in November 2004 by Jake Lodwick and Zach Klein.")
        let instagram = SocialItem(image: UIImage(named: "icon-instagram")!, color: UIColor(red: 0.325, green: 0.498, blue: 0.635, alpha: 1), name: "Instagram", summary: "Instagram is an online mobile photo-sharing, video-sharing and social networking service that enables its users to take pictures and videos, and share them on a variety of social networking platforms, such as Facebook, Twitter, Tumblr and Flickr.")
    
        socialItems += [twitter, facebook, youtube, vimeo, instagram]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
            return 2
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }else {
            return 3
        }
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SocialItemCell
        
        cell.setupCell(socialItems[(indexPath.row + 2*indexPath.section)])
        return cell
    }
    
    

    // MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let numberOfCells = self.collectionView(collectionView, numberOfItemsInSection: section)
        let widthOfCells = CGFloat(numberOfCells) * layout.itemSize.width + CGFloat(numberOfCells-1) * layout.minimumInteritemSpacing
        
        let inset = (collectionView.bounds.width - widthOfCells) / 2.0
        
        return UIEdgeInsets(top: 40, left: inset, bottom: 0, right: inset)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        controller.detailSocialItem = socialItems[(indexPath.row + 2*indexPath.section)]
        showViewController(controller, sender: self)
    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
