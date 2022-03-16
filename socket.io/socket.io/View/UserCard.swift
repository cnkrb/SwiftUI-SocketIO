//
//  UserCard.swift
//  socket.io
//
//  Created by Cenk Karaboa on 13.03.2022.
//

import SwiftUI

struct UserCard : View {
    
    var name : String
    @Binding var openUserMessageScreen: Bool
    @Binding var openUserName: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15,style: .continuous)
                .fill(Color.white)
                .shadow(radius: 5)
            
            HStack {
                Text(name)
                    .font(.title3)
                    .bold()
                    .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    openUserName = name
                    openUserMessageScreen.toggle()
                }, label: {
                    HStack {
                        Image(systemName: "message")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(10)
                    }
                    .foregroundColor(.white)
                    .background(Color.purple.opacity(0.7))
                    .cornerRadius(10)
                    
                })
                    .frame(width: UIScreen.main.bounds.width/10*2)
                
            }
            .padding(10)
        }
        .padding(.horizontal)
        .frame(width: UIScreen.main.bounds.width,height: 50,alignment: .center)
        
    }
}
