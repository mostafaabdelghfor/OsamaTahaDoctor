import Foundation
struct PatientInbox {
    
    
    private(set) public var Lastmessage : String!
    private(set) public var PatientName : String!
    private(set) public var LastMessageDate : String!

    
    init( Lastmessage:String , PatientName:String,LastMessageDate:String) {
        self.Lastmessage = Lastmessage
        self.PatientName = PatientName
        self.LastMessageDate = LastMessageDate
        
        
    }
    
    
}
