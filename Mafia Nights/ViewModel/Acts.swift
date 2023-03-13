//
//  Acts.swift
//  Mafia Nights
//
//  Created by sina taherkhani on 2/27/23.
//

import SwiftUI
struct Acts:View {
    @Binding var PlayerName:[String]
    @State private var Acts:[Act_Model] = []//[Act_Model(id: 1, ActName: "p", ActDescription: "o", ActPhotoID: 0, Side: "p", Modify: false)]
    @State private var ActsSelected:[String] = []
    @State private var isPresentAlert = false
    @State private var ActName = ""
    @State private var ActSide = ""
    @State private var SearchText = ""
    var body: some View{
        VStack(alignment:.trailing,spacing: 0){
            NavigationView {
                Color.brown
                    .ignoresSafeArea()
                    .overlay(
                        List{
                            if $SearchText.wrappedValue == "" {
                                ForEach(0..<Acts.count,id:\.self){ i in
                                    HStack(spacing:12.0){
                                        Toggle(isOn: $Acts[i].Modify) {
                                            HStack{
                                                Text(Acts[i].ActName.description)
                                                Spacer()
                                                Text(String(ActsSelected.filter{$0 == Acts[i].ActName}.count))
                                            }
                                        }
                                        Spacer()
                                        Button(""){
                                            if Acts[i].Modify{
                                                ActsSelected.append(Acts[i].ActName)
                                            }
                                        }
                                        .background(Image(systemName: "plus").dynamicTypeSize(.xxxLarge))
                                        .foregroundColor(Color.pink)
                                        
                                    }
                                    .swipeActions (edge: .trailing, allowsFullSwipe: true){
                                        Button(role: .destructive,action:{
                                            if Acts[i].Modify == true{
                                                if ActsSelected.filter({$0 == Acts[i].ActName}).count > 0{
                                                    print("pill")
                                                    let index = ActsSelected.firstIndex(of: $Acts[i].ActName.wrappedValue)
                                                    ActsSelected.remove(at: index!)
                                                    if ActsSelected.count == 0{
                                                        Acts[i].Modify.toggle()
                                                    }
                                                }
                                            }
                                            else{
                                                Acts = DB().getActsList()
                                            }
                                        }) {
                                            Label("حذف",systemImage:"minus")
                                        }
                                    }
                                    .listRowBackground(Color.teal)
                                    .onChange(of: Acts[i].Modify) { Value in
                                        if Value {
                                            if ActsSelected.contains(Acts[i].ActName) == false {
                                                ActsSelected.append(Acts[i].ActName)
                                            }
                                        }
                                        else {
                                            if ActsSelected.contains(Acts[i].ActName) {
                                                let maximum_count_index = ActsSelected.filter { $0 == Acts[i].ActName}.count - 1
                                                for _ in 0...maximum_count_index{
                                                    let index = ActsSelected.firstIndex(of: $Acts[i].ActName.wrappedValue)
                                                    ActsSelected.remove(at: index!)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            else{
                                let filterResualt = $Acts.filter{$0.ActName.wrappedValue.localizedLowercase == $SearchText.wrappedValue.localizedLowercase}
                                ForEach(0..<filterResualt.count,id:\.self){ i in
                                    HStack(spacing:12.0){
                                        Toggle(isOn: filterResualt[i].Modify) {
                                            HStack{
                                                Text(filterResualt[i].ActName.wrappedValue)
                                                Spacer()
                                                Text(String(ActsSelected.filter{$0.description == filterResualt[i].ActName.wrappedValue}.count))
                                            }
                                        }
                                        Spacer()
                                        Button(""){
                                            if filterResualt[i].Modify.wrappedValue{
                                                ActsSelected.append(filterResualt[i].ActName.wrappedValue)
                                            }
                                        }
                                        .background(Image(systemName: "plus").dynamicTypeSize(.xxxLarge))
                                        .foregroundColor(Color.pink)
                                        
                                    }
                                    .swipeActions (edge: .trailing, allowsFullSwipe: true){
                                        Button(role: .destructive,action:{
                                            if filterResualt[i].Modify.wrappedValue == true{
                                                if ActsSelected.filter({$0 == filterResualt[i].ActName.wrappedValue}).count > 0{
                                                    print("pill")
                                                    let index = ActsSelected.firstIndex(of: filterResualt[i].ActName.wrappedValue)
                                                    ActsSelected.remove(at: index!)
                                                    if ActsSelected.count == 0{
                                                        filterResualt[i].Modify.wrappedValue.toggle()
                                                    }
                                                }
                                            }
                                            else{
                                                Acts = DB().getActsList()
                                            }
                                        }) {
                                            Label("حذف",systemImage:"minus")
                                        }
                                    }
                                    .listRowBackground(Color.teal)
                                    .onChange(of: filterResualt[i].Modify.wrappedValue ) { Value in
                                        if Value {
                                            ActsSelected.append(filterResualt[i].ActName.wrappedValue)
                                        }
                                        else {
                                            if ActsSelected.contains(filterResualt[i].ActName.wrappedValue) {
                                                let maximum_count_index = ActsSelected.filter { $0 == filterResualt[i].ActName.wrappedValue}.count - 1
                                                for _ in 0...maximum_count_index{
                                                    let index = ActsSelected.firstIndex(of: filterResualt[i].ActName.wrappedValue)
                                                    ActsSelected.remove(at: index!)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                            .refreshable(action: {
                                Acts = DB().getActsList()
                            })
                            .scrollContentBackground(.visible)
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
                                .foregroundColor(Color.blue)
                                .padding()
                            })
                            .navigationTitle("تعداد نقش ها:  \(ActsSelected.count) \t تعداد بازیکنان:  \(PlayerName.count)")
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
                            NavigationLink(destination: GetPlayerActs(ActsAndPlayerNotReady: (ActName:ActsSelected,PlayerName))) {
                                Text("پخش نقش")
                                    .foregroundColor(Color.black)
                                    .frame(minWidth: CGFloat(350))
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue,Color.purple]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(40)
                                    .font(.largeTitle)
                                    .padding()
                            }
                            .padding()
                        }
                    }
                }
        }.searchable(text: $SearchText)
    }
}
struct Acts_preview:PreviewProvider {
    static var previews: some View{
        Acts(PlayerName: .constant(["ppp","lll","kkk"]))
    }
}
