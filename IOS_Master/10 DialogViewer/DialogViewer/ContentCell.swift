//
//  ContentCell.swift
//  DialogViewer
//
//  Created by Niu Panfeng on 9/24/16.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit

class ContentCell: UICollectionViewCell {
    var maxWidth: CGFloat!
    var label: UILabel!
    var text: String!{
        get{
            return label.text
        }
        set(newText){
            label.text = newText
            var newLabelFrame = label.frame
            var newContentFrame = contentView.frame
            
            let textSize = self.dynamicType.sizeForContentString(newText, forMaxWidth: maxWidth)
            
            newLabelFrame.size = textSize
            newContentFrame.size = textSize
            
            label.frame = newLabelFrame
            contentView.frame = newContentFrame
        }
    }
    
    //计算表单元的合适尺寸
    class func sizeForContentString(s: String, forMaxWidth maxWidth: CGFloat) -> CGSize {
        //最大尺寸
        let maxSize = CGSizeMake(maxWidth, 1000)
        //l
        let opts = NSStringDrawingOptions.UsesLineFragmentOrigin
        //段落类型和字体类型组成的属性
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = NSLineBreakMode.ByCharWrapping
        let attributes = [NSFontAttributeName: self.defaultFont(), NSParagraphStyleAttributeName: style]
        
        let string = s as NSString
        let rect = string.boundingRectWithSize(maxSize, options: opts, attributes: attributes, context: nil)
        
        return rect.size
    }
    //默认字体
    class func defaultFont() -> UIFont {
        return UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }
    //构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel(frame: self.contentView.bounds)
        label.opaque = false
        label.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
        label.textColor = UIColor.blackColor()
        label.textAlignment = .Center
        label.font = self.dynamicType.defaultFont()
        contentView.addSubview(label)
    }
    //storyboard初始化需要
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
