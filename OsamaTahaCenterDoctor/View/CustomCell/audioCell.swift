//
//  audioCell.swift
//  OsamaTahaCenterDoctor
//
//  Created by Macintosh HD on 4/14/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit

class audioCell: UITableViewCell {

    
    @IBOutlet  weak var playLeading: UIButton!
    @IBOutlet  weak var playTrialing: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
