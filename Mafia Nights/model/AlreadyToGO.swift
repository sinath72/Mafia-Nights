//
//  AlreadyToGO.swift
//  Mafia Nights
//
//  Created by Macvps on 3/11/23.
//

import Foundation
class AlreadyToGO:ObservableObject{
    private var array:(PlayerName:[String],PlayerAct:[String])
    init(){
        array = ([],[])
    }
    func setData(PlayerNames:String,PlayerActs:String){
        array.PlayerName.append(PlayerNames)
        array.PlayerAct.append(PlayerActs)
    }
    func getData() -> (PlayerName: [String], PlayerAct: [String]){
        return array
    }
}
