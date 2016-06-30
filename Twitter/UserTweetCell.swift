//
//  UserTweetCell.swift
//  Twitter
//
//  Created by Abha Vedula on 6/29/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit

class UserTweetCell: UITableViewCell {

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
