//
//  Message.swift
//  socket.io
//
//  Created by Cenk Karaboa on 13.03.2022.
//

import Foundation

class Message :  Codable , Identifiable   {
    
    public var receiverUserName:String?
    public var message:String?
    public var date:String?
    
    init(receiverUserName:String,message:String,date:String) {
        self.receiverUserName=receiverUserName
        self.message=message
        self.date=date
    }
}
