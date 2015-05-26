//
//  ViewControllerModule.swift
//  TriggersExample-Swift
//
//  Created by Mike Chen on 5/25/15.
//  Copyright (c) 2015 Estimote Inc. All rights reserved.
//

import Foundation

class NearableHelper {

    
    /**
    * get the name of the sticker with id
    **/
    class func getNameFromId(id:String) -> String {
        var text = ""
        switch id {
        case "9b3cd4460c56565e":
            text = "converse shoes"
        case "d59a7be8987f28a4" :
            text = "door"
        case "8b386da476667197" :
            text = "bag"
        case "9b3cd4460c56565e" :
            text = "chair"
        case "7830f21de0035fe3" :
            text = "car"
        default :
            text = "unknown"
        }
        return text
    }
    // check if the sticker has moved given the current states of all nearables 
    // and the previous state of all nearables
    // return true if tag is not in its original position
    // false other wise
    // nil if id of the tag is not recorded when calibrated
    class func hasStickerMoved(id: String, currentNearableArr : [ESTNearable], savedNearableArr : [String : (x:Int , y:Int, z:Int)] ) -> Bool! {
        let tolerance = 50 // error range for the accelerations
        var n = findNearableWithId(id, nearables : currentNearableArr)
        
        var (x,y,z) = savedNearableArr[id]!
        if (savedNearableArr[id] == nil) {return nil}
        if n == nil { return nil}
        var name = getNameFromId(id)
        var x1 = Int(n.xAcceleration)
        var y1 = Int(n.yAcceleration)
        var z1 = Int(n.zAcceleration)
        var saved = sqrt(Float(x*x + y*y + z*z) )
        var current = sqrt(Float(x1*x1 + y1*y1 + z1*z1))
        var diff = saved - current
        /*
        if (Int(abs(diff)) <= tolerance) {
            return false //has not moved
        }
        else {
            return true
        }
        */
        
        return calcDiff1(x,y:y,z:z,x1:x1,y1:y1,z1:z1)
    }
    
    class func calcDiff1(x: Int , y: Int , z : Int , x1 : Int , y1 : Int , z1: Int)-> Bool {
        var res = abs(x1 - x) + abs(y1-y) + abs(z1-z)
        let t = 200
        if res <= t {
            return false
        }
        else {
            return true
        }
    }
    // return the nearable with id in the given nearable array
    // return nil if not found
    class func findNearableWithId(id:String, nearables : [ESTNearable]) -> ESTNearable! {
        for n in nearables {
            if id == n.identifier {
                return n
            }
        }
        return nil
    }

}