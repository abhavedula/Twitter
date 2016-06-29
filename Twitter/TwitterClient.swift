//
//  TwitterClient.swift
//  Twitter
//
//  Created by Abha Vedula on 6/27/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "8oWGoUhdoTtCh84p9q18IEZBP", consumerSecret: "FFuxt4OTTbnaCgEZ4TNwMUZAm0U2MEYH8qcf8slsygOrUh7JYQ")
        
    var loginSuccess: (() -> ())?
    var loginFailure: (NSError -> ())?
    
    func post(status: String) {
        POST("1.1/statuses/update.json?status=\(status)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                
        }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
        print(error.localizedDescription)
        })
        

    }
    
    func like(id: String, success: () -> (), failure: (NSError) -> ())  {
        POST("1.1/favorites/create.json?id=\(id)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            print("liked")
            success()
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
                print("like failed")
                failure(error)
        })
    }
    
    
    func retweet(id: String) {
        POST("1.1/statuses/retweet/\(id).json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            print("retweeted")
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
                print(error.localizedDescription)
        })
        
       
        

    }
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            let dictionaries = response as? [NSDictionary]
            
            let tweets = Tweet.tweetsFromArray(dictionaries!)
            
            success(tweets)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) in
                failure(error)
        })

        
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
        
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            let user = User(response: response as! NSDictionary)
            success(user)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func getUser(screenName: String, success: (User) -> (), failure: (NSError) -> ()) {
        
        GET("1.1/users/lookup.json?screen_name=\(screenName)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let arr = response![0]
            let user = User(response: arr as! NSDictionary)
            success(user)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func login(success: () -> (), failure: (NSError) -> ()) {
        
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "fbutwitter://oauth"), scope: nil, success: { (requestToken:BDBOAuth1Credential!) -> Void in
            print("Got token")
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            
            
        }) { (error: NSError!) -> Void in
            print(error.localizedDescription)
        }
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    
    func handleOpenUrl(url: NSURL) {
        
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error: NSError!) -> () in
                    self.loginFailure?(error)
            })
            
        }) { (error: NSError!) in
            self.loginFailure?(error)
        }

        
    }


}
