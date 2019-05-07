//
//  myAppointmentsDeatils.swift
//  OsamaTahaCenter
//
//  Created by Macintosh HD on 2/26/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import Foundation
struct patientVisitis {
    
    
    private(set) public var doctorNAme : String!
    private(set) public var visitId : String!
    private(set) public var dateVistTime : String!
    
    
    init( doctorNAme:String, visitId:String , dateVistTime:String) {
        self.doctorNAme = doctorNAme
        self.visitId = visitId
        self.dateVistTime = dateVistTime
    }
    
    
}

