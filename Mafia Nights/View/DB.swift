//
//  DB.swift
//  Mafia Nights
//
//  Created by Macvps on 3/5/23.
//

import Foundation
import SQLite3
struct DB{
    let dbName = "MafiaNights.sqlite"
    var dbPath = ""
    var myDB:OpaquePointer?
    init(){
       dbPath = getPath()
    }
    private mutating func getPath() -> String{
        let manager = FileManager.default
        guard let url = try! manager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(dbName).path else { return ""}
        if manager.fileExists(atPath: url){
            print("exist")
        }
        else{
            guard let BundelDBPath = Bundle.main.resourceURL?.appendingPathComponent(dbName).path else {return ""}
            do{
                try! manager.copyItem(at: URL(string: BundelDBPath)!, to: URL(string: url)!)
            }
            catch{
                print(error.localizedDescription)
            }
        }
        if sqlite3_open(url, &myDB) == SQLITE_OK{
            print(url)
        }
        return url
    }
    mutating func getPlayerList() -> [PlayerModel]{
        let QueryString = "Select * From Player"
        var data:[PlayerModel] = []
        if sqlite3_prepare_v2(myDB, QueryString, -1,&myDB,nil) == SQLITE_OK{
            while sqlite3_step(myDB) == SQLITE_OK{
                var id = Int(sqlite3_column_int(myDB, 0))
                var name = String(describing: String(cString: sqlite3_column_text(myDB, 1)))
                let model = PlayerModel(id: id, name: name, modify: false)
                data.append(model)
            }
        }
        return data
    }
}
