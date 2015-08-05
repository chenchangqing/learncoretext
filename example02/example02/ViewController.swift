//
//  ViewController.swift
//  example02
//
//  Created by green on 15/8/5.
//  Copyright (c) 2015年 com.chenchangqing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 增加文字控件
        let textRect = CGRectInset(self.view.bounds, 10.0, 20.0)
        let textView = CTDisplayView(frame: textRect)
        self.view.addSubview(textView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

