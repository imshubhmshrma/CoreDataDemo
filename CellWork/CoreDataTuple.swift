//
//  CoreDataTuple.swift
//  CellWork
//
//  Created by Shubham Sharma on 22/07/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation

struct CoreDataTuple {
    var id : Int32?
    var textFirst: String?
    var textSecond: String?
    var isSelectedd: Bool? = false
    var isSecuredd: Bool? = false
    var imagge: NSData?
    
    init(id:Int32 , t1:String , t2:String , imagge : NSData) {
        self.id = id
        self.textFirst = t1
        self.textSecond = t2
         self.imagge = imagge
    }
    
    init(dictionary: NSDictionary) {
        self.id = dictionary["id"] as? Int32
        self.textFirst = dictionary["text1"] as? String
        self.textSecond = dictionary["text2"] as? String
        self.imagge = dictionary["imagge"] as? NSData
    }
}

