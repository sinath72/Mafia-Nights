//
//  Let'sPlay.swift
//  Mafia Nights
//
//  Created by sina taherkhani on 2/27/23.
//

import SwiftUI

struct tuterials:View{
    var body: some View{
        VStack{
            NavigationView {
                Text("Test")
                    .navigationTitle("آموزش")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarTitleTextColor(Color.orange)
            }
        }
    }
}
struct tuterial_prev:PreviewProvider {
    static var previews: some View{
        tuterials()
    }
}
