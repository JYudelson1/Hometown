//
//  HomeModel.swift
//  Hometown
//
//  Created by Joseph Yudelson on 5/17/18.
//  Copyright © 2018 Joseph Yudelson. All rights reserved.
//


import Foundation

protocol HomeModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class HomeModel: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: HomeModelProtocol!
    
    var data = Data()
    //var map = MapViewController()
    let urlPath: String = "http://jyudel.yudel.com/read.php"
    func parseJSON(_ data:Data){
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        var locations = [LocationModel]()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let location = LocationModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let Username = jsonElement["Username"] as? String,
                let Latitude = jsonElement["Latitude"] as? String,
                let Longitude = jsonElement["Longitude"] as? String,
                let DateTime = jsonElement["DateTime"] as? String,
                let PlaceName = jsonElement["PlaceName"] as? String,
                let Info = jsonElement["Info"] as? String,
                let Category = jsonElement["Category"] as? String,
                let Public = jsonElement["Public"] as? String
            {
                
                location.Username = Username
                location.Latitude = Latitude
                location.Longitude = Longitude
                location.DateTime = DateTime
                location.PlaceName = PlaceName
                location.Info = Info
                location.Category = Category
                location.Public = Public
                
            }
            
            locations.append(location)
            
        }
        //let group = DispatchGroup()
        //group.enter()
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            GlobalVariables.sharedManager.locations = locations
        //GlobalVariables.sharedManager.test = "trying hard"
            //print (GlobalVariables.sharedManager.locations)
            
        //    group.leave()
        })
        //group.notify(queue: .main) {
        //}
        //print(locations)
    }
    func downloadItems(){
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        //var locs = NSMutableArray()
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJSON(data!)
                
            }
            
        }
        
        task.resume()
        
    }
}
