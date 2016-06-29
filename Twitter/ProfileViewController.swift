//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Abha Vedula on 6/28/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var numLikesLabel: UILabel!
    @IBOutlet weak var numFollowersLabel: UILabel!
    @IBOutlet weak var numTweetsLabel: UILabel!
    @IBOutlet weak var numFollowingLabel: UILabel!
    @IBOutlet weak var profPicView: UIImageView!
    
    
    

    @IBOutlet weak var titleLabel: UILabel!
    
    
    var twitterUser: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterClient.sharedInstance.currentAccount({ (user: User) -> () in
            self.twitterUser = user
            
            self.nameLabel.text = self.twitterUser!.name
            self.screenNameLabel.text = "@\(self.twitterUser!.screenName!)"
            self.descriptionLabel.text = self.twitterUser!.userDescription
            self.numLikesLabel.text  = "Likes: \(self.twitterUser!.numFav)"
            self.numFollowersLabel.text = "Followers: \(self.twitterUser!.numFollowers)"
            self.numFollowingLabel.text = "Following: \(self.twitterUser!.numFollowing)"
            self.numTweetsLabel.text = "Tweets: \(self.twitterUser!.numTweets)"
            self.profPicView.setImageWithURL(self.twitterUser!.profileUrl!)

            
            

            }, failure: { (error: NSError) -> () in
                 print(error.localizedDescription)
            
            }
            
        )

        
        
        titleLabel.font = UIFont(name: "Helvetica", size: 26.0)!
        

        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
