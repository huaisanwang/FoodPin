//
//  CustomTableViewController.swift
//  tableViewTest
//
//  Created by JsonWang on 15-6-5.
//  Copyright (c) 2015年 cn.jsonWang. All rights reserved.
//          //let homeDir = NSHomeDirectory() //sandbox

import UIKit
import CoreData

class CustomTableViewController: UITableViewController,NSFetchedResultsControllerDelegate,UISearchResultsUpdating{
    
    var restaurants:[Restaurant] = []
    var fetchResultController:NSFetchedResultsController!
    var searchController:UISearchController!
    var searchResults:[Restaurant] = []
    var isWalkedThrouhtView = false
    
    let haystack: NSString = "the function to find some specify thing in the string"
    let needle: NSString = "function"
    
    //mark: - search method
    func filterContentForSearchText(searchText:String!){
        searchResults = restaurants.filter({ (entity:Restaurant) -> Bool in
            let nameMatch = entity.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return nameMatch != nil
        })
    
    }

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        filterContentForSearchText(searchText)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //是否调用滑动窗口
        toWalkThrouhtViewOrNot()
        setnavigationForUI()
        //fetch the data from database
        loadDataFromContext()
        //add searchbar
        setSearchController()
    

    }

    func toWalkThrouhtViewOrNot(){
        let defaults = NSUserDefaults.standardUserDefaults()
        let hasViewedWalkthrough = defaults.boolForKey("hasViewdwalkthrough")
        if hasViewedWalkthrough == false{
            if let pageViewController = storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as? MyPageViewController{
                self.presentViewController(pageViewController, animated: true, completion: nil)
            }
        }
    }
    func loadDataFromContext(){
    
        var fetchRequest = NSFetchRequest(entityName: "Restaurant")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext{
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            var e:NSError?
            var result = fetchResultController.performFetch(&e)
            restaurants = fetchResultController.fetchedObjects as! [Restaurant]
            if result != true{
                println(e?.localizedDescription)
            }
        }
    }
    func setnavigationForUI(){
    
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        // cell 高度自定义1,autolayout 2,lines=0,3like add below code
        self.tableView.estimatedRowHeight = 36.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
    
    }
    
    func setSearchController(){
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.whiteColor()
        searchController.searchBar.placeholder = "Search Food"
        searchController.searchBar.barTintColor = UIColor.orangeColor()
    }
        
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active{
            return searchResults.count
        }else{
            return self.restaurants.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIndentifier = "cell"
        var tempEntity = (searchController.active) ? searchResults[indexPath.row] : self.restaurants[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIndentifier, forIndexPath: indexPath) as! CustomTableViewCell
        cell.imgview.image = UIImage(data: tempEntity.image)
        cell.imgview.layer.cornerRadius = cell.imgview.frame.size.width / 2
        cell.imgview.clipsToBounds = true
        cell.nameLabel.text = tempEntity.name
        cell.locationLabel.text = tempEntity.location
        cell.typeLabel.text = tempEntity.type
        //cell.accessoryType = isVisitedArrays[indexPath.row] ? .Checkmark: .None
        //tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
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
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if searchController.active{
            return false
        }else{
            return true
        }
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
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title:
            "Delete",handler: {
            (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            // Delete the row from the data source
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
                let restaurantToDelete = self.fetchResultController.objectAtIndexPath(indexPath) as! Restaurant
                managedObjectContext.deleteObject(restaurantToDelete)
                var e: NSError?
                if managedObjectContext.save(&e) != true {
                    println("delete error: \(e!.localizedDescription)")
                }
            }
         })

//        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default,
//            title: "Delete",handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
//                // Delete the row from the data source
//                self.restaurants.removeAtIndex(indexPath.row)
//                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//            }
//        )
        shareAction.backgroundColor = UIColor(red: 255.0/255.0, green: 166.0/255.0, blue:51.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor.redColor()
        return[deleteAction, shareAction]
    }
    
    // MARK: - USE segue TO CHANGE VALUE
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow(){
                let destinationController =  segue.destinationViewController as! DetailViewController
                destinationController.restaurant = (searchController.active) ? searchResults[indexPath.row] : restaurants[indexPath.row]
            }
        }
    }
    
    //
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue){
        
    }
    
    //MARK: - NSFetchedResultsControllerDelegate Method
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath!, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath!) {
        switch type {
        case NSFetchedResultsChangeType.Insert:
            self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        case NSFetchedResultsChangeType.Delete:
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        case NSFetchedResultsChangeType.Update:
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        default:
            tableView.reloadData()
        }
        restaurants = controller.fetchedObjects as! [Restaurant]
    }


    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    
 }
