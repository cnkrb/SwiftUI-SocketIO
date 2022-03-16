//
//  TestView.swift
//  socket.io
//
//  Created by Cenk Karaboa on 13.03.2022.
//

import SwiftUI

struct MessageCard: View {
    var contentMessage: String = ""
    var date: String = ""
    var isCurrentUser: Bool = false
    
    var body: some View {
        HStack {
            
            if (isCurrentUser){
                Spacer()
            }
            
            HStack {
                Text(contentMessage)
                    .font(.system(size: 20))
                    .padding(.trailing,20)
                    .frame(width: .infinity, height: 35, alignment: .center)
                
                ZStack {
                    Text(date)
                        .font(.system(size: 13))
                    
                }.frame(width: .infinity, height: 35, alignment: .bottomTrailing)
                
                
            }
            .padding(10)
            .foregroundColor(isCurrentUser ? Color.white : Color.black)
            .background(isCurrentUser ? Color.blue :  Color("CustomGray"))
            .cornerRadius(10)
            
            if (!isCurrentUser){
                Spacer()
            }
            
        }
        .padding(.horizontal,10)
        .padding(.vertical,5)
        
    }
}
