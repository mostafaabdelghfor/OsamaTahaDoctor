//
//  LiveChatModel.swift
//  OsamaTahaCenterDoctor
//
//  Created by Macintosh HD on 3/26/19.
//  Copyright © 2019 Macintosh HD. All rights reserved.
//

import Foundation
struct LiveChatModel {
    
    
    private(set) public var title : String!
    private(set) public var message : String!

    private(set) public var groupId : String!

    
    init( title:String , message:String,groupId:String) {
        self.title = title

        self.message = message
        self.groupId = groupId
        
        
    }
    
    
}
