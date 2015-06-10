//
//  DetailViewController.swift
//  tableViewTest
//
//  Created by JsonWang on 15-6-5.
//  Copyright (c) 2015年 cn.jsonWang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var tableView:UITableView!
    @IBOutlet var imgView:UIImageView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    
    var restaurant:Restaurant!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        self.tableView.tableFooterView = UIView(frame:CGRectZero)
        self.imgView.image = UIImage(data: restaurant.image)
        self.title = self.restaurant.name
        // label 高度自动
        self.tableView.estimatedRowHeight = 36.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    //MARK: - TABLEVIEW DATA
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DetailTableViewCell
        
        cell.mapButton.hidden = true
        switch indexPath.row{
            case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
            case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
            case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
            cell.mapButton.hidden = false
            case 3:
            cell.fieldLabel.text = "Been here"
            cell.valueLabel.text = (restaurant.isVisited.boolValue) ? "Yes": "No"
            default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        return cell
    }

    @IBAction func close(segue:UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showMap" {
        let destinationController = segue.destinationViewController as! MapViewController
        destinationController.restaurant = restaurant
        }
    }
}
