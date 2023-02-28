//
//  AlreadyPlayers.swift
//  Mafia Nights
//
//  Created by sina taherkhani on 2/27/23.
//

import SwiftUI
struct alreadyPlayers:View {
    var body:some View{
        VStack{
            NavigationView{
                Text("O")
                    .navigationTitle("بازیکنان ثابت")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarTitleTextColor(Color.indigo)
            }
        }
    }
}
struct alreadyPlayer_preview:PreviewProvider {
    static var previews: some View{
        alreadyPlayers()
    }
}
