//
//  CustomTableViewController.swift
//  tableViewTest
//
//  Created by JsonWang on 15-6-5.
//  Copyright (c) 2015年 cn.jsonWang. All rights reserved.
//

import UIKit

class CustomTableViewController: UITableViewController {
    
     var restaurants:[Restaurant] = []
//    var restaurants:[Restaurant] = [
//    Restaurant(name: "伟星大厦", type: "zhong su", location: "杭州文三路252号",
//    image: "free-flat-halloween-icons-01", isVisited: false),
//    Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong,Hong Kong,Hong Kong,Hong Kong", image: "free-flat-halloween-icons-02",
//    isVisited: false),
//    Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong,Hong Kong,Hong Kong,Hong Kong", image:
//    "free-flat-halloween-icons-03", isVisited: false),
//    Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong,Hong Kong,Hong Kong,Hong Kong",
//    image: "free-flat-halloween-icons-04", isVisited: false),
//    Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong,Hong Kong,Hong Kong,Hong Kong", image:
//    "free-flat-halloween-icons-05", isVisited: false),
//    Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong,Hong Kong,Hong Kong,Hong Kong", image:
//    "free-flat-halloween-icons-06", isVisited: false),
//    Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong,Hong Kong,Hong Kong,Hong Kong", image:
//    "free-flat-halloween-icons-07", isVisited: false),
//    Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney.Hong Kong,Hong Kong,Hong Kong,Hong Kong", image:
//    "free-flat-halloween-icons-08", isVisited: false),
//    Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney.Hong Kong,Hong Kong,Hong Kong,Hong Kong", image:
//    "free-flat-halloween-icons-09", isVisited: false),
//    Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney.Hong Kong,Hong Kong,Hong Kong,Hong Kong",
//    image: "free-flat-halloween-icons-10", isVisited: false),
//    Restaurant(name: "Upstate", type: "American", location: "New York.Sydney.Hong Kong,Hong Kong,Hong Kong,Hong Kong", image:
//    "free-flat-halloween-icons-11", isVisited: false),
//    Restaurant(name: "Traif", type: "American", location: "New York.Sydney.Hong Kong,Hong Kong,Hong Kong,Hong Kong", image: "free-flat-halloween-icons-21",
//    isVisited: false),
//    Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York.Sydney.Hong Kong,Hong Kong,Hong Kong,Hong Kong", image: "free-flat-halloween-icons-12", isVisited: false),
//    Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York.Sydney.Hong Kong,Hong Kong,Hong Kong,Hong Kong", image:
//    "free-flat-halloween-icons-13", isVisited: false),
//    Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York.Sydney.Hong Kong,Hong Kong,Hong Kong,Hong Kong", image:
//    "free-flat-halloween-icons-14", isVisited: false),
//    Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York.Sydney.Hong Kong,Hong Kong,Hong Kong,Hong Kong", image:
//    "free-flat-halloween-icons-15", isVisited: false),
//    Restaurant(name: "Confessional", type: "Spanish", location: "New York.Sydney.Hong Kong,Hong Kong,Hong Kong,Hong Kong", image:
//    "free-flat-halloween-icons-16", isVisited: false),
//    Restaurant(name: "Barrafina", type: "Spanish", location: "London,New York.Sydney.Hong Kong,Hong Kong,Hong Kong,Hong Kong", image:
//    "free-flat-halloween-icons-17", isVisited: false),
//    Restaurant(name: "Donostia", type: "Spanish", location: "London,New York.Sydney.Hong Kong,Hong Kong,Hong Kong,Hong Kong", image:
//    "free-flat-halloween-icons-18", isVisited: false),
//    Restaurant(name: "Royal Oak", type: "British", location: "London,New York.Sydney.Hong Kong,Hong Kong,Hong Kong,Hong Kong", image:
//    "free-flat-halloween-icons-19", isVisited: false),
//    Restaurant(name: "Thai Cafe", type: "Thai", location: "London,New York.Sydney.Hong Kong,Hong Kong,Hong Kong,Hong Kong", image: "free-flat-halloween-icons-20",
//    isVisited: false)
//    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        // cell 高度自定义1,autolayout 2,lines=0,3like add below code
        self.tableView.estimatedRowHeight = 36.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurants.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIndentifier = "cell"
        var tempEntity = self.restaurants[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIndentifier, forIndexPath: indexPath) as! CustomTableViewCell
        cell.imgview.image = UIImage(data: tempEntity.image)
        cell.imgview.layer.cornerRadius = cell.imgview.frame.size.width / 2
        cell.imgview.clipsToBounds = true
        cell.nameLabel.text = tempEntity.name
        cell.locationLabel.text = tempEntity.location
        cell.typeLabel.text = tempEntity.type
        //cell.accessoryType = isVisitedArrays[indexPath.row] ? .Checkmark: .None
        return cell
    }
    /*
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let openMenu = UIAlertController(title: nil, message: "what do you want to do?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        //
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        openMenu.addAction(cancelAction)
        //
        let callActionHandler = {(action:UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "service Unavailable", message: "Please try again", preferredStyle: UIAlertControllerStyle.Alert)
            alertMessage.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertMessage, animated: true, completion: nil)
        }
        let callAction = UIAlertAction(title: "Call 15957124901", style: UIAlertActionStyle.Default, handler: callActionHandler)
        openMenu.addAction(callAction)
        
        //
        let isVisitedAction = UIAlertAction(title: "I've been here", style: .Default) { (action:UIAlertAction!) -> Void in
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell?.accessoryType = .Checkmark
            self.isVisitedArrays[indexPath.row] = true
        }
        openMenu.addAction(isVisitedAction)
        
        self.presentViewController(openMenu, animated: true, completion: nil)
    }
    */
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //println("second action")
//        if editingStyle == UITableViewCellEditingStyle.Delete {
//            self.restaurantNames.removeAtIndex(indexPath.row)
//            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
//        }
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        //println("first action")
        var shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share") { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            let shareMenu = UIAlertController(title: nil, message: "Share using",
                preferredStyle: .ActionSheet)
            let twitterAction = UIAlertAction(title: "Twitter", style:
                UIAlertActionStyle.Default, handler: nil)
            let facebookAction = UIAlertAction(title: "Facebook", style:
                UIAlertActionStyle.Default, handler: nil)
            let emailAction = UIAlertAction(title: "Email", style: UIAlertActionStyle.Default,
                handler: nil)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel,
                handler: nil)
            shareMenu.addAction(twitterAction)
            shareMenu.addAction(facebookAction)
            shareMenu.addAction(emailAction)
            shareMenu.addAction(cancelAction)
            self.presentViewController(shareMenu, animated: true, completion: nil)
        }
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default,
            title: "Delete",handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
                // Delete the row from the data source
                self.restaurants.removeAtIndex(indexPath.row)
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
        )
        shareAction.backgroundColor = UIColor(red: 255.0/255.0, green: 166.0/255.0, blue:51.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor.redColor()
        return[deleteAction, shareAction]
    }
    
    // MARK: - USE segue TO CHANGE VALUE
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow(){
                let destinationController =  segue.destinationViewController as! DetailViewController
                destinationController.restaurant = restaurants[indexPath.row]
            }
        }
    }
    
    //
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue){
    
    }
    
 }
