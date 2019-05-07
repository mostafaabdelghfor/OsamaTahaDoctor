import Foundation
struct PatientInboxModel {
    
    
    private(set) public var Lastmessage : String!
    private(set) public var PatientName : String!
    private(set) public var LastMessageDate : Date!
    
    private(set) public var PatientId : String!
    
    init( Lastmessage:String , PatientName:String,LastMessageDate:Date,PatientId:String) {
        self.Lastmessage = Lastmessage
        self.PatientName = PatientName
        self.LastMessageDate = LastMessageDate
        self.PatientId = PatientId

        
    }
        
        
    }
    
    








