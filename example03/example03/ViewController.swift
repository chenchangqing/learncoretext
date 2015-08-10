//
//  ViewController.swift
//  example03
//
//  Created by green on 15/8/9.
//  Copyright (c) 2015年 green. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let str = "设置富文本的时候，先设置的先显示，后设置的，如果与先设置的样式不一致，是不会覆盖的\n富文本设置的效果具有先后顺序，大家要注意"
    var labelone:UILabel!
    var labeltwo:UILabel!
    var labelthree:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        typeOne()
        typeTwo()
        typeThree()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /**
     * 一般写法
     */
    private func typeOne() {
        
        labelone = UILabel(frame: CGRectMake(16, 36, CGRectGetWidth(self.view.bounds) - 32, 21))
        labelone.backgroundColor = UIColor.redColor()
        labelone.text = str
        view.addSubview(labelone)
    }
    
    /**
     * 使用富文本设置UILabel
     */
    private func typeTwo() {
        
        let attributedString = NSMutableAttributedString(string: str)
        
        // 设置颜色
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: NSMakeRange(0, 2))
        
        // 设置字体
        attributedString.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(24), range: NSMakeRange(0, 4))
        
        labeltwo = UILabel(frame: CGRectMake(16, CGRectGetMaxY(labelone.frame) + 16, CGRectGetWidth(labelone.frame), 21 * 5))
        labeltwo.backgroundColor = UIColor.redColor()
        labeltwo.attributedText = attributedString
        
        view.addSubview(labeltwo)
    }
    
    /**
     * 使用包含段落的富文本
     */
    private func typeThree() {
        
        let attributedString = NSMutableAttributedString(string: str)
        
        // 设置段落样式
        let style = NSMutableParagraphStyle()
        
        // 行间距
        style.lineSpacing = 10
        
        // 段落间距
        style.paragraphSpacing = 20
        
        // add
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, (str as NSString).length))
        
        labelthree = UILabel(frame: CGRectMake(16, CGRectGetMaxY(labeltwo.frame) + 16, CGRectGetWidth(labeltwo.frame), 21 * 10))
        labelthree.backgroundColor = UIColor.redColor()
        labelthree.attributedText = attributedString
        
        labelthree.numberOfLines = 0 // 设置段落必须增加该设置
        
        view.addSubview(labelthree)
    }
}

