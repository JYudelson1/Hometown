//
//  LocationModel.swift
//  Hometown
//
//  Created by Joseph Yudelson on 5/17/18.
//  Copyright © 2018 Joseph Yudelson. All rights reserved.
//

import Foundation

class LocationModel: NSObject {
    
    //properties
    
    var Username: String?
    var Latitude: String?
    var Longitude: String?
    var DateTime: String?
    var PlaceName: String?
    var Info: String?
    var Category: String?
    var Public: String?

    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct
    
    init(Username: String, Latitude: String, Longitude: String, DateTime: String, PlaceName: String, Info: String, Category: String, Public: String) {
        
        self.Username = Username
        self.Latitude = Latitude
        self.Longitude = Longitude
        self.DateTime = DateTime
        self.PlaceName = PlaceName
        self.Info = Info
        self.Category = Category
        self.Public = Public
        
    }
    
    //var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(Double(self.Latitude!)!, Double(self.Longitude!)!)
    //var title: String = self.PlaceName
    //prints object's current state
    
    override var description: String {
        return "(Username: \(String(describing: Username)), Latitude: \(String(describing: Latitude)), Longitude: \(String(describing: Longitude)), DateTime: \(String(describing: DateTime)), PlaceName: \(String(describing: PlaceName)), Info: \(String(describing: Info)), Category: \(String(describing: Category)), Public: \(String(describing: Public)))"
        
    }
    
    
}
