//
//  MyPageViewController.swift
//  FoodPin
//
//  Created by JsonWang on 15/6/11.
//  Copyright (c) 2015年 JsonWang. All rights reserved.
//

import UIKit

class MyPageViewController: UIPageViewController,UIPageViewControllerDataSource {

    var pageHeadings = ["Personaize","ssss","sdfasf"]
    var pageImages = ["free-flat-halloween-icons-06","free-flat-halloween-icons-07","free-flat-halloween-icons-08"]
    var pageSubHeadings = ["asdfasfadfa","asdfasdf","skfaksdf"]
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PageContentViewController).index
        index++
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PageContentViewController).index
        index--
        return self.viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index:Int) ->PageContentViewController?{
        if index == NSNotFound || index < 0 || index >= self.pageHeadings.count{
            return nil
        }
        if let pageContentViewController = storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as? PageContentViewController{
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.subHeading = pageSubHeadings[index]
            pageContentViewController.index = index
            return pageContentViewController
        }
        return nil
    }
    
    func forwad(index:Int){
        if let nextViewController = self.viewControllerAtIndex(index+1){
            setViewControllers([nextViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        }
    }
    // to add a standard page indicator
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageHeadings.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        if let pageContentViewController = storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as? PageContentViewController{
            return pageContentViewController.index
        }
        return 0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        if let startingViewController = self.viewControllerAtIndex(0){
            setViewControllers([startingViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        }
    }

}
