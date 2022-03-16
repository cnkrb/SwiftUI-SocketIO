//
//  ContentView.swift
//  socket.io
//
//  Created by Cenk Karaboa on 11.03.2022.
//

import SwiftUI
import SocketIO

struct ContentView: View {
    
    @ObservedObject var socketManager = SocketIOManager()
    @State var place: String = "UserView"
    
    var body: some View {
        ZStack {
            if(place == "UserView") {
                UserView(socketManager: socketManager,place: $place)
            }else{
                MessageView(socketManager: socketManager,place: $place)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
