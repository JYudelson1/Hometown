//
//  GlobalVariables.swift
//  Hometown
//
//  Created by Joseph Yudelson on 5/18/18.
//  Copyright © 2018 Joseph Yudelson. All rights reserved.
//

import Foundation
import CoreLocation

class GlobalVariables {
    
    // These are the properties you can store in your singleton
    var locations = [LocationModel]()
    var username:String = "test"
    var currentLoc = CLLocationCoordinate2D()
    var currentInfo = String()
    // Here is how you would get to it without there being a global collision of variables.
    // , or in other words, it is a globally accessable parameter that is specific to the
    // class.
    class var sharedManager: GlobalVariables {
        struct Static {
            static let instance = GlobalVariables()
        }
        return Static.instance
    }
}
