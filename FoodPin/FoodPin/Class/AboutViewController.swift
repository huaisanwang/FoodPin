//
//  AboutViewController.swift
//  FoodPin
//
//  Created by JsonWang on 15/6/12.
//  Copyright (c) 2015年 JsonWang. All rights reserved.
//

import UIKit
import MessageUI

class AboutViewController: UIViewController,MFMailComposeViewControllerDelegate,UINavigationControllerDelegate {

    @IBAction func sendEmail(sender:AnyObject){
        if MFMailComposeViewController.canSendMail(){
            var composer = MFMailComposeViewController()
            composer.mailComposeDelegate = self
            composer.setToRecipients(["632494788@qq.com"])
            composer.navigationBar.tintColor = UIColor.whiteColor()
            
            presentViewController(composer, animated: true, completion: { () -> Void in
                UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
            })
            
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        switch result.value{
        case MFMailComposeResultCancelled.value:
            println("mail cancelled")
        case MFMailComposeResultSaved.value:
            println("mail saved")
        case MFMailComposeResultSent.value:
            println("mail sent")
        case MFMailComposeResultFailed.value:
            println("Failed to send mail")
        default:
            break
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
