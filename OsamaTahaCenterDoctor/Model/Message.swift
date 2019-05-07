import Foundation
struct Message {
    
    
    private(set) public var lastMessageDate : Date!
    private(set) public var message : String!
    private(set) public var messageType : Int!
    private(set) public var senderName : String!
    private(set) public var senderType : Int!


    init( lastMessageDate:Date , message:String,messageType:Int,senderName:String,senderType:Int) {
        self.lastMessageDate = lastMessageDate
        self.messageType = messageType
        self.senderName = senderName
        self.message = message
        self.senderType = senderType
        
        
    }
    
    
}

