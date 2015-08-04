//
//  ViewController.swift
//  example01
//
//  Created by green on 15/8/4.
//  Copyright (c) 2015年 com.city8. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var textView: UITextView!
    private var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testStr = "Sometimes life hits you in the head with a brick. Don't lose faith. I'm convinced that the only thing that kept me going was that I loved what I did. You've got to find what you love. And that is as true for your work as it is for your lovers. 有时候，人生会把你打得头破血流，不要丧失信心。我坚信这些年来让我坚持不懈的唯一理由是我爱我所做的事情。你必须找到你的所爱，无论是工作还是恋人，都是如此。"
        let textViewRect = CGRectInset(self.view.bounds, 10.0, 20.0)
        
        // 创建NSTextStorage(存储文本的字符和相关属性)
        let textStorage = NSTextStorage()
        
        // 创建NSLayoutManager(负责对文字进行编辑排版处理)
        let layoutManager = NSLayoutManager()
        
        // 创建NSTextContainer(文本可以排版的区域)
        let textContainer = NSTextContainer(size: textViewRect.size)
        
        // 关联NSTextContainer对象和NSLayoutManager对象
        layoutManager.addTextContainer(textContainer)
        
        // 关联NSTextStorage对象和NSLayoutManager对象
        textStorage.addLayoutManager(layoutManager)
        
        // 使用NSTextContainer对象初始化UITextView，并添加在当前视图
        textView = UITextView(frame: textViewRect, textContainer: textContainer)
        self.view.addSubview(textView)
        
        // 添加图片
        imageView = UIImageView(frame: CGRectMake(0, 100, 200, 456/4))
        imageView.image = UIImage(named: "MetalType")
        imageView.center.x = textView.center.x
        self.view.addSubview(imageView)
        
        // 通过NSTextStorage设置文字属性
        textStorage.beginEditing()
        
        let attrStr = NSMutableAttributedString(string: testStr, attributes: [NSTextEffectAttributeName:NSTextEffectLetterpressStyle])
        textStorage.setAttributedString(attrStr)
        
        mark("I", inTextStorage: textStorage)
        mark("我", inTextStorage: textStorage)
        
        textStorage.endEditing()
        
        // 设置环绕
        textContainer.exclusionPaths = [self.translatedBezierPath()]
    }

    /**
     * 实现特定单词的查找，并添加设置效果
     * @param word 要查找的单词
     * @param textStorage 存储文本信息的对象
     */
    private func mark(word:String,inTextStorage textStorage:NSTextStorage) {

        // 正则
        let regex = NSRegularExpression(pattern: word, options: nil, error: nil)!
        
        // 根据正则匹配结果
        let matches = regex.matchesInString(textStorage.string, options: nil, range: NSMakeRange(0, count(textStorage.string)))
        
        // 给指定单词设置颜色
        for match in matches {
            
            let match = (match as! NSTextCheckingResult)
            let matchRange = match.range
            textStorage .addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: matchRange)
        }
    }
    
    /**
     * 获取文字环绕的矩形
     */
    private func translatedBezierPath() -> UIBezierPath {
        
        // 图片相对文本控件的坐标
        let imageRect = textView.convertRect(imageView.frame, fromView: self.view)
        
        // 贝塞尔曲线，这里是矩形
        let newPath = UIBezierPath(rect: imageRect)
        return newPath
        
    }
}

