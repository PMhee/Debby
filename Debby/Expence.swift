//
//  Expence.swift
//  Debby
//
//  Created by Tanakorn on 5/8/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import Foundation
import Realm
class Expense:RLMObject{
    dynamic var type : String = ""
    dynamic var date : NSDate!
    dynamic var fullPrice : Double = 0.0
    dynamic var downPrice : Double = 0.0
    dynamic var interest : Double = 0.0
    dynamic var period : Double = 0.0
    dynamic var title: String = ""
    dynamic var image : String = ""
}