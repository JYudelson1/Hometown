//
//  TaggingViewController.swift
//  Hometown
//
//  Created by Joseph Yudelson on 5/17/18.
//  Copyright © 2018 Joseph Yudelson. All rights reserved.
//

import UIKit
import Foundation

class TaggingViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
   

    @IBOutlet weak var publisher: UIButton!
    @IBOutlet weak var PlaceName: UITextView!
    @IBOutlet weak var PlaceInfo: UITextView!
    @IBOutlet weak var Public: UISwitch!
    @IBOutlet weak var Category: UIPickerView!
     var data = ["None/Other", "Sights", "Hidden Spot", "Cool Minutiae", "Personal", "Stores/Business"]
    var cat = Int()
    var homeModel = HomeModel()
    var shouldBePublic:String = "0"
    var myUrl:String = "http://jyudel.yudel.com/write.php?"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.PlaceName.delegate = self
         self.Category.delegate = self
        self.Category.dataSource = self
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UITextField.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        /*self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))*/
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        // Return a string from the array for this row.
        return data[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        cat = row
        let colors = [UIColor.lightGray, UIColor.yellow, UIColor.blue, UIColor.red, UIColor.cyan, UIColor.green]
        let catColor = colors[row]
        self.view.backgroundColor = catColor
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonClick(sender: UIButton) {
        if Public.isOn {
            shouldBePublic = "1"
        }
        let newUrl:String = "\(myUrl)Username=%22\(GlobalVariables.sharedManager.username)%22&PlaceName=%22\(PlaceName.text!)%22&Info=%22\(PlaceInfo.text!.replacingOccurrences(of: "\"", with: "%22"))%22&Latitude=%22\(GlobalVariables.sharedManager.currentLoc.latitude)%22&Longitude=%22\(GlobalVariables.sharedManager.currentLoc.longitude)%22&Category=%22\(String(cat))%22&Public=%22\(shouldBePublic)%22".replacingOccurrences(of: " ", with: "%20").replacingOccurrences(of: "'", with: "%27").replacingOccurrences(of: "’", with: "%27").replacingOccurrences(of: "`", with: "%27").replacingOccurrences(of: "`", with: "%27").replacingOccurrences(of: "‘", with: "%27").replacingOccurrences(of: "’", with: "%27")
        print(newUrl)
        let url: URL = URL(string: newUrl)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to upload data")
            }else {
                print("Location added")
            }
        }
        task.resume()
        homeModel.downloadItems()
        print(cat)
        performSegue(withIdentifier: "backToMap", sender: self)
    }
    @IBAction func nextField(_ sender: UITextField) {
        if sender == PlaceName {
            self.view.endEditing(true)
        }
    }
    /*func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        PlaceName.endEditing(true)
        return(true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
     
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
