import Foundation
struct Patient {
    
    
    private(set) public var name : String!
    private(set) public var mr_no : String!
    
    private(set) public var dateOfBirth : String!
    private(set) public var Phone : String!



        
    init( name:String , mr_no:String,dateOfBirth:String , Phone:String) {
        self.name = name
        self.mr_no = mr_no
        self.dateOfBirth = dateOfBirth
        self.Phone = Phone
        
    }
    
    
}
