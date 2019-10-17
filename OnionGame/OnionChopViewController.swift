//
//  OnionChopViewController.swift
//  OnionGame
//
//  Created by Desire Guilarte on 2019/7/27.
//  Copyright © 2019 DesGui. All rights reserved.
//

import SpriteKit
import SceneKit
import UIKit


class OnionChopViewController: UIViewController, UIGestureRecognizerDelegate, SCNPhysicsContactDelegate{
    
    var scene:SCNScene!
    var onion:SCNNode!
    
    var currentGeometry:SCNGeometry!
    var choppedGeometry:SCNGeometry!
    
    var initialPoint:CGPoint!
    var endPoint:CGPoint!
    
    
    @IBOutlet weak var chopSCNView: SCNView!
    
    @IBAction func touchMenu(_ sender: UIButton) {
        performSegue(withIdentifier: "chopToMenu", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scene = SCNScene(named: "art.scnassets/MainScene.scn")
        
        onion = scene.rootNode.childNode(withName: "onion", recursively: true)
        
        //onion.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        
       // onion?.scale = SCNVector3Make(100, 100, 100)
        
       // chopSCNView.scene = scene;
        
        //currentGeometry = onion.geometry
        
//        print(currentGeometry.description)
        
       // setUpPhysicsWorld()
        
        //onion.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: currentGeometry, options: nil))
        
        let chopGesture = UIPanGestureRecognizer(target: self, action: #selector(onionSwipe(_:)))
        chopGesture.delegate = self
        
        
        chopSCNView.addGestureRecognizer(chopGesture)
        
        chopSCNView.isMultipleTouchEnabled = true
        chopSCNView.isUserInteractionEnabled = true
        
        
        
        
    }
    
    @IBAction func onionSwipe(_ sender: UIPanGestureRecognizer) {
        /*
        guard sender.view != nil else {return}
        let touch = sender.view!
        let translation = sender.translation(in: touch.superview)
        
        
        if (sender.state == .began){
            let location = sender.location(in: chopSCNView)
            let hitResults = chopSCNView.hitTest(location, options: nil)
            
            
            if hitResults.count > 0 {
                let result = hitResults.first
                if onion == result?.node{
                    
                    
                    
                }
                
                
                
            }
            
            initialPoint = touch.center
 
            
        }
        
        if (sender.state != .cancelled){
            
            endPoint = CGPoint(x: initialPoint.x + translation.x , y: initialPoint.y + translation.y)
            splitUp()
            
            
        }else{
            touch.center = initialPoint
        }
        */
        
        
    }
    
    
    func setUpPhysicsWorld(){
      //  scene.physicsWorld.contactDelegate = self
        
        
    }
    
    func splitUp(){
        
        
        
    }
    

    

}
