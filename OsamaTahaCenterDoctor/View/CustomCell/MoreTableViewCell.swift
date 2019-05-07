//
//  MoreTableViewCell.swift
//  OsamaTahaCenterDoctor
//
//  Created by Macintosh HD on 3/4/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit

class MoreTableViewCell: UITableViewCell {

    @IBOutlet  weak var moreOptionLabel: UILabel!
    @IBOutlet  weak var liveChatNotifacationLabel: UILabel!
    @IBOutlet  weak var inboxNotifacationLabel: UILabel!
    
    
    @IBOutlet  weak var arrow: UIImageView!
    @IBOutlet  weak var changeLang: UIButton!
    
    
    @IBOutlet  weak var serviceLable: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}
