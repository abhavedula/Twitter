//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Abha Vedula on 6/27/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit
import AFNetworking
import BDBOAuth1Manager



class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tweets: [Tweet] = []
    
    var text: String?
    var numRetweets: Int = 0
    var numFav: Int = 0
    var name: String?
    var screenName: String?
    var profileUrl: NSURL?
    var relativeTime: String?
    var id: String?
    
    var profileButtonRow: Int?

 
    @IBAction func onComposeButton(sender: AnyObject) {
        performSegueWithIdentifier("composeSegue", sender: nil)
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
        
    }
    
    
    
    @IBAction func onRetweetButton(sender: AnyObject) {
        
        var row: Int!
        
        if let button = sender as? UIButton {
            if let superview = button.superview {
                if let cell = superview.superview as? TweetCell {
                    row = tableView.indexPathForCell(cell)?.row
                }
            }
        }
        
        let tweet = tweets[row]
        
        id = tweet.id!
        
        TwitterClient.sharedInstance.retweet(id!)
    }
    
    
    
    @IBAction func onLikeButton(sender: AnyObject) {
        
        var row: Int!
        
        if let button = sender as? UIButton {
            if let superview = button.superview {
                if let cell = superview.superview as? TweetCell {
                    row = tableView.indexPathForCell(cell)?.row
                }
            }
        }
        
        let tweet = tweets[row]
                
        let id = tweet.id!
        
        print(id)
        
        TwitterClient.sharedInstance.like(id, success: { () -> () in
            
            self.tableView.reloadData()
            
            
            
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
                
            }
            
        )

    }
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)


        
        tableView.delegate = self
        tableView.dataSource = self
        
        TwitterClient.sharedInstance.homeTimeline({ (tweets:[Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
            
            
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        
        }
        
        )
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        let row = indexPath.row
        
        let tweet = tweets[row]
        
        cell.tweetTextLabel.text = tweet.text
        
        
        cell.nameLabel.text = tweet.name!
        
        
        cell.screenNameLabel.text = "@\(tweet.screenName!)"
        
        
        cell.timeLabel.text = tweet.relativeTime
        
        cell.profPic.setImageWithURL(tweet.profileUrl!)
        
        
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        let twitterClient = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "8oWGoUhdoTtCh84p9q18IEZBP" , consumerSecret: "FFuxt4OTTbnaCgEZ4TNwMUZAm0U2MEYH8qcf8slsygOrUh7JYQ")

        
        twitterClient.GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            let dictionaries = response as? [NSDictionary]
            
            self.tweets = Tweet.tweetsFromArray(dictionaries!)
            
            
            self.tableView.reloadData()
            
            // Tell the refreshControl to stop spinning
            refreshControl.endRefreshing()
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
                print("error refreshing")
        })
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        if segue.identifier == "DetailSegue" {

        let indexPathDetail = tableView.indexPathForCell(sender as! TweetCell)
            
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
        } else if segue.identifier == "UserProfileSegue" {
            
           
            
            let profViewController = segue.destinationViewController as! UserProfileViewController
            
            
            
            let tweet = tweets[profileButtonRow!]
            
            screenName = tweet.screenName!
            
            profViewController.screenName = self.screenName

            
        }
        
    }
    
    @IBAction func userProfileButton(sender: AnyObject) {
        
        if let button = sender as? UIButton {
            if let superview = button.superview {
                if let cell = superview.superview as? TweetCell {
                    profileButtonRow = tableView.indexPathForCell(cell)?.row
                }
            }
        }
        

        performSegueWithIdentifier("UserProfileSegue", sender: nil)
    
    }
    

}
