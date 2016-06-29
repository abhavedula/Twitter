//
//  DetailViewController.swift
//  Twitter
//
//  Created by Abha Vedula on 6/27/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var text: String?
    var numRetweets: Int = 0
    var numFav: Int = 0
    var name: String?
    var screenName: String?
    var profileUrl: NSURL?
    var relativeTime: String?
    var id: String?
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var retweetLabel: UILabel!
    
    @IBOutlet weak var profPicView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = text
        nameLabel.text = name
        timeLabel.text = relativeTime
        screenNameLabel.text = "@\(screenName!)"
        likesLabel.text = "Likes: \(numFav)"
        retweetLabel.text = "Retweets: \(numRetweets)"
        profPicView.setImageWithURL(profileUrl!)
        print(id)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func onLikeButton(sender: AnyObject) {
        TwitterClient.sharedInstance.like(id!, success: { () -> () in
            print("liked")
            
            
            
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
                
            }
            
        )
        
        
    }
    
    
    @IBAction func onRetweetButton(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(id!)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
