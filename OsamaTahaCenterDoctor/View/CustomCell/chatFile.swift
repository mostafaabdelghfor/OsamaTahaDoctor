//
//  chatFile.swift
//  OsamaTahaCenterDoctor
//
//  Created by Macintosh HD on 3/20/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit

class chatFile: UITableViewCell {

    
    @IBOutlet  weak var downloadFileLeading: UIButton!
    @IBOutlet  weak var downloadFileTrailing: UIButton!

    @IBOutlet  weak var nameleaading: UILabel!
    @IBOutlet  weak var nameTrailing: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
