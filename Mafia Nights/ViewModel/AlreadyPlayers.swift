//
//  AlreadyPlayers.swift
//  Mafia Nights
//
//  Created by sina taherkhani on 2/27/23.
//

import SwiftUI
struct alreadyPlayers:View {
    @State private var AlreadyArray:[PlayerModel] = [PlayerModel(id: 1, name: "2", modify: false)]
    @State private var name:String = ""
    @State private var isPresent:Bool = false
    var body:some View{
        VStack{
            NavigationView{
                Color.mint
                    .ignoresSafeArea()
                    .overlay{
                        List{
                            ForEach(0..<AlreadyArray.count,id: \.self){ i in
                                Text(AlreadyArray[i].name)
                            }
                        }.toolbar(content: {
                            Button(" "){
                                isPresent = true
                            }.alert("نام بازیکن ثابت", isPresented: $isPresent,actions: {
                                TextField("نام بازیکن",text: $name)
                                Button("افزودن", action: {
                                    
                                })
                                
                                if AlreadyArray.isEmpty{
                                    Button("انصراف",role: .cancel,action: {
                                        self.name = ""
                                    })
                                }
                                else{
                                    Button("تایید", role: .cancel, action: {
                                        self.name = ""
                                    })
                                }
                            },message: {
                                Text("لطفا نام بازیکن جدید را وارد کنید")
                            })
                            .clipShape(Circle())
                            .background(Image(systemName: "person.fill.badge.plus").dynamicTypeSize(.xLarge))
                            .dynamicTypeSize(.xLarge)
                            .padding()
                        })
                        .navigationTitle("بازیکنان ثابت")
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarTitleTextColor(Color.indigo)
                        .navigationSplitViewStyle(.balanced)
                    }
            }
        }
    }
}
struct alreadyPlayer_preview:PreviewProvider {
    static var previews: some View{
        alreadyPlayers()
    }
}
