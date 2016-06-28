//
//  BookTextView.swift
//  example04
//
//  Created by green on 15/8/11.
//  Copyright (c) 2015年 com.chenchangqing. All rights reserved.
//

import UIKit

enum EBookTextViewStatus : Int {
    case EBOOK_NONE = 0
    case EBOOK_CALCULATE_HEIGHT = 1
}

class BookTextView: UIView, UITextViewDelegate {
    
    // 要显示的文本
    var textString              = ""
    
    // 段落样式的设置
    var paragraphAttributes     = [String:AnyObject]()
    
    // 富文本参数数组(ConfigAttributedString对象的数组)
    var attributes              = [ConfigAttributedString]()
    
    // 计算出的文本的高度
    var textHeight:CGFloat      = 0
    
    // 当前文本已读百分比
    var currentPercent:CGFloat  = 0
    
    // 存储的图文混排的views
    var exclusionViews          = [ExclusionView]()
    
    private var bookStatus      = EBookTextViewStatus.EBOOK_NONE
    private var tmpOffsetY      : CGFloat = 0
    private var tmpPercent      : CGFloat = 0
    
    private var textView        : UITextView!
    
    /**
     *  构建出组件(设置完所有参数后再做)
     */
    func buildWidgetView() {
        
        // 获取长宽
        let width   = self.frame.size.width
        let height  = self.frame.size.height
        
        // 创建文本容器并设置段落样式
        let storage = NSTextStorage(string: textString, attributes: paragraphAttributes)
        
        // 设置富文本
        for config in attributes {
            
            storage.addAttribute(config.attribute, value: config.value, range: config.range)
        }
        
        // 管理器
        let layoutManager = NSLayoutManager()
        storage.addLayoutManager(layoutManager)
        
        // 显示的容器
        let textContainer   = NSTextContainer()
        let size            = CGSizeMake(width, CGFloat(MAXFLOAT))
        textContainer.size  = size
        layoutManager.addTextContainer(textContainer)
        
        // 给TextView添加带有内容和布局的容器
        textView = UITextView(frame: CGRectMake(0, 0, width, height), textContainer: textContainer)
        
        textView.scrollEnabled  = true
        textView.editable       = false
        textView.selectable     = false
        textView.layer.masksToBounds            = true
        textView.showsVerticalScrollIndicator   = false
        
        textView.delegate = self
        
        // 如果有额外的views
        if exclusionViews.count > 0 {
            
            var pathArray = [UIBezierPath]()
            
            // 添加view + 添加path
            for tempView in exclusionViews {
                
                textView.addSubview(tempView)
                pathArray.append(tempView.createUIBezierPath())
            }
            
            textContainer.exclusionPaths = pathArray
        }
        
        // 添加要显示的view
        self.addSubview(textView)
        
        // 存储文本高度
        storeBookHeight()
    }
    
    private func storeBookHeight() {
    
        // 先偏移到文本末尾位置
        bookStatus = .EBOOK_CALCULATE_HEIGHT
        UIView.setAnimationsEnabled(false)
        textView.scrollRangeToVisible(NSMakeRange((textView.text as NSString).length, 0))
        UIView.setAnimationsEnabled(true)
        bookStatus = .EBOOK_NONE
        
        // 再偏移到文本开头位置
        UIView.setAnimationsEnabled(false)
        textView.scrollRangeToVisible(NSMakeRange(0, 0))
        UIView.setAnimationsEnabled(true)
    
    }
    
    /**
     *  移动到指定的位置(此方法只有延时执行才有效果,比如延时执行0.01s)
     *
     *  @param position 文本的高度位置
     */
    func moveToTextPosition(position:CGFloat) {
        
        textView.setContentOffset(CGPointMake(0, position), animated: false)
    }
    
    /**
     *  移动到指定的百分比(此方法只有延时执行才有效果,比如延时执行0.01s)
     *
     *  @param percent 百分比
     */
    func moveToTextPercent(percent:CGFloat) {
        
        // 计算出百分比
        var position:CGFloat = 0
        if percent >= 0 && percent <= 1 {
            
            position = percent * textHeight
        } else if percent < 0 {
            
            position = 0
        } else {
            
            position = textHeight
        }
        
        // 移动到指定的位置
        textView.setContentOffset(CGPointMake(0, position), animated: false)
        
    }
    
    // MARK: - 
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // Y轴偏移量
        tmpPercent = scrollView.contentOffset.y
        
        if bookStatus == .EBOOK_NONE {
            
            tmpPercent = tmpOffsetY / textHeight
            
            if tmpPercent >= 0 && tmpPercent <= 1 {
                
                currentPercent = tmpPercent
            } else if tmpPercent < 0 {
                
                currentPercent = 0
            } else {
                
                currentPercent = 1
            }
            
            print("\(currentPercent)")
        } else if bookStatus == .EBOOK_CALCULATE_HEIGHT {
            
            self.textHeight = scrollView.contentOffset.y
        }
    }

}
