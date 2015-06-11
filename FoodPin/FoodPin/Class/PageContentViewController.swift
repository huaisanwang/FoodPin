//
//  PageContentViewController.swift
//  FoodPin
//
//  Created by JsonWang on 15/6/11.
//  Copyright (c) 2015年 JsonWang. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    @IBOutlet weak var headingLabel:UILabel!
    @IBOutlet weak var subHeadingLabel:UILabel!
    @IBOutlet weak var contentImageView:UIImageView!
    
    @IBOutlet weak var getStartedButton:UIButton!
    @IBOutlet weak var forwardButton:UIButton!
    
    var index:Int = 0
    var heading:String = ""
    var subHeading:String = ""
    var imageFile:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headingLabel.text = heading
        subHeadingLabel.text = subHeading
        contentImageView.image = UIImage(named: imageFile)
        
        getStartedButton.hidden = (index == 2) ? false:true
        forwardButton.hidden = (index == 2) ? true:false
        
    }

    @IBAction func close(sender:AnyObject){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "hasViewdwalkthrough")
        //dismiss之前先保存状态,确保下次启动不会再调用 walkthrough
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func nextScreen(sender:AnyObject){
        let pageViewController = self.parentViewController as! MyPageViewController
        pageViewController.forwad(index)
    }


}
