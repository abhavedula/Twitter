//
//  OwnTweetCell.swift
//  Twitter
//
//  Created by Abha Vedula on 6/30/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit

class OwnTweetCell: UITableViewCell {

    @IBOutlet weak var tweetTextLabel: UILabel!
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
