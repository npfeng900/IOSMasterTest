//
//  TinyPixDocument.swift
//  TinyPix
//
//  Created by Niu Panfeng on 11/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class TinyPixDocument: UIDocument {
    
    private var bitmap: [UInt8]
    
    var name: String?
    
    override init(fileURL url: NSURL) {
        bitmap = [0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80]
        super.init(fileURL: url)
    }
    //获取指定单元的状态
    func getState(row row: Int, column: Int) -> Bool {
        let rowByte = bitmap[row]
        let result = UInt8(1 << column) & rowByte
        return result != 0
    }
    //设置指定单元的状态
    func setState(state: Bool, atRow row: Int, column: Int) {
        var rowByte = bitmap[row]
        if state
        {
            rowByte |= UInt8(1 << column)
        }
        else
        {
            rowByte &= ~UInt8(1 << column)
        }
        bitmap[row] = rowByte
    }
    //切换指定单元的状态
    func toggleStateAt(row row: Int, column: Int){
        let state = getState(row: row, column: column)
        setState(!state, atRow: row, column: column)
    }
    //保存文档调用，之后的存储工作由系统负责
    override func contentsForType(typeName: String) throws -> AnyObject {
        print("Saving document to URL \(fileURL)")
        let bitmapData = NSData(bytes: bitmap, length: bitmap.count)
        return bitmapData
    }
    //系统已经从存储区加载了数据，并准备将水提供给文档类的实例
    override func loadFromContents(contents: AnyObject, ofType typeName: String?) throws {
        print("Loading document from URL \(fileURL)")
        let bitmapData = contents as! NSData
        bitmapData.getBytes(UnsafeMutablePointer(bitmap), length: bitmap.count)
    }
}
