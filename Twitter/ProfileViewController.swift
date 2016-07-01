//  ProfileViewController.swift
//  Twitter
//
//  Created by Abha Vedula on 6/28/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var screenName: String = ""
    
    var text: String?
    var numRetweets: Int = 0
    var numFav: Int = 0
    var name: String?
    //var screenName: String?
    var profileUrl: NSURL?
    var relativeTime: String?
    var id: String?
    
    var profileButtonRow: Int?
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var numFollowersLabel: UILabel!
    @IBOutlet weak var numTweetsLabel: UILabel!
    @IBOutlet weak var numFollowingLabel: UILabel!
    @IBOutlet weak var profPicView: UIImageView!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var coverPicView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    
    
    var twitterUser: User?
    
    var tweets: [Tweet] = []

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("OwnTweetCell", forIndexPath: indexPath) as! OwnTweetCell
        
        let row = indexPath.row
        
        let tweet = tweets[row]
        
        cell.tweetTextLabel.text = tweet.text
        
        
        cell.timeLabel.text = tweet.relativeTime
        
        
        return cell
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        profPicView.layer.cornerRadius = 15
        profPicView.layer.masksToBounds = true
        
        self.navigationItem.title = "Your Profile"



        
        TwitterClient.sharedInstance.currentAccount({ (user: User) -> () in
            self.twitterUser = user
            
            self.nameLabel.text = self.twitterUser!.name
            self.screenNameLabel.text = "@\(self.twitterUser!.screenName!)"
            self.screenName = self.twitterUser!.screenName!
            self.descriptionLabel.text = self.twitterUser!.userDescription
            self.numFollowersLabel.text = "\(self.twitterUser!.numFollowers)"
            self.numFollowingLabel.text = "\(self.twitterUser!.numFollowing)"
            self.numTweetsLabel.text = "\(self.twitterUser!.numTweets)"
            self.profPicView.setImageWithURL(self.twitterUser!.profileUrl!)
            self.coverPicView.setImageWithURL(self.twitterUser!.coverUrl!)

            
            

            }, failure: { (error: NSError) -> () in
                 print(error.localizedDescription)
            
            }
            
        )
        

        TwitterClient.sharedInstance.userTweets(screenName, success: { (tweets:[Tweet]) -> () in
            
            // ... Use the new data to update the data source ...
            self.tweets = tweets
            
            
            // Reload the tableView now that there is new data
            self.tableView.reloadData()
            
            
            
            
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
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let originalImage = coverPicView.image

        
        var offset = scrollView.contentOffset.y
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        let header = coverPicView
        
        let avatar = profPicView
        
        let offset_HeaderStop: CGFloat = 70
        
        UIView.animateWithDuration(0.8, animations: {
            avatar.center.y -= 5
            self.nameLabel.center.y -= 5
            self.screenNameLabel.center.y -= 5
            }, completion: nil)
        
        if offset < 0 {
            
            let headerScaleFactor:CGFloat = -(offset) / header.bounds.height
            let headerSizevariation = ((header.bounds.height * (1.0 + headerScaleFactor)) - header.bounds.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            header.layer.transform = headerTransform
            
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
            
                       ///
            
            
            //let headerScaleFactor:CGFloat = -(offset) / header.bounds.height
            //let headerSizevariation = ((header.bounds.height * (1.0 + headerScaleFactor)) - header.bounds.height)/2.0
//            avatarTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
//            
//            avatar.layer.transform = avatarTransform
//            
//            avatarTransform = CATransform3DTranslate(avatarTransform, 0, max(-offset_HeaderStop, -offset), 0)
            
            
//
//            var context: CIContext = CIContext(options: nil)
//            var inputImage: CIImage = CIImage(image: coverPicView.image!)!
//            var blurFilter: CIFilter = CIFilter(name: "CIGaussianBlur")!
//            blurFilter.setDefaults()
//            blurFilter.setValue(inputImage, forKey: kCIInputImageKey)
//            var blurLevel: CGFloat = 20.0
//            // Set blur level
//                        //
//            // Then apply new rect
//            let output = blurFilter.outputImage
//            let cgimg = context.createCGImage(output!, fromRect: output!.extent)
//            let processedImage = UIImage(CGImage: cgimg)
//            
//            coverPicView.image = processedImage
            
            
//            let filter = "CIGaussianBlur"
//            let inputImage = coverPicView.image
//            let context = CIContext(options: nil)
//            
//            if let currentFilter = CIFilter(name: filter) {
//                let beginImage = CIImage(image: inputImage!)
//                currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
//                
//                
//                if let output = currentFilter.outputImage {
//                    let cgimg = context.createCGImage(output, fromRect: output.extent)
//                    var ciImage = CIImage(CGImage: cgimg)
//
//                    let processedImage = UIImage(CIImage: ciImage)
//                    
//                    coverPicView.image = processedImage
//                    
//                    
//                }
//            }
            
           
        }
        
        //coverPicView.image = originalImage
        
        UIView.animateWithDuration(0.5, animations: {
            avatar.center.y += 5
            self.nameLabel.center.y += 5
            self.screenNameLabel.center.y += 5
            }, completion: nil)

        
       
        
     
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let indexPathDetail = tableView.indexPathForCell(sender as! OwnTweetCell)
        
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
