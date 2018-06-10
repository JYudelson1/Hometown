//
//  InfoViewController.swift
//  Hometown
//
//  Created by Joseph Yudelson on 5/25/18.
//  Copyright © 2018 Joseph Yudelson. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    var terribleInfo = String()
    var Category = String()
    var Place = String()
    var User = String()
     @IBOutlet weak var showPlace: UITextField!
    @IBOutlet weak var showCategory: UITextField!
    @IBOutlet weak var showInfo: UITextView!
    @IBOutlet weak var showUser: UITextField!
    override func viewDidLoad() {
        //print (terribleInfo,Category,Place,User)
        super.viewDidLoad()
        showPlace.text = Place
        showCategory.text = "Category: "+Category
        showInfo.text = terribleInfo
        showUser.text = User
        // Do any additional setup after loading the view.
        print(terribleInfo)
    
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareButtonClicked(_ sender: Any) {
        //Set the default sharing message.
        //let message = "Hello!"
        //let link = NSURL(string: "http://stackoverflow.com/")
        // Screenshot:
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, true, 0.0)
        self.view.drawHierarchy(in: self.view.frame, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //Set the link, message, image to share.
        if  let img = img {
            let objectsToShare = [img] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
