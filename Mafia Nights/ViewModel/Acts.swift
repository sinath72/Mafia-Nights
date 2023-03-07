//
//  Acts.swift
//  Mafia Nights
//
//  Created by sina taherkhani on 2/27/23.
//

import SwiftUI

struct Acts:View {
    @Binding var PlayerName:[String]
    @State private var Acts:[Act_Model] = []
    var body: some View{
        VStack(spacing: 0){
            NavigationView {
                Color.brown
                    .ignoresSafeArea()
                    .overlay(
                        List{
                            ForEach(0..<Acts.count,id:\.self){ i in
                                Toggle(isOn: $Acts[i].Modify) { Text(Acts[i].ActName.description)
                                }
                                .listRowBackground(Color.teal)
                            }
                        }.scrollContentBackground(.visible)
                            .listStyle(.plain)
                            .onAppear{
                                Acts = DB().getActsList()
                            }
                            .toolbar(content: {
                                Button(" "){
                                    
                                }
                                .background(Image(systemName: "plus"))
                                .padding()
                            })
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
        Acts(PlayerName: .constant(["ppp","lll","kkk"]))
    }
}
