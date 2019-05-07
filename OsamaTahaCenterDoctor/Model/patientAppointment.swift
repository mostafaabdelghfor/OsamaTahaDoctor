//
//  myAppointmentsDeatils.swift
//  OsamaTahaCenter
//
//  Created by Macintosh HD on 2/26/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import Foundation
struct patientAppintment {
    
    
    private(set) public var doctorNAme : String!
    private(set) public var centerName : String!
    private(set) public var statues : String!
    private(set) public var date : String!
    
    
    init( doctorNAme:String, centerName:String , statues:String,date:String) {
        self.doctorNAme = doctorNAme
        self.centerName = centerName
        self.statues = statues
        self.date = date
    }
    
    
}
