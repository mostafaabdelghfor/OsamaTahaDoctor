//
//  ChatCell.swift
//  OsamaTahaCenterDoctor
//
//  Created by Macintosh HD on 3/4/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    
    @IBOutlet  weak var backcolor: UIView!

    @IBOutlet  weak var message: UITextView!
    @IBOutlet  weak var stack: UIStackView!
    @IBOutlet  weak var name: UILabel!

    @IBOutlet  weak var dateLabel: UILabel!
    @IBOutlet  weak var chatIcon: UIImageView!

    @IBOutlet  weak var chatImage: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
