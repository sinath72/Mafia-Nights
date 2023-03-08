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
    @State private var ActsSelected:[String] = []
    @State private var isPresentAlert = false
    @State private var ActName = ""
    @State private var ActSide = ""
    var body: some View{
        VStack(alignment:.trailing,spacing: 0){
            NavigationView {
                Color.brown
                    .ignoresSafeArea()
                    .overlay(
                        List{
                            ForEach(0..<Acts.count,id:\.self){ i in
                                Toggle(isOn: $Acts[i].Modify) { Text(Acts[i].ActName.description)
                                }
                                .listRowBackground(Color.teal)
                                .onChange(of: Acts[i].Modify) { Value in
                                    if Value {
                                        ActsSelected.append(Acts[i].ActName)
                                    }
                                    else {
                                        if ActsSelected.contains(Acts[i].ActName) {
                                            let index = ActsSelected.firstIndex(of: $Acts[i].ActName.wrappedValue)
                                            ActsSelected.remove(at: index!)
                                        }
                                    }
                                }
                            }
                        }.scrollContentBackground(.visible)
                            .listStyle(.plain)
                            .onAppear{
                                Acts = DB().getActsList()
                            }
                            .toolbar(content: {
                                Button(" "){
                                    isPresentAlert = true
                                }.alert("نقش موقتی", isPresented: $isPresentAlert, actions: {
                                    TextField("نام نقش", text: $ActName)
                                    TextField("طرف بازی", text: $ActSide)
                                    Button("افزودن"){
                                        var id = 1
                                        if !Acts.isEmpty{
                                            id = Acts.last!.id + 1
                                        }
                                        Acts.append(Act_Model(id: id, ActName: ActName, ActDescription: "", ActPhotoID: 0, Side: ActSide, Modify: false))
                                        ActName = ""
                                        ActSide = ""
                                    }
                                    Button("لغو"){
                                        ActName = ""
                                        ActSide = ""
                                    }
                                },message: {
                                    Text("لطفا نام نقش به همراه طرف بازی نقش را وارد کنید")
                                })
                                .background(Image(systemName: "plus"))
                                .padding()
                            })
                            .navigationTitle("تعداد نقش ها: \(ActsSelected.count) \t تعداد بازیکنان:\(PlayerName.count)")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarTitleTextColor(.black)
                    )
            }
            Color.brown
                .ignoresSafeArea()
                .frame(height:75.0)
                .overlay{
                    HStack(alignment: .bottom){
                        if ActsSelected.count == PlayerName.count{
                            NavigationLink(destination: GetPlayerActs()) {
                                Text("پخش نقش")
                                    .frame(minWidth: CGFloat(350))
                                    .foregroundColor(.white)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue,Color.purple]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(40)
                                    .font(.largeTitle)
                                    .padding()
                            }
                            .padding()
                        }
                    }
                }
        }
    }
}
struct Acts_preview:PreviewProvider {
    static var previews: some View{
        Acts(PlayerName: .constant(["ppp","lll","kkk"]))
    }
}
