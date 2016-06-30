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
        
        TwitterClient.sharedInstance.mentionsTimeline({ (tweets:[Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
            
            
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
                
            }
            
        )


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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
