//
//  TileColor.swift
//  Mafia Nights
//
//  Created by Macvps on 3/11/23.
//

import Foundation
import SwiftUI
class tileColor:ObservableObject{
    var playerTileColor:(name:[String],color:[Color])
    init(){
        playerTileColor = (name:[],color:[])
    }
    func setColor(name:[String],color:[Color]){
        playerTileColor = (name,color)
    }
    func getColor(playerName:String) -> Color{
        if playerTileColor.name.contains(playerName) {
            let index = playerTileColor.name.firstIndex(of: playerName)!
            return playerTileColor.color[index]
        }
        return .accentColor
    }
}
