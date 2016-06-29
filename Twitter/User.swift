//
//  User.swift
//  Twitter
//
//  Created by Abha Vedula on 6/27/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String?
    var screenName: String?
    var userDescription: String?
    var profileUrl: NSURL?
    var numFav: Int = 0
    var numFollowers: Int = 0
    var numFollowing: Int = 0
    var numTweets: Int = 0
    var coverUrl: NSURL?

    
    var dictionary: NSDictionary?
    
    init(response: NSDictionary) {
        self.dictionary = response
        name = response["name"] as? String
        screenName = response["screen_name"] as? String
        userDescription = response["description"] as? String
        numTweets = response["statuses_count"] as! Int
        numFav = response["favourites_count"] as! Int
        numFollowers = response["followers_count"] as! Int
        numFollowing = response["friends_count"] as! Int
        
        
        let profileUrlString = response["profile_image_url_https"] as? String
        
        if let profileUrlString = profileUrlString {
            let aString: String = profileUrlString
            let newString = aString.stringByReplacingOccurrencesOfString("_normal", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            profileUrl = NSURL(string: newString)
        }
        
        let coverUrlString = response["profile_banner_url"] as? String
        
        if let coverUrlString = coverUrlString {
            coverUrl = NSURL(string: coverUrlString)
        }
        
        print(response)
        
    }
    
    static var _currentUser: User?
    
    static let userDidLogoutNotification = "UserDidLogout"

    
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = NSUserDefaults.standardUserDefaults()
                let userData = defaults.objectForKey("currentUserData") as? NSData
            
                if let userData = userData {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                    _currentUser  = User(response: dictionary)
                }
                
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                
                defaults.setObject(data, forKey: "currentUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData")

            }
            
            defaults.synchronize()
        }
    }
    
   

}
