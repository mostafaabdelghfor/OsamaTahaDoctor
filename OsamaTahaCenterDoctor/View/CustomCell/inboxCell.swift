//
//  inboxCell.swift
//  OsamaTahaCenterDoctor
//
//  Created by Macintosh HD on 3/25/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit

class inboxCell: UITableViewCell {

    @IBOutlet  weak var lastMessage: UILabel!
    @IBOutlet  weak var PatientNAme: UILabel!
    @IBOutlet  weak var LastMessageDate: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
