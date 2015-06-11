//
//  AddableViewController.swift
//  tableViewTest
//
//  Created by JsonWang on 15/6/10.
//  Copyright (c) 2015年 cn.jsonWang. All rights reserved.
//

import UIKit
import CoreData

class AddableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var restaurant:Restaurant!
    var isVisited = false
    
    @IBOutlet weak var imageView: UIImageView!
    //文本框
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    
    
    @IBAction func saveRestaurant(sender: AnyObject) {
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext{
            restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: managedObjectContext) as! Restaurant
            restaurant.name = nameTextField.text
            restaurant.type = typeTextField.text
            restaurant.location = locationTextField.text
            restaurant.image = UIImagePNGRepresentation(imageView.image)
            restaurant.isVisited = isVisited
            
            var e:NSError?
            if managedObjectContext.save(&e) != true{
                println("insert error:\(e!.localizedDescription)")
                return
            }
        }
    }
    
    @IBAction func yesButtonClick(sender: UIButton) {
        self.yesButton.backgroundColor = UIColor.redColor()
        self.noButton.backgroundColor = UIColor.grayColor()
        isVisited = true
    }
    
    @IBAction func noButtonClick(sender: UIButton) {
        self.yesButton.backgroundColor = UIColor.grayColor()
        self.noButton.backgroundColor = UIColor.redColor()
        isVisited = false
    }
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0{
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
                
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }


    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.ScaleToFill
        imageView.clipsToBounds = true
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}
