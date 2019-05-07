//
//  MyAppoinmentCell.swift
//  OsamaTahaCenterDoctor
//
//  Created by Macintosh HD on 3/5/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit

class MyAppoinmentCell: UITableViewCell {

    
    @IBOutlet  weak var dateDay: UILabel!
    @IBOutlet  weak var status: UILabel!
    @IBOutlet  weak var timeInhours: UILabel!
    @IBOutlet  weak var centerName: UILabel!
    @IBOutlet  weak var DRName: UILabel!
    @IBOutlet  weak var dayOfAppointment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
