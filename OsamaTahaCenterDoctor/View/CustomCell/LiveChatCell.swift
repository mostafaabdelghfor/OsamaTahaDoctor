//
//  LiveChatCell.swift
//  OsamaTahaCenterDoctor
//
//  Created by Macintosh HD on 3/4/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit

class LiveChatCell: UITableViewCell {
    @IBOutlet  weak var title: UILabel!
    @IBOutlet  weak var message: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
