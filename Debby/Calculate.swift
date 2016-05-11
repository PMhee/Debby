//
//  Calculate.swift
//  Debby
//
//  Created by Tanakorn on 5/7/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import Foundation
class Calculate{
    static let shareInstance = Calculate()
    private init(){
        
    }
    internal func normalDebtCal(full:Double,down:Double,interest:Double,time:Double) -> Double{
        if full != 0 || interest != 0 || time != 0{
        var interestAll: Double!
        if down != 0 {
            interestAll = ((full-down)*interest)/100
        }else{
            interestAll = (full*interest)/100
        }
        var sum : Double!
        var f = full
        f += interestAll
        sum = f/time
        return sum
    }else{
            return 0.0
    }
    }
}

