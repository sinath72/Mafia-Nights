//
//  GetPlayerActs.swift
//  Mafia Nights
//
//  Created by Macvps on 3/7/23.
//

import SwiftUI
struct GetPlayerActs: View {
    @State var ActsAndPlayerNotReady : (ActName:[String],PlayerNames:[String]) = (ActName:["l","k","ko","koo"],PlayerNames:["l000000000000000000000000000","p","li","koo"])
    @ObservedObject private var State:PlayerState = PlayerState()
    @State private var isPresent = false
    var randomColor = [Color.black,Color.blue,Color.green,Color.red,Color.brown,Color.cyan,Color.indigo,Color.mint,Color.yellow,Color.pink,Color.purple]
    @State var tmpName = ""
    @State var PN = ""
    @ObservedObject private var mytileColor:tileColor = tileColor()
    var body: some View {
        NavigationView {
            Color.orange
                .ignoresSafeArea()
                .overlay {
                    ScrollView{
                        LazyVGrid(columns: [GridItem(.fixed(200)),GridItem(.flexible())]){
                            ForEach(0..<ActsAndPlayerNotReady.ActName.count,id:\.self){ i in
                                let size = ifView(name: ActsAndPlayerNotReady.PlayerNames[i])
                                Button(ActsAndPlayerNotReady.PlayerNames[i]){
                                    isPresent.toggle()
                                    tmpName = ActsAndPlayerNotReady.ActName[i]
                                    if State.getName(index: i) == ActsAndPlayerNotReady.PlayerNames[i]{
                                        State.setState(name: ActsAndPlayerNotReady.PlayerNames[i])
                                        PN = ActsAndPlayerNotReady.PlayerNames[i]
                                    }
                                }
                                .frame(maxWidth: 120.0, minHeight: 100.0,maxHeight: 100.0)
                                .padding(8.0)
                                .foregroundColor(.white)
                                .font(.system(size: size,weight: .bold,design: .default))
                                .controlSize(ControlSize.regular)
                                .dynamicTypeSize(.small)
                                .background(mytileColor.getColor(playerName: ActsAndPlayerNotReady.PlayerNames[i]))
                                .hiddenConditionally(isHidden:State.getState(name: ActsAndPlayerNotReady.PlayerNames[i]))
                            }
                        }
                    }.onAppear{
                        State.setArray(name: ActsAndPlayerNotReady.PlayerNames)
                    }
                }.toolbar(content: {
                    Button(" "){
                        
                    }.background(Image(systemName: "goforward"))
                        .padding()
                })
                .alert(tmpName, isPresented: $isPresent, actions: {
                })
                .navigationBarTitle("پخش نقش").font(.system(size:14.0,weight:.bold,design:.default))
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitleTextColor(.black)
        }.onAppear{
            color()
        }
    }
    func color() {
        let max = UInt32(randomColor.count - 1)
        var setColor:[Color] = []
        for _ in 0...max{
            let color = arc4random_uniform(max)
            print(color)
            setColor.append(randomColor[Int(color)])
        }
        mytileColor.setColor(name: ActsAndPlayerNotReady.PlayerNames, color: setColor)
    }
}

struct GetPlayerActs_Previews: PreviewProvider {
    static var previews: some View {
        GetPlayerActs()
    }
}
extension View {
    func hiddenConditionally(isHidden: Bool) -> some View {
        isHidden ? AnyView(self.hidden()) : AnyView(self)
    }
    func ifView(name:String) -> CGFloat{
        name.lengthOfBytes(using: .utf8) > 7 ? 14.0 : 30.0
    }
}
