//
//  UserProfileViewController.swift
//  Twitter
//
//  Created by Abha Vedula on 6/28/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var screenName: String?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var numLikesLabel: UILabel!
    @IBOutlet weak var numFollowersLabel: UILabel!
    @IBOutlet weak var numTweetsLabel: UILabel!
    @IBOutlet weak var numFollowingLabel: UILabel!
    @IBOutlet weak var profPicView: UIImageView!
    @IBOutlet weak var coverPicView: UIImageView!
    
    var twitterUser: User?
    
    var tweets: [Tweet] = []


    @IBOutlet weak var tableView: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("UserTweetCell", forIndexPath: indexPath) as! UserTweetCell
        
        let row = indexPath.row
        
        let tweet = tweets[row]
        
        cell.tweetLabel.text = tweet.text
        
        
        
        cell.timeLabel.text = tweet.relativeTime
        
        
        
        
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        profPicView.layer.cornerRadius = 15
        profPicView.layer.masksToBounds = true


        // Do any additional setup after loading the view.
        
        print("name \(screenName)")
        
        TwitterClient.sharedInstance.getUser(screenName!, success: { (user: User) -> () in
            self.twitterUser = user
            
            self.nameLabel.text = self.twitterUser!.name
            self.screenNameLabel.text = "@\(self.twitterUser!.screenName!)"
            self.descriptionLabel.text = self.twitterUser!.userDescription
            //self.numLikesLabel.text  = "Likes: \(self.twitterUser!.numFav)"
            self.numFollowersLabel.text = "\(self.twitterUser!.numFollowers)"
            self.numFollowingLabel.text = "\(self.twitterUser!.numFollowing)"
            self.numTweetsLabel.text = "\(self.twitterUser!.numTweets)"
            self.profPicView.setImageWithURL(self.twitterUser!.profileUrl!)
            self.coverPicView.setImageWithURL(self.twitterUser!.coverUrl!)
            
            
            
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
                
            }
            
        )
        
        TwitterClient.sharedInstance.userTweets(screenName!, success: { (tweets:[Tweet]) -> () in
            
            // ... Use the new data to update the data source ...
            self.tweets = tweets
            
            
            // Reload the tableView now that there is new data
            self.tableView.reloadData()
            
            
            
            
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
                
            }
            
        )

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
