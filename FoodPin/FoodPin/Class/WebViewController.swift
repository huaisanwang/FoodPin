//
//  WebViewController.swift
//  FoodPin
//
//  Created by JsonWang on 15/6/12.
//  Copyright (c) 2015年 JsonWang. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView:UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = NSURL(string: "http://www.baidu.com"){
            let request = NSURLRequest(URL: url)
            webView.loadRequest(request)
        }
        
    }


}
