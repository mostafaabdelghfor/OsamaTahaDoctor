//
//  ChatCellImage.swift
//  OsamaTahaCenterDoctor
//
//  Created by Macintosh HD on 3/19/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit

class ChatCellImage: UITableViewCell {

    
    @IBOutlet  weak var chatImage: UIImageView!
    @IBOutlet  weak var name: UILabel!

//    @IBOutlet  weak var backcolor: UIView!
//    @IBOutlet  weak var stack: UIStackView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
