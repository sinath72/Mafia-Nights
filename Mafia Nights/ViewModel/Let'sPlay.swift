//
//  Let'sPlay.swift
//  Mafia Nights
//
//  Created by sina taherkhani on 2/27/23.
//

import SwiftUI

struct LetsPlay: View{
    @State private var presentAlert = false
    @State private var checkbox = false
    @State private var checkboxArray = []
    @State private var PlayerName: String = ""
    @State var name:[PlayerModel] = []
    @State var alreadyName:[String] = []
    var body : some View{
        VStack(alignment: .trailing,spacing: 0){
            NavigationView{
                Color.green
                    .ignoresSafeArea()
                    .overlay(
                        List{
                            ForEach(0..<name.count,id: \.self){ i in
                                Toggle(isOn: $name[i].modify) {
                                    Text(name[i].name.description)
                                }
                                .listRowBackground(Color.teal)
                                .onChange(of: name[i].modify, perform: { value in
                                    if value{
                                        alreadyName.append($name[i].name.wrappedValue)
                                        print(alreadyName)
                                    }
                                    else{
                                        if alreadyName.contains($name[i].name.wrappedValue) {
                                            let index = alreadyName.firstIndex(of: $name[i].name.wrappedValue)
                                            alreadyName.remove(at: index!)
                                            print(alreadyName)
                                        }
                                    }
                                })
                            }
                        }.scrollContentBackground(.visible)
                            .listStyle(.plain)
                            .refreshable {
                                name = DB().getPlayerList()
                            }
                            .onAppear{
                                name = []
                                name.append(contentsOf: DB().getPlayerList())
                                Color.green
                            }
                            .toolbar(content: {
                                
                                Button("   "){
                                    presentAlert = true
                                }
                                .alert("نام بازیکن جدید", isPresented: $presentAlert, actions: {
                                    TextField("نام بازیکن", text: $PlayerName)
                                    
                                    //                    SecureField("Password", text: $password)
                                    
                                    
                                    Button("افزودن", action: {
                                        var id = 1
                                        if name.count > 0 {
                                            id = name.last!.id + 1
                                        }
                                        name.append(PlayerModel(id: id, name: $PlayerName.wrappedValue, modify: false))
                                        //                        name.append($PlayerName.wrappedValue)
                                        print(name)
                                        self.PlayerName = ""
                                    })
                                    if name.isEmpty{
                                        Button("انصراف",role: .cancel,action: {
                                            self.PlayerName = ""
                                        })
                                    }
                                    else{
                                        Button("تایید", role: .cancel, action: {
                                            self.PlayerName = ""
                                        })
                                    }
                                }, message: {
                                    Text("لطفا نام بازیکن جدید را وارد کنید")
                                })
                                .clipShape(Circle())
                                .background(Image(systemName: "person.fill.badge.plus").dynamicTypeSize(.xLarge))
                                .foregroundColor(Color.black)
                                .dynamicTypeSize(.xLarge)
                            })
                            .navigationBarTitle("تعداد بازیکنان انتخاب شده: \(alreadyName.count)")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarTitleTextColor(Color.black)
                            .navigationSplitViewStyle(.balanced)
                    )
            }
            Color.green
                .ignoresSafeArea()
                .frame(height: 75.0)
                .overlay(
                    HStack(alignment: .bottom){
                        NavigationLink(destination: Acts(PlayerName: $alreadyName)) {
                            Text("ادامه")
                                .foregroundColor(Color.black)
                                .frame(minWidth: CGFloat(350))
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.orange,Color.cyan]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(40)
                                .font(.largeTitle)
                                .padding()
                        }
                        .padding()
                    }
                )
        }
    }
}
struct Letsplay_preview: PreviewProvider{
    static var previews: some View{
        LetsPlay()
    }
}
