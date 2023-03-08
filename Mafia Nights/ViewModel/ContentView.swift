//
//  ContentView.swift
//  Mafia Nights
//
//  Created by sina taherkhani on 2/20/23.
//

import SwiftUI
struct ContentView: View {
    var body: some View {
        NavigationView{
            Color.black
                .ignoresSafeArea()
                .overlay(
                    VStack {
                        Image(systemName: "")
                            .dynamicTypeSize(.xxxLarge)
                            .clipShape(Circle())
                        NavigationLink(destination: LetsPlay()) {
                            Text("شروع بازی")
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(40)
                                .font(.largeTitle)
                        }
                        NavigationLink(destination: tuterials()) {
                            Text("آموزش")
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.orange,Color.cyan]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(40)
                                .font(.largeTitle)
                                .padding()
                        }
                        NavigationLink(destination: alreadyPlayers()){
                            Text("بازیکن های ثابت")
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient:Gradient(colors:[Color.indigo,Color.teal]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(40)
                                .font(.title)
                        }
                    }
                        .navigationTitle("مافیا بازی")
                        .navigationBarTitleTextColor(.blue)
                        .padding()
                    
                )
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
extension View {
    /// Sets the text color for a navigation bar title.
    /// - Parameter color: Color the title should be
    ///
    /// Supports both regular and large titles.
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        
        // Set appearance for both normal and large sizes.
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
        
        return self
    }
}
