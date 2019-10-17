//
//  SwipeRotateViewController.swift
//  OnionGame
//
//  Created by Desire Guilarte on 2019/10/3.
//  Copyright © 2019 DesGui. All rights reserved.
//

import UIKit
import SpriteKit
import SceneKit

class SwipeRotateViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var scene:SCNScene!
    var onion:SCNNode!
    var onion_inside:SCNNode!
    var onion_bottom:SCNNode!
    var onion_Peel:SCNNode!
    var goneToOtherPage:Int!

    
    @IBOutlet weak var swipeRotateViewScene: SCNView!
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        setUpScene()
        setUpNode()
        goneToOtherPage = 0;
        
        let changeGesture = UITapGestureRecognizer(target:self, action:
            #selector(swipeRotate(_:)))
        changeGesture.delegate = self
        changeGesture.numberOfTapsRequired = 2
        swipeRotateViewScene.addGestureRecognizer(changeGesture)
    }
    
    func setUpScene(){
        scene = SCNScene(named: "art.scnassets/MainScene.scn")
        swipeRotateViewScene.scene = scene
        
        
    }
    
    func setUpNode(){
        onion = scene.rootNode.childNode(withName: "onion", recursively: true)
        onion_inside = scene.rootNode.childNode(withName: "onion_inside", recursively: true)
        onion_bottom = scene.rootNode.childNode(withName: "onion5", recursively: true)
        
        onion_bottom.opacity = 0

    }
    
    
    @IBAction func swipeRotate(_ sender: UIRotationGestureRecognizer) {
        var lastRotation = CGFloat()
        
        if(sender.state == .ended){
            lastRotation = 0.0
        }
        
        let rotation = 0.0 - (lastRotation - sender.rotation)
        SCNTransaction.animationDuration = 1
        onion.transform = SCNMatrix4Mult(onion.transform, SCNMatrix4MakeRotation(Float(rotation), 0, 1, 0))
        
        lastRotation = sender.rotation
        
        if (goneToOtherPage == 0){
            perform(#selector(rotateView), with: nil, afterDelay: 1.0)
            goneToOtherPage = 1
        }
        
        
    }
    
    @objc func rotateView(){
        performSegue(withIdentifier: "exampleSwipeToRotate", sender: nil)
    }
    

}
