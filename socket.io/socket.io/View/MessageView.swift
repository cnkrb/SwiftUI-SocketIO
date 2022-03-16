//
//  MessageView.swift
//  socket.io
//
//  Created by Cenk Karaboa on 13.03.2022.
//

import SwiftUI

struct MessageView: View {
    
    @StateObject var socketManager = SocketIOManager()
    @Binding var place: String
    @State var message : String = ""
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Button(action: {
                    withAnimation{
                        self.place = "UserView"
                    }
                }, label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                })
                
                Spacer()
                
                Text(socketManager.sendUserName)
                    .font(.system(size: 25, weight: .bold))
                
                Spacer()
                
            }
            .padding()
            
            Spacer()
            
            VStack {
                ScrollView {
                    ForEach(self.socketManager.messageList) { user in
                        MessageCard(contentMessage: user.message!,date:user.date! , isCurrentUser: user.receiverUserName == socketManager.sendUserName).foregroundColor(.black)
                    }
                }
            }
            
            Spacer()
            
            VStack {
                
                
                TextField("Mesaj...",text: $message)
                    .padding(10)
                
                Button(action: {
                    
                    self.socketManager.sendMessage(message: message)
                    
                }, label: {
                    HStack {
                        Text("Gönder")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth:.infinity,maxHeight: .infinity)
                    .background(.green)
                    .cornerRadius(15)
                    
                    
                })
            }
            .padding(.horizontal)
            .frame(width: UIScreen.main.bounds.width,height:90 ,alignment: .center)
        }
    }
}

