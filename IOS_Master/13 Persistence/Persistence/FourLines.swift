//
//  FourLines.swift
//  Persistence
//
//  Created by Niu Panfeng on 10/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class FourLines: NSObject, NSCoding, NSCopying {
    
    var lines: [String]?
    let linesKey = "linesKey"
    
    override init() {}
    //解码
    required init?(coder aDecoder: NSCoder) {
        lines = aDecoder.decodeObjectForKey(linesKey) as? [String]
    }
    //编码
    func encodeWithCoder(aCoder: NSCoder) {
        if let saveLines = lines
        {
            aCoder.encodeObject(saveLines, forKey: linesKey)
        }
    }
    //拷贝
    func copyWithZone(zone: NSZone) -> AnyObject {
        let copy = FourLines()
        if let linesForCopy = lines
        {
            var newLines = Array<String>()
            for line in linesForCopy
            {
                newLines.append(line)
            }
            
            copy.lines = newLines
        }
        return copy
    }

}
