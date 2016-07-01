//
//  UserProfileViewController.swift
//  Twitter
//
//  Created by Abha Vedula on 6/28/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var numLikesLabel: UILabel!
    @IBOutlet weak var numFollowersLabel: UILabel!
    @IBOutlet weak var numTweetsLabel: UILabel!
    @IBOutlet weak var numFollowingLabel: UILabel!
    @IBOutlet weak var profPicView: UIImageView!
    @IBOutlet weak var coverPicView: UIImageView!
    
    
    var text: String?
    var numRetweets: Int = 0
    var numFav: Int = 0
    var name: String?
    var screenName: String?
    var profileUrl: NSURL?
    var relativeTime: String?
    var id: String?
    
    var profileButtonRow: Int?
    
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
    
    @IBAction func followButton(sender: AnyObject) {
        
        if twitterUser?.following == false {
        
        let id = twitterUser!.id!
        
        print(id)
        
        TwitterClient.sharedInstance.follow(id, success: { () -> () in
            
            //self.tableView.reloadData()
            
            
            
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
                
            }
            
        )
            
          let button = sender as! UIButton
            button.setTitle("Following", forState: UIControlState.Normal)
        
        } else {
            print("already following")
        }
        

    }
    
    
    @IBOutlet weak var followLabel: UILabel!
    
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
            
            let cover = self.twitterUser!.coverUrl
            if let cover = cover {
                self.coverPicView.setImageWithURL(self.twitterUser!.coverUrl!)
            }
            
            
            if self.twitterUser?.following == true {
                self.followLabel.text = "Following"
            } else {
                self.followLabel.hidden = true
            }
            
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPathDetail = tableView.indexPathForCell(sender as! UserTweetCell)
        
        let detailViewController = segue.destinationViewController as! DetailViewController
        
        var row: Int!
        
        row = indexPathDetail?.row
        
        let tweet = tweets[row!]
        
        
        text = tweet.text
        
        name = tweet.name!
        
        screenName = tweet.screenName!
        
        relativeTime = tweet.relativeTime
        
        profileUrl = tweet.profileUrl!
        
        numRetweets = tweet.numRetweets
        
        numFav = tweet.numFav
        
        
        
        if let button = sender as? UIButton {
            if let superview = button.superview {
                if let cell = superview.superview as? TweetCell {
                    row = tableView.indexPathForCell(cell)?.row
                }
            }
        }
        
        
        id = tweet.id!
        
        
        detailViewController.name = self.name
        detailViewController.text = self.text
        detailViewController.numRetweets = self.numRetweets
        detailViewController.numFav = self.numFav
        detailViewController.screenName = self.screenName
        detailViewController.profileUrl = self.profileUrl
        detailViewController.relativeTime = self.relativeTime
        detailViewController.id = self.id
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
