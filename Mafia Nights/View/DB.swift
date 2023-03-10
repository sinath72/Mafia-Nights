//
//  DB.swift
//  Mafia Nights
//
//  Created by Macvps on 3/5/23.
//

import Foundation
import SQLite3
class DB{
    let dbName = "MafiaNights.sqlite"
    var dbPath = ""
    var myDB:OpaquePointer?
    init(){
        dbPath = getPath()
        myDB =  openDB()
        print(dbPath)
    }
    private func getPath() -> String{
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
    func openDB() -> OpaquePointer?{
        var db:OpaquePointer? = nil
        if sqlite3_open(dbPath, &db) == SQLITE_OK{
            return db!
        }
        else{
            return nil
        }
    }
    func MaxPID() -> Int?{
        let QueryString = "SELECT MAX(id) FROM Player"
        var QueryStatement:OpaquePointer? = nil
        var PID:Int?
        if sqlite3_prepare_v2(myDB, QueryString, -1,&QueryStatement,nil) == SQLITE_OK{
            while sqlite3_step(QueryStatement) == SQLITE_ROW{
                let id = sqlite3_column_int(QueryStatement, 0)
                PID = Int(id)
            }
        }
        return PID
    }
    func getPlayerList() -> [PlayerModel] {
        let QueryString = "SELECT * FROM Player"
        var QueryStatement:OpaquePointer? = nil
        var data:[PlayerModel] = []
        if sqlite3_prepare_v2(myDB, QueryString, -1,&QueryStatement,nil) == SQLITE_OK{
            while sqlite3_step(QueryStatement) == SQLITE_ROW{
                let id = sqlite3_column_int(QueryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(QueryStatement, 1)))
                let model = PlayerModel(id: Int(id), name: name, modify: false)
                data.append(model)
            }
        }
        return data
    }
    func getActsList() -> [Act_Model] {
        let QueryString = "SELECT * FROM Acts"
        var QueryStatement:OpaquePointer? = nil
        var data:[Act_Model] = []
        if sqlite3_prepare_v2(myDB, QueryString, -1,&QueryStatement,nil) == SQLITE_OK{
            while sqlite3_step(QueryStatement) == SQLITE_ROW{
                let id = sqlite3_column_int(QueryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(QueryStatement, 1)))
                let desc = String(describing: String(cString: sqlite3_column_text(QueryStatement, 2)))
                let photoID = sqlite3_column_int(QueryStatement, 3)
                let side = String(describing: String(cString: sqlite3_column_text(QueryStatement, 4)))
                let model = Act_Model(id: Int(id), ActName: name, ActDescription: desc, ActPhotoID: Int(photoID), Side: side, Modify: false)
                data.append(model)
            }
        }
        return data
    }
    func setNewPlayer(name:NSString){
        let id = MaxPID()! + 1
        let InsertString = "INSERT INTO Player (id,name) VALUES (?,?)"
        var Statement:OpaquePointer? = nil
        if sqlite3_prepare_v2(myDB, InsertString, -1, &Statement, nil) == SQLITE_OK{
            sqlite3_bind_int(Statement, 1, Int32(id))
            sqlite3_bind_text(Statement, 2, name.utf8String, -1, nil)
            if sqlite3_step(Statement) == SQLITE_DONE{
                print("done")
            }
            else{
                print("not done")
            }
        }
        else{
            print("error")
        }
        sqlite3_finalize(Statement)
    }
    func DeletePlayer(id:Int){
        let DeleteString = "DELETE FROM Player WHERE id = \(id)"
        var Statement:OpaquePointer? = nil
        if sqlite3_prepare_v2(myDB, DeleteString, -1, &Statement, nil) == SQLITE_OK{
            print(sqlite3_step(Statement))
            if sqlite3_step(Statement) == SQLITE_DONE{
                print("done")
            }
            else{
                print("not done")
            }
        }
        else{
            print("error")
        }
        sqlite3_finalize(Statement)
    }
    //UPDATE Player SET name = "poolk" WHERE id = 1
    
    func UpdatePlayer(id:Int,name:String){
        let UpdateString = "UPDATE Player SET name = '\(name)' WHERE id = '\(id)'"
        var Statement:OpaquePointer? = nil
        if sqlite3_prepare_v2(myDB, UpdateString, -1, &Statement, nil) == SQLITE_OK{
            print(sqlite3_step(Statement))
            if sqlite3_step(Statement) == SQLITE_DONE{
                print("done")
            }
            else{
                print("not done")
            }
        }
        else{
            print("error")
        }
        sqlite3_finalize(Statement)
    }
}
