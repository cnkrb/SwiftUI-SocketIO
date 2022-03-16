//
//  UserView.swift
//  socket.io
//
//  Created by Cenk Karaboa on 13.03.2022.
//

import SwiftUI


struct UserView: View {
    
    @ObservedObject var socketManager = SocketIOManager()
    @State var textUserName: String = ""
    @Binding var place: String
    
    @State var openUserMessageScreen: Bool = false
    @State var openUserName: String = ""
    
    var body: some View {
        
        ZStack {
            VStack {
                
                Text("Aktif Kullanıcılar")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.bottom,20)
                
                VStack (spacing:10) {
                    ForEach(self.socketManager.userList, id: \.self) { user in
                        UserCard(name: user,openUserMessageScreen: $openUserMessageScreen,openUserName: $openUserName)
                            .foregroundColor(.black)
                            .padding()
                    }
                }
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15,style: .continuous)
                        .fill(Color.white)
                        .shadow(radius: 5)
                    
                    VStack {
                        
                        if(!socketManager.isLogin){
                            TextField("Kullanıcı Adı...",text: $textUserName)
                                .padding(10)
                        }
                        
                        Button(action: {
                            if(!socketManager.isLogin){
                                socketManager.connectToServer(userName: textUserName)
                            }else {
                                socketManager.exitUserList()
                            }
                            socketManager.isLogin.toggle()
                            
                        }, label: {
                            HStack {
                                Text(socketManager.isLogin ? "Çıkış Yap" : "Giriş Yap")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth:.infinity,maxHeight: .infinity)
                            .background(.green)
                            .cornerRadius(15)
                            
                            
                        })
                    }
                    
                    
                }
                .padding(.horizontal)
                .frame(width: UIScreen.main.bounds.width,height: !socketManager.isLogin ? 90 : 50,alignment: .center)
                
            }
            
            .onChange(of: openUserMessageScreen ){ newBoolValue in
                withAnimation{
                    socketManager.sendUserName = openUserName
                    self.place = "MessageView"
                }
            }
        }
    }
}
