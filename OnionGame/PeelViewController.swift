//
//  PeelViewController.swift
//  OnionGame
//
//  Created by Desire Guilarte on 2019/7/8.
//  Copyright © 2019 DesGui. All rights reserved.
//

import UIKit
import SceneKit

class PeelViewController: UIViewController, UIGestureRecognizerDelegate{
    
    var scene:SCNScene!
    var onion:SCNNode!
    var onion_inside:SCNNode!
    var onion_bottom:SCNNode!
    var onion_Peel:SCNNode!
    var initialLocation:SCNVector3!
    var goneToOtherPage:Int!
    
    
    @IBOutlet weak var peelExample: SCNView!
   
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScene()
        setUpNode()
        goneToOtherPage = 0
        
        let peelOnion = UIPanGestureRecognizer(target: self, action: #selector(peelViewExample(_:)))
        peelOnion.delegate = self
        
        peelExample.addGestureRecognizer(peelOnion)

    }
    
    func setUpScene(){
        scene = SCNScene(named: "art.scnassets/MainScene.scn")
        peelExample.scene = scene;
        
    }
    
    func setUpNode(){
        onion = scene.rootNode.childNode(withName: "onion", recursively: true)
        onion_inside = scene.rootNode.childNode(withName: "onion_inside", recursively: true)
        onion_bottom = scene.rootNode.childNode(withName: "onion5", recursively: true)
        onion_Peel = onion.childNode(withName: "onion_peel_2", recursively: true)
        
        onion_bottom.opacity = 0
        
        initialLocation = onion_Peel.position
        
    }
    

    @IBAction func peelViewExample(_ sender: UIPanGestureRecognizer) {
        
        SCNTransaction.animationDuration = 3
        onion_Peel.position = onion_bottom.position
        SCNTransaction.animationDuration = 1
        onion_Peel.opacity = 0
        
        
        if (goneToOtherPage == 0){
        perform(#selector(rotateView), with: nil, afterDelay: 1.0)
            goneToOtherPage = 1 
        }
        
        
    }
  
   
    @objc func rotateView(){
        performSegue(withIdentifier: "exampleSegue", sender: nil)
    }
    


}
