//
//  ViewController.swift
//  Hometown
//
//  Created by Joseph Yudelson on 5/9/18.
//  Copyright © 2018 Joseph Yudelson. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
    var ads = [LocationAnnotationNode]()
    var sceneLocationView = SceneLocationView()
    var annotationsToLocs = [LocationAnnotationNode : LocationModel]()
    var terribleInfo = String()
    var terribleCat = Int()
    var terribleUser = String()
    var terriblePlace = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for loc:LocationModel in GlobalVariables.sharedManager.locations{
        sceneLocationView.run()
        view.addSubview(sceneLocationView)
            let coordinate = CLLocationCoordinate2D(latitude: Double(loc.Latitude!)!, longitude: Double(loc.Longitude!)!)
        let location = CLLocation(coordinate: coordinate, altitude: 10)
        var image = UIImage()
            switch loc.Category!{
            case "0":
                image = UIImage(named: "orb-lightgrey")!
            case "1":
                image = UIImage(named: "orb-yellow")!
            case "2":
                image = UIImage(named: "orb-blue")!
            case "3":
                image = UIImage(named: "orb-150545_960_720.png")!
            case "4":
                image = UIImage(named: "orb-cyan")!
            case "5":
                image = UIImage(named: "orb-green")!
            default:
                image = UIImage(named: "orb-lightgrey")!
            }
            let annotationNode = LocationAnnotationNode(location: location, image: image)
       annotationNode.scaleRelativeToDistance = true
       if (loc.Public! == "1" || GlobalVariables.sharedManager.username == loc.Username!){
        ads.append(annotationNode)
       annotationsToLocs[annotationNode] = loc
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
        }}
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneLocationView.frame = CGRect(x:0,y:0, width:view.bounds.width,height:(view.bounds.height-44))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        //let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        //sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //super.viewWillDisappear(animated)
        
        // Pause the view's session
        //sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toInfoFromAR" {
            if let destination = segue.destination as? InfoViewController {
                destination.terribleInfo = terribleInfo
                destination.Category = ["None/Other", "Sights", "Hidden Spot", "Cool Minutiae", "Personal", "Stores/Business"][terribleCat]
                destination.Place = terriblePlace
                destination.User = terribleUser
                
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first
            else { return }
        
        guard let result = sceneLocationView.hitTest(touch.location(in: sceneLocationView), options: nil).first
            else {return}
        
        for ad:LocationAnnotationNode in ads
        {
            if (ad.contains(result.node))
            {
                let infoLoc = annotationsToLocs[ad]!
                terriblePlace = infoLoc.PlaceName!
                terribleUser = infoLoc.Username!
                terribleInfo = infoLoc.Info!
                terribleCat = Int(infoLoc.Category!)!
                //print (annotation.debugDescription!)
                performSegue(withIdentifier: "toInfoFromAR", sender: self)
            }
        }
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
  
}
