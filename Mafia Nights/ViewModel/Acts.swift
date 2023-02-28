//
//  Acts.swift
//  Mafia Nights
//
//  Created by sina taherkhani on 2/27/23.
//

import SwiftUI

struct Acts:View {
    @Binding var PlayerName:[String]
    var body: some View{
        VStack(spacing: 0){
            NavigationView {
                Color.brown
                    .ignoresSafeArea()
                    .overlay(
                        List{
                            ForEach(0..<PlayerName.count,id:\.self){ i in
                                Text(PlayerName[i].description)
                            }
                        }
                            .navigationTitle("نقش ها")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarTitleTextColor(.black)
                    )
            }
        }
    }
}
struct Acts_preview:PreviewProvider {
    static var previews: some View{
        Acts(PlayerName: .constant([]))
    }
}
