//
//  Database.swift
//  lxjm
//
//  Created by 吴展灵 on 2018/7/8.
//  Copyright © 2018年 吴展灵. All rights reserved.
//

import Foundation
import SQLite

struct dbimessage {
    
    var db: Connection!
    
    init() {
        connectDatabase()
    }
    
    // 与数据库建立连接
    mutating func connectDatabase(filePath: String = "/Documents") -> Void {
        
       // let sqlFilePath = NSHomeDirectory() + filePath + "/lxjjdb.sqlite3"
        let sqlFilePath = URL(fileURLWithPath: FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.wzl.lx")?.absoluteString ?? "").appendingPathComponent("lxjjdb.sqlite3").absoluteString
        do { // 与数据库建立连接
            db = try Connection(sqlFilePath)
            //  print("与数据库建立连接 成功")
        } catch {
            // print("与数据库建立连接 失败：\(error)")
        }
        
    }
    
    // ===================================== 灯光 =====================================
    let TABLE_LAMP = Table("kl") // 表名称
    let TABLE_LAMP_ID = Expression<Int64>("id") // 列表项及项类型
    let TABLE_LAMP_ADDRESS = Expression<Int64>("pxh")
    let TABLE_LAMP_NAME = Expression<Int64>("sfmr")
    let TABLE_LAMP_COLOR_VALUE = Expression<String>("kl")
    let TABLE_LAMP_LAMP_TYPE = Expression<String>("bc")
    
    let TABLE_LAMP_LAMP_bz1 = Expression<Int64>("bz1")
    let TABLE_LAMP_LAMP_bz2 = Expression<Int64>("bz2")
    let TABLE_LAMP_LAMP_bz3 = Expression<Int64>("bz3")
    let TABLE_LAMP_LAMP_bz4 = Expression<String>("bz4")
    let TABLE_LAMP_LAMP_bz5 = Expression<String>("bz5")
    let TABLE_LAMP_LAMP_bz6 = Expression<String>("bz6")
    let TABLE_LAMP_LAMP_bz7 = Expression<String>("bz7")
    let TABLE_LAMP_LAMP_bz8 = Expression<String>("bz8")
    let TABLE_LAMP_LAMP_bz9 = Expression<String>("bz9")
    let TABLE_LAMP_LAMP_bz10 = Expression<String>("bz10")
    let TABLE_LAMP_LAMP_cjsj = Expression<String>("cjsj")
    let TABLE_LAMP_LAMP_xgsj = Expression<String>("xgsj")
    
    
    // 建表
    func tableLampCreate() -> Void {
        do { // 创建表TABLE_LAMP
            try db.run(TABLE_LAMP.create { table in
                table.column(TABLE_LAMP_ID, primaryKey: .autoincrement) // 主键自加且不为空
                table.column(TABLE_LAMP_ADDRESS)
                table.column(TABLE_LAMP_NAME)
                table.column(TABLE_LAMP_COLOR_VALUE)
                table.column(TABLE_LAMP_LAMP_TYPE)
                
                table.column(TABLE_LAMP_LAMP_bz1)
                table.column(TABLE_LAMP_LAMP_bz2)
                table.column(TABLE_LAMP_LAMP_bz3)
                table.column(TABLE_LAMP_LAMP_bz4)
                table.column(TABLE_LAMP_LAMP_bz5)
                table.column(TABLE_LAMP_LAMP_bz6)
                table.column(TABLE_LAMP_LAMP_bz7)
                table.column(TABLE_LAMP_LAMP_bz8)
                table.column(TABLE_LAMP_LAMP_bz9)
                table.column(TABLE_LAMP_LAMP_bz10)
                table.column(TABLE_LAMP_LAMP_cjsj)
                table.column(TABLE_LAMP_LAMP_xgsj)
                
            })
            // print("创建表 TABLE_LAMP 成功")
        } catch {
            //  print("创建表 TABLE_LAMP 失败：\(error)")
        }
    }
    
    // 插入
    func tableLampInsertItem(pxh: Int64, sfmr: Int64, kl: String, bc: String,cjsj:String,xgsj:String,bz1:Int64,bz2:Int64,bz3:Int64,bz4:String,bz5:String,bz6:String,bz7:String,bz8:String,bz9:String,bz10:String) -> Void {
        let insert = TABLE_LAMP.insert(TABLE_LAMP_ADDRESS <- pxh, TABLE_LAMP_NAME <- sfmr, TABLE_LAMP_COLOR_VALUE <- kl, TABLE_LAMP_LAMP_TYPE <- bc,TABLE_LAMP_LAMP_cjsj<-cjsj,TABLE_LAMP_LAMP_xgsj<-xgsj,TABLE_LAMP_LAMP_bz1<-bz1,TABLE_LAMP_LAMP_bz2<-bz2,TABLE_LAMP_LAMP_bz3<-bz3,TABLE_LAMP_LAMP_bz4<-bz4,TABLE_LAMP_LAMP_bz5<-bz5,TABLE_LAMP_LAMP_bz6<-bz6,TABLE_LAMP_LAMP_bz7<-bz7,TABLE_LAMP_LAMP_bz8<-bz8,TABLE_LAMP_LAMP_bz9<-bz9,TABLE_LAMP_LAMP_bz10<-bz10)
        do {
            let rowid = try db.run(insert)
            // print("插入数据成功 id: \(rowid)")
        } catch {
            // print("插入数据失败: \(error)")
        }
    }
    
    // 遍历
    func queryTableLamp() -> Void {
        for item in (try! db.prepare(TABLE_LAMP)) {
            //  print("灯光 遍历 ———— id: \(item[TABLE_LAMP_ID]), address: \(item[TABLE_LAMP_ADDRESS]), name: \(item[TABLE_LAMP_NAME]), colorValue: \(item[TABLE_LAMP_COLOR_VALUE]), lampType: \(item[TABLE_LAMP_LAMP_TYPE])")
            
            //   print("遍历id: \(item[TABLE_LAMP_ID]), pxh: \(item[TABLE_LAMP_ADDRESS]), sfmr: \(item[TABLE_LAMP_NAME]), kl: \(item[TABLE_LAMP_COLOR_VALUE]), bc: \(item[TABLE_LAMP_LAMP_TYPE])")
        }
    }
    
    // 读取
    func readTableLampItem(address: Int64) -> Void {
        
        for item in try! db.prepare(TABLE_LAMP.filter(TABLE_LAMP_ADDRESS == address)) {
            // print("\n读取（id: \(item[TABLE_LAMP_ID]), pxh: \(item[TABLE_LAMP_ADDRESS]), sfmr: \(item[TABLE_LAMP_NAME]), kl: \(item[TABLE_LAMP_COLOR_VALUE]), bc: \(item[TABLE_LAMP_LAMP_TYPE])")
        }
        
    }
    
    // 更新
    func tableLampUpdateItem(address: Int64, newName: Int64) -> Void {
        let item = TABLE_LAMP.filter(TABLE_LAMP_ADDRESS == address)
        do {
            if try db.run(item.update(TABLE_LAMP_NAME <- newName)) > 0 {
                // print("pxh\(address) 更新成功")
            } else {
                // print("没有发现 pxh \(address)")
            }
        } catch {
            //  print("pxh\(address) 更新失败：\(error)")
        }
    }
    
    // 删除
    func tableLampDeleteItem(id: Int64) -> Void {
        let item = TABLE_LAMP.filter(TABLE_LAMP_ID == id)
        do {
            if try db.run(item.delete()) > 0 {
                //  print("id\(id) 删除成功")
            } else {
                // print("没有发现 id \(id)")
            }
        } catch {
            // print("id\(id) 删除失败：\(error)")
        }
    }
    
    // 读取
    func readBz1(address: Int64) -> Int64 {
        
        var a:Int64 = 0
        
        for item in try! db.prepare(TABLE_LAMP.filter(TABLE_LAMP_LAMP_bz1 == address)) {
            // print("\n读取（id: \(item[TABLE_LAMP_ID]), pxh: \(item[TABLE_LAMP_ADDRESS]), sfmr: \(item[TABLE_LAMP_NAME]), kl: \(item[TABLE_LAMP_COLOR_VALUE]), bc: \(item[TABLE_LAMP_LAMP_TYPE])")
            let sb = item[TABLE_LAMP_LAMP_bz1]
            if(sb>0)
            {
                a = sb;
            }
        }
        
        return a;
    }
    // 读取是否可删除
    func readsfks(address: Int64) -> Int64 {
        
        var a:Int64 = 0
        
        for item in try! db.prepare(TABLE_LAMP.filter(TABLE_LAMP_LAMP_bz1 == address)) {
            // print("\n读取（id: \(item[TABLE_LAMP_ID]), pxh: \(item[TABLE_LAMP_ADDRESS]), sfmr: \(item[TABLE_LAMP_NAME]), kl: \(item[TABLE_LAMP_COLOR_VALUE]), bc: \(item[TABLE_LAMP_LAMP_TYPE])")
            let sb = item[TABLE_LAMP_LAMP_bz1]
            if(sb>0)
            {
                a = sb;
            }
        }
        
        return a;
    }
    // 读取是否默认
    func readsfmr(address: Int64) -> Int64 {
        
        var a:Int64 = 0
        
        for item in try! db.prepare(TABLE_LAMP.filter(TABLE_LAMP_NAME == address)) {
            // print("\n读取（id: \(item[TABLE_LAMP_ID]), pxh: \(item[TABLE_LAMP_ADDRESS]), sfmr: \(item[TABLE_LAMP_NAME]), kl: \(item[TABLE_LAMP_COLOR_VALUE]), bc: \(item[TABLE_LAMP_LAMP_TYPE])")
            let sb = item[TABLE_LAMP_ID]
            if(sb>0)
            {
                a = sb;
            }
        }
        
        return a;
    }
    // 读取列表
    func readTable(address: Int64)  ->[[String]] {
        var rows = [[String]]()
        
        
        for item in try! db.prepare(TABLE_LAMP.filter(TABLE_LAMP_ID >= address)) {
            var arry = [String]()
            // print("\n读取（id: \(item[TABLE_LAMP_ID]), pxh: \(item[TABLE_LAMP_ADDRESS]), sfmr: \(item[TABLE_LAMP_NAME]), kl: \(item[TABLE_LAMP_COLOR_VALUE]), bc: \(item[TABLE_LAMP_LAMP_TYPE])")
            arry.append(String(item[TABLE_LAMP_ID]))
            arry.append(String(item[TABLE_LAMP_LAMP_TYPE]))
            arry.append(String(item[TABLE_LAMP_NAME]))
            arry.append(String(item[TABLE_LAMP_COLOR_VALUE]))
            // arry[0]=String(item[TABLE_LAMP_ID])
            // arry[1]=String(item[TABLE_LAMP_LAMP_TYPE])
            //arry[2]=String(item[TABLE_LAMP_NAME])
            //rows.append((arry as AnyObject) as! [String : AnyObject])
            rows.append(arry)
        }
        return rows;
        
    }
    
    // 读取列表
    func readTableMr(address: Int64)  ->[[String]] {
        var rows = [[String]]()
        
        
        for item in try! db.prepare(TABLE_LAMP.filter(TABLE_LAMP_NAME == address)) {
            var arry = [String]()
            //   print("\n读取（id: \(item[TABLE_LAMP_ID]), pxh: \(item[TABLE_LAMP_ADDRESS]), sfmr: \(item[TABLE_LAMP_NAME]), kl: \(item[TABLE_LAMP_COLOR_VALUE]), bc: \(item[TABLE_LAMP_LAMP_TYPE])")
            arry.append(String(item[TABLE_LAMP_ID]))
            arry.append(String(item[TABLE_LAMP_LAMP_TYPE]))
            arry.append(String(item[TABLE_LAMP_NAME]))
            arry.append(String(item[TABLE_LAMP_COLOR_VALUE]))
            // arry[0]=String(item[TABLE_LAMP_ID])
            // arry[1]=String(item[TABLE_LAMP_LAMP_TYPE])
            //arry[2]=String(item[TABLE_LAMP_NAME])
            //rows.append((arry as AnyObject) as! [String : AnyObject])
            rows.append(arry)
        }
        return rows;
        
    }
    
    // 更新
    func Updatesfmr_null(sfmr: Int64, newName: Int64) -> Void {
        let item = TABLE_LAMP.filter(TABLE_LAMP_NAME == sfmr)
        do {
            if try db.run(item.update(TABLE_LAMP_NAME <- newName)) > 0 {
                // print("取消默认更新成功")
            } else {
                //print("取消默认没有发现")
            }
        } catch {
            //print("取消默认更新失败：\(error)")
        }
    }
    // 更新
    func Updatesfmr(id: Int64, newValue: Int64) -> Void {
        let item = TABLE_LAMP.filter(TABLE_LAMP_ID == id)
        do {
            if try db.run(item.update(TABLE_LAMP_NAME <- newValue)) > 0 {
                // print("默认更新成功")
            } else {
                // print("默认没有发现")
            }
        } catch {
            //print("默认更新失败：\(error)")
        }
    }
}
