//
//  Tweet.swift
//  Twitter
//
//  Created by Abha Vedula on 6/27/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit



class Tweet: NSObject {
    
    var text: String?
    var time: NSDate?
    var numRetweets: Int = 0
    var numFav: Int = 0
    var name: String?
    var screenName: String?
    var profileUrl: NSURL?
    var relativeTime: String?
    var id: String?
    
    init(response: NSDictionary) {
        super.init()
        
        text = response["text"] as? String
        numRetweets = (response["retweet_count"] as? Int) ?? 0
        
        numFav = (response["favorite_count"] as? Int) ?? 0
        
        name = response["user"]!["name"] as? String
        
        screenName = response["user"]!["screen_name"] as? String
        
        let timeString = response["created_at"] as? String
        
        
        
        if let timeString = timeString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            time = formatter.dateFromString(timeString as! String)
            relativeTime = AgoStringFromTime(time!)
            
        }
        
        
            let profileUrlString = response["user"]!["profile_image_url"] as? String
            
            if let profileUrlString = profileUrlString {
                let aString: String = profileUrlString
                let newString = aString.stringByReplacingOccurrencesOfString("_normal", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                profileUrl = NSURL(string: newString)
        }
            
        let response2 = response["entities"] as? NSDictionary
        let response3 = response2!["media"]
        if let response3 = response3 {
            let response4 = response3[0]
            let response5 = response4["id_str"]
            id = response5 as! String
        } else {
            id = response["id_str"] as! String
        }
       print(response)
        
    }
    
    class func tweetsFromArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(response: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
    
    func AgoStringFromTime(dateTime: NSDate) -> String {
        var timeScale: [String : Int] = ["sec": 1, "min": 60, "hr": 3600, "day": 86400, "week": 605800, "month": 2629743, "year": 31556926]
        var scale: String
        var timeAgo: Int = 0 - Int(dateTime.timeIntervalSinceNow)
        if timeAgo < 60 {
            scale = "sec"
        }
        else if timeAgo < 3600 {
            scale = "min"
        }
        else if timeAgo < 86400 {
            scale = "hr"
        }
        else if timeAgo < 605800 {
            scale = "day"
        }
        else if timeAgo < 2629743 {
            scale = "week"
        }
        else if timeAgo < 31556926 {
            scale = "month"
        }
        else {
            scale = "year"
        }
        
        timeAgo = timeAgo / timeScale[scale]!
        var s: String = ""
        if timeAgo > 1 {
            s = "s"
        }
        return "\(timeAgo) \(scale)\(s)"
    }


}
