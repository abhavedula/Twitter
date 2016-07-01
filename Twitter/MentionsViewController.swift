//
//  MentionsViewController.swift
//  Twitter
//
//  Created by Abha Vedula on 6/30/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var tweets: [Tweet] = []
    
    var text: String?
    var numRetweets: Int = 0
    var numFav: Int = 0
    var name: String?
    var screenName: String?
    var profileUrl: NSURL?
    var relativeTime: String?
    var id: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    



    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.title = "Mentions"

        
        TwitterClient.sharedInstance.mentionsTimeline({ (tweets:[Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
            
            
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
                
            }
            
        )
        
        let customTabBarItem = UITabBarItem(title: "Mentions", image: UIImage(named: "speaker-7"), selectedImage: UIImage(named: "speaker-7"))
        self.tabBarItem = customTabBarItem
        



        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MentionsTweetCell", forIndexPath: indexPath) as! MentionsTweetCell
        
        let row = indexPath.row
        
        let tweet = tweets[row]
        
        cell.tweetLabel.text = tweet.text
        
        
        cell.nameLabel.text = tweet.name!
        
        
        cell.screenNameLabel.text = "@\(tweet.screenName!)"
        
        
        cell.timeLabel.text = tweet.relativeTime
       cell.profPicView.setImageWithURL(tweet.profileUrl!)
        
        
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
            let indexPathDetail = tableView.indexPathForCell(sender as! MentionsTweetCell)
            
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
