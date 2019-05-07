//
//  MedicalRecordsCell.swift
//  OsamaTahaCenterDoctor
//
//  Created by Macintosh HD on 3/5/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import UIKit

class MedicalRecordsCell: UITableViewCell {

    @IBOutlet  weak var doctorName: UILabel!
    @IBOutlet  weak var dateVisitTime: UILabel!
    @IBOutlet  weak var visitId: UILabel!
    @IBOutlet  weak var centerName: UILabel!
    
    @IBOutlet  weak var checkVisitPdf: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
