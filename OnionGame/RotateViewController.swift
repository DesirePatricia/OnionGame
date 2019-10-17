//
//  RotateViewController.swift
//  OnionGame
//
//  Created by Desire Guilarte on 2019/7/8.
//  Copyright © 2019 DesGui. All rights reserved.
//

import UIKit
import SceneKit

class RotateViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var scene:SCNScene!
    var onion:SCNNode!
    var onion_bottom:SCNNode!
    var camFront:SCNNode!
    var camBack:SCNNode!
    var camLeft:SCNNode!
    var camRight:SCNNode!
    
    @IBOutlet weak var exampleRotate: SCNView!
    
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
        
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapRotateView(_:)))
            doubleTapGesture.delegate = self
            doubleTapGesture.numberOfTapsRequired = 2
        
        exampleRotate.addGestureRecognizer(doubleTapGesture)
        exampleRotate.isUserInteractionEnabled = true
        exampleRotate.isMultipleTouchEnabled = true
    }
    
    func setUpScene(){
        
        scene = SCNScene(named: "art.scnassets/MainScene.scn")
        exampleRotate.scene = scene;
        
    }
    
    func setUpNode(){
        
        onion = scene.rootNode.childNode(withName: "onion", recursively: true)
        onion_bottom = scene.rootNode.childNode(withName: "onion5", recursively: true)
        
        onion_bottom.opacity = 0
        
        camFront = scene.rootNode.childNode(withName: "camera", recursively: true)
        camBack = scene.rootNode.childNode(withName: "camera2", recursively: true)
        camLeft = scene.rootNode.childNode(withName: "camera3", recursively: true)
        camRight = scene.rootNode.childNode(withName: "camera4", recursively: true)
        
        
        
    }
    
    @IBAction func tapRotateView(_ sender: UITapGestureRecognizer) {
        
        if exampleRotate.pointOfView == camFront{
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0
            exampleRotate.pointOfView = camLeft
            SCNTransaction.commit()
        }
        else if exampleRotate.pointOfView == camLeft {
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0
            exampleRotate.pointOfView = camBack
            SCNTransaction.commit()
        }
        else if exampleRotate.pointOfView == camBack {
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0
            exampleRotate.pointOfView = camRight
            SCNTransaction.commit()
        }
        else  {
            performSegue(withIdentifier: "exampleFinished", sender: nil)
        }
        
        
    }
    
    

}
