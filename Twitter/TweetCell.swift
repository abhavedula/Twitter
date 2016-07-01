//
//  TweetCell.swift
//  Twitter
//
//  Created by Abha Vedula on 6/27/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    
    
    @IBOutlet weak var field: UITextView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var profPic: UIImageView!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   

}
