//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Abha Vedula on 6/28/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var tweetTextView: UITextView!
    
    @IBOutlet weak var countLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextView.delegate = self
        self.updateCharacterCount()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onTweetButton(sender: AnyObject) {
        let status = tweetTextView.text
        
        let aString: String = status!
        
        let newString = aString.stringByReplacingOccurrencesOfString(", ", withString: "%2c")
        let newString2 = newString.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
            TwitterClient.sharedInstance.post(newString2)
        
        performSegueWithIdentifier("backToFeed", sender: nil)
    }
    
    func updateCharacterCount() {
        self.countLabel.text = "\((140) - self.tweetTextView.text.characters.count)"
    }
    
    func textViewDidChange(textView: UITextView) {
        self.updateCharacterCount()
    }
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        self.updateCharacterCount()
        return textView.text.characters.count +  (text.characters.count - range.length) <= 140
    }
  
    
    
}
