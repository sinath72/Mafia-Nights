//
//  RandomStatement.swift
//  Mafia Nights
//
//  Created by Macvps on 3/12/23.
//

import Foundation
class RandomStatement:ObservableObject{
    var ActsAndPlayerNotReady:(ActName:[String],PlayerNames:[String]) = ([],[])
    func setData(setData:(ActName:[String],PlayerName:[String])) {
        ActsAndPlayerNotReady = (setData.ActName,setData.PlayerName)
    }
    init(){
        
    }
    func setRandom() -> ([String],[String]){
        let max = ActsAndPlayerNotReady.ActName.count
        var randedData:(act:[String],player:[String]) = ([],[])
        var myPID:[UInt32] = []
        var myAID:[UInt32] = []
        repeat{
            let PID = arc4random_uniform(UInt32(max))
            let AID = arc4random_uniform(UInt32(max))
            if !myPID.contains(PID) && !myAID.contains(AID){
                myAID.append(AID);myPID.append(PID)
                randedData.act.append(ActsAndPlayerNotReady.ActName[Int(AID)])
                randedData.player.append(ActsAndPlayerNotReady.PlayerNames[Int(PID)])
            }
            if randedData.player.count == ActsAndPlayerNotReady.PlayerNames.count && randedData.act.count == ActsAndPlayerNotReady.ActName.count{
                break
            }
        }while(true)
        return randedData
    }
}
