//
//  Restaurant.swift
//  tableViewTest
//
//  Created by JsonWang on 15/6/10.
//  Copyright (c) 2015年 cn.jsonWang. All rights reserved.
//

import Foundation
import CoreData

class Restaurant: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var type: String
    @NSManaged var location: String
    @NSManaged var image: NSData
    @NSManaged var isVisited: NSNumber

}
