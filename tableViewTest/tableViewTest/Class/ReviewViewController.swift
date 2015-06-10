//
//  ReviewViewController.swift
//  tableViewTest
//
//  Created by JsonWang on 15/6/9.
//  Copyright (c) 2015年 cn.jsonWang. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var dialogView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImage.addSubview(blurEffectView)
        
        //dialogView.transform = CGAffineTransformMakeScale(0, 0)
        let scale = CGAffineTransformMakeScale(0.0, 0.0)
        let translate = CGAffineTransformMakeTranslation(0, 500)
        dialogView.transform = CGAffineTransformConcat(scale, translate)
    }

    override func viewDidAppear(animated: Bool) {
//        UIView.animateWithDuration(0.7, delay: 0.0, options: nil, animations: { () -> Void in
//            self.dialogView.transform = CGAffineTransformMakeScale(1, 1)
//        }, completion: nil)
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.6,
    initialSpringVelocity: 0.5, options: nil, animations: {
    let scale = CGAffineTransformMakeScale(1, 1)
    let translate = CGAffineTransformMakeTranslation(0, 0)
    self.dialogView.transform = CGAffineTransformConcat(scale, translate)
    }, completion: nil)
    }
}
