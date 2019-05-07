//
//  URLS.swift
//  TopServiceClient
//
//  Created by Macintosh HD on 10/31/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import Foundation
struct URLS {
    static let main = "https://api.instahealthsolutions.com/osama_t/"
    
    static let imageUrl = "http://192.168.1.83/workspace/top/"
    
    
    
    static let Login = main + "Customer/Login.do?_method=login"
    
    static let getPatient = main + "Customer/Registration/GeneralRegistration.do?_method=findPatient"
    
        static let getPatinetAppointment = main + "Customer/doctorscheduler.do?_method=getPatientAppointments"
    
    
    static let getPatientsVisits = main + "Customer/Registration/GeneralRegistration.do?_method=getPatientVisits"
    
    
      static let getPatientsVisitsPDF = main + "Customer/DiagnosticModule/DiagPrint.do?_method=getDiagReportsForVisit"
    
    static let getPatientsVisitsEMRPDF = main + "Customer/emr/VisitEMRView.do?_method=getVisitEMR"
    
    
    static let getPatientAccessMobile = main + "Customer/mobileaccess.do?_method=enablePatientMobileAccess"
    
   
    
}


