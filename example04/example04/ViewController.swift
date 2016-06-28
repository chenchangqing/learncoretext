//
//  ViewController.swift
//  example04
//
//  Created by green on 15/8/11.
//  Copyright (c) 2015年 com.chenchangqing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var bookView: BookTextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化bookView
        bookView = BookTextView(frame: CGRectMake(10, 10, CGRectGetWidth(self.view.bounds) - 20, CGRectGetHeight(self.view.bounds) - 20))
        
        // 读取文本
        let path = NSBundle.mainBundle().URLForResource("lorem", withExtension: "txt")?.path
        
        if let path=path {
            
            let text = try!String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            bookView.textString = text
        }
        
        // 设置段落样式
        bookView.paragraphAttributes = ParagraphAttributes.qingKeBengYue()
        
        // 设置富文本
        bookView.attributes.append(
            ConfigAttributedString.getStrokeColorInstance(UIColor.blackColor(), range: NSMakeRange(0, 9)))
        bookView.attributes.append(
            ConfigAttributedString.getInstance(UIFont(name: QingKeBengYue, size: 22)!, range: NSMakeRange(0,9)))
        
        // 加载图片
        let exclusionView       = ExclusionView(frame: CGRectMake(150, 195, 320, 150))
        bookView.exclusionViews = [exclusionView]
        
        let imageView   = UIImageView(frame: exclusionView.bounds)
        imageView.image = UIImage(named: "demo")
        exclusionView.addSubview(imageView)
        
        // 构建view
        bookView.buildWidgetView()
        view.addSubview(bookView)
        
        // 延时0.01s执行
        
        delayExecute(1, block: { () -> () in
            
            self.event()
        })
    }
    
    private func event() {
        
        bookView.moveToTextPercent(0)
    }
    
    // 延迟代码执行
    func delayExecute(sec:UInt64,block:()->()) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(NSEC_PER_SEC * sec)), dispatch_get_main_queue(), block)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

