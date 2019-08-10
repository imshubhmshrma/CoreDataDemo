//
//  Extension NSManagedObject.swift
//  CellWork
//
//  Created by Shubham Sharma on 26/07/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Foundation
import  CoreData

extension NSManagedObject {
    func toDict() -> [String:Any] {
        let keys = Array(entity.attributesByName.keys)
        return dictionaryWithValues(forKeys:keys)
    }
}
