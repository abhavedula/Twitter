//
//  MentionsTweetCell.swift
//  Twitter
//
//  Created by Abha Vedula on 6/30/16.
//  Copyright © 2016 Abha Vedula. All rights reserved.
//

import UIKit

class MentionsTweetCell: UITableViewCell {

    @IBOutlet weak var profPicView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
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
