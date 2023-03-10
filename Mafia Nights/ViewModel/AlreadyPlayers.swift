//
//  AlreadyPlayers.swift
//  Mafia Nights
//
//  Created by sina taherkhani on 2/27/23.
//

import SwiftUI
struct alreadyPlayers:View {
    @State private var AlreadyArray:[PlayerModel] = []//[PlayerModel(id: 100, name: "l", modify: false)]
    @State private var name:String = ""
    @State private var isPresent:Bool = false
    @State private var isPresentEdite:Bool = false
    @State private var isRefreshed:Bool = false
    @State private var myName = ""
    @State private var editeID = 0
    var body:some View{
        VStack{
            NavigationView{
                Color.mint
                    .ignoresSafeArea()
                    .overlay{
                        List{
                            ForEach(0..<AlreadyArray.count,id: \.self){ i in
                                HStack(spacing: 12.0){
                                    Text(AlreadyArray[i].name)
                                        .swipeActions(edge:.trailing,allowsFullSwipe: true){
                                            Button(role: .destructive,action:{
                                                DB().DeletePlayer(id: AlreadyArray[i].id)
                                                AlreadyArray = DB().getPlayerList()
                                            }) {
                                                Label("حذف",systemImage:"trash")
                                            }
                                        }
                                        .swipeActions(edge:.leading,allowsFullSwipe: true) {
                                            Button(role: .none,action:{
                                                editeID = i
                                                isPresentEdite.toggle()
                                            }) {
                                                Label("ویرایش",systemImage:"square.and.pencil")
                                            }.background(Color.blue)
                                        }
                                        .alert("تغییر نام بازیکن: \(AlreadyArray[editeID].name)", isPresented: $isPresentEdite) {
                                            TextField("", text: $myName).background(Color.gray)
                                            Button("لغو"){
                                                AlreadyArray = DB().getPlayerList()
                                                myName = ""
                                            }
                                            Button("ویرایش"){
                                                DB().UpdatePlayer(id: AlreadyArray[editeID].id, name: $myName.wrappedValue)
                                                AlreadyArray = DB().getPlayerList()
                                                myName = ""
                                            }
                                        }
                                }
                            }
                            .listRowBackground(Color.green)
                        }.scrollContentBackground(.visible)
                            .listStyle(.plain)
                            .refreshable {
                                AlreadyArray = DB().getPlayerList()
                            }
                            .onAppear{
                                AlreadyArray = DB().getPlayerList()
                            }
                            .toolbar(content: {
                                Button(" "){
                                    isPresent = true
                                }.alert("نام بازیکن ثابت", isPresented: $isPresent,actions: {
                                    TextField("نام بازیکن",text: $name)
                                    Button("افزودن", action: {
                                        DB().setNewPlayer(name: NSString(string: name))
                                        AlreadyArray = DB().getPlayerList()
                                        name = ""
                                    })
                                    
                                    if AlreadyArray.isEmpty{
                                        Button("انصراف",role: .cancel,action: {
                                            name = ""
                                        })
                                    }
                                    else{
                                        Button("تایید", role: .cancel, action: {
                                            name = ""
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
