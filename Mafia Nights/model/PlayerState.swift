//
//  PlayerState.swift
//  Mafia Nights
//
//  Created by Macvps on 3/11/23.
//

import Foundation
class PlayerState:ObservableObject{
    var array:(name:[String],state:[Bool])
    init(){
        array = (name:[],state:[])
    }
    func setArray(name:[String]){
        var mystate:[Bool] = []
        for _ in 0..<name.count{
            mystate.append(false)
        }
        array = (name:name,state:mystate)
    }
    func getState(name:String) -> Bool{
        if array.name.contains(name){
            let resualt = array.name.firstIndex(of: name)!
            return array.state[resualt]
        }
        return false
    }
    func getName(index:Int) -> String{
        if array.name.startIndex <= index && array.name.count - 1 >= index{
            return array.name[index]
        }
        return ""
    }
    func setState(name:String){
        if array.name.contains(name){
            let resualt = array.name.firstIndex(of: name)!
            array.state[resualt].toggle()
            print(array)
        }
    }
    func setToggleAll(){
        for i in 0..<array.state.count{
            array.state[i] = false
        }
    }
}
