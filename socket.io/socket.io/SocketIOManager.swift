//
//  SocketManager.swift
//  socket.io
//
//  Created by Cenk Karaboa on 13.03.2022.
//

import SwiftUI
import SocketIO

class SocketIOManager: ObservableObject {
    
    let manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!, config: [.log(true), .compress])
    var socket : SocketIOClient? = nil
    
    @Published var messageList = [Message]()
    @Published  var userList = [String]()
    @Published var userName = ""
    @Published var isLogin : Bool = false
    @Published var sendUserName = ""
    
    init(){
        socket = manager.defaultSocket
        openConnect()
        listener()
    }
    
    func closeConnect(){
        socket?.disconnect()
    }
    
    func openConnect(){
        socket?.connect()
    }
    
    func listener(){
        listenUserConnection()
        errorSameUser()
        listenUserDisconnection()
        listenUserMessage()
    }
    
    func exitUserList() {
        self.socket?.emit("exitUserList", userName)
    }
    
    func connectToServer(userName: String){
        self.socket?.emit("connectUser",userName);
        self.userName = userName
    }
    
    func sendMessage(message: String) {
        self.socket?.emit("userToMessage", message, sendUserName)
    }
    
    func listenUserMessage(){
        self.socket?.on("getUserMessage") { [weak self] (data, ack) in
            if let data = data[0] as? [String: String],
               let message = data["message"] {
                let receiverUserName = data["receiverUserName"]
                let date = data["date"]
                DispatchQueue.main.async {
                    self?.messageList.append(Message(receiverUserName:receiverUserName!, message:message, date:date!))
                }
                
            }
        }
    }
    
    
    
    func listenUserConnection(){
        self.socket?.on("users") { [weak self] (data, ack) in
            if let data = data[0] as? [String: String],
               let userName = data["userName"] {
                DispatchQueue.main.async {
                    if (self?.userName != userName) {
                        self?.userList.append(userName)
                    }
                }
            }
        }
    }
    
    func listenUserDisconnection(){
        self.socket?.on("exitUser") { [weak self] (data, ack) in
            if let data = data[0] as? [String: String],
               let userName = data["userName"] {
                DispatchQueue.main.async {
                    if let index = self?.userList.firstIndex(of: userName) {
                        self?.userList.remove(at: index)
                    }
                }
            }
        }
    }
    
    func errorSameUser(){
        self.socket?.on("error") { [weak self] (data, ack) in
            if let data = data[0] as? [String: String],
               let error = data["error"] {
                DispatchQueue.main.async {
                    print("Error: \(error)")
                }
            }
        }
    }
}
