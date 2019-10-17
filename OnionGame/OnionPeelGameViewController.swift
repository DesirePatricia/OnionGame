//
//  OnionPeelGameViewController.swift
//  OnionGame
//
//  Created by Desire Guilarte on 2019-05-31.
//  Copyright © 2019 DesGui. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit
import GoogleMobileAds

class OnionPeelGameViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: Variables
    private var holdGestureActive = false
    private var peelGestureActive = false
    var scene:SCNScene!
    var onion:SCNNode!
    var onion_inside:SCNNode!
    var onion_bottom:SCNNode!
    var onion_Peel:SCNNode!
    var camFront:SCNNode!
    var camBack:SCNNode!
    var camLeft:SCNNode!
    var camRight:SCNNode!
    var onionPeeled = 0
    var initialLocation: Array<SCNVector3> = Array()
    var bannerView:GADBannerView!
    

    @IBOutlet weak var numberOfPeels: UILabel!
    @IBOutlet weak var peelViewScene: SCNView!
    
    override func viewDidLoad() {
        setUpScene()
        setUpNode()
        
        
        let peelGesture = UIPanGestureRecognizer(target: self, action: #selector(peelGestureRecignizer(_:)))
        peelGesture.delegate = self
        peelGesture.maximumNumberOfTouches = 1
        
        let changeGesture = UITapGestureRecognizer(target:self, action:
            #selector(doubleTapGestureRecignizer(_:)))
        changeGesture.delegate = self
        changeGesture.numberOfTapsRequired = 2
        
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotationGestureRecognizer(_:)))
        rotateGesture.delegate = self
        
        //self.sceneView.addGestureRecognizer(holdGesture)
        peelViewScene.addGestureRecognizer(peelGesture)
        peelViewScene.addGestureRecognizer(changeGesture)
        
        peelViewScene.isUserInteractionEnabled = true
        peelViewScene.isMultipleTouchEnabled = true
        
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        addBannerViewToView(bannerView)
        // RELEASE  bannerView.adUnitID = "ca-app-pub-5311645833613295/7173951314"
        //TEST
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
    }
    
    

    func setUpScene(){
        scene = SCNScene(named: "art.scnassets/MainScene.scn")
        peelViewScene.scene = scene
        

    }
    
    func setUpNode(){
        onion = scene.rootNode.childNode(withName: "onion", recursively: true)
        onion_inside = scene.rootNode.childNode(withName: "onion_inside", recursively: true)
        onion_bottom = scene.rootNode.childNode(withName: "onion5", recursively: true)
        
        onion_bottom.opacity = 0
        
        for onion_piece in onion.childNodes[0].childNodes{
            initialLocation.append(onion_piece.position)
        }
        
        camFront = scene.rootNode.childNode(withName: "camera", recursively: true)
        camBack = scene.rootNode.childNode(withName: "camera2", recursively: true)
        camLeft = scene.rootNode.childNode(withName: "camera3", recursively: true)
        camRight = scene.rootNode.childNode(withName: "camera4", recursively: true)
        
        
        
    }
    
    func endCameraControl(){
        peelViewScene.allowsCameraControl = false
    }
    
    func startCameraControl(){
        peelViewScene.allowsCameraControl = true
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: UIGestureRecognizerDelegate

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        
           return true
        
    }
    
    
    //MARK: Action
    @IBAction func rotationGestureRecognizer(_ sender: UIRotationGestureRecognizer) {
        var lastRotation = CGFloat()
        
        if(sender.state == .ended){
            lastRotation = 0.0
        }
        
        let rotation = 0.0 - (lastRotation - sender.rotation)
        SCNTransaction.animationDuration = 1
        onion.transform = SCNMatrix4Mult(onion.transform, SCNMatrix4MakeRotation(Float(rotation), 0, 1, 0))
        
        lastRotation = sender.rotation
        
        
    }
    
    @IBAction func doubleTapGestureRecignizer(_ sender: UITapGestureRecognizer) {
        if peelViewScene.pointOfView == camFront{
            peelViewScene.pointOfView = camLeft
        }
        else if peelViewScene.pointOfView == camLeft {
            peelViewScene.pointOfView = camBack
        }
        else if peelViewScene.pointOfView == camBack {
            peelViewScene.pointOfView = camRight
        }
        else  {
            peelViewScene.pointOfView = camFront
        }
    
    }
    
    @IBAction func peelGestureRecignizer(_ sender: UIPanGestureRecognizer) {
        
        
        if sender.state == .began{
            print("it has begun")
            peelGestureActive = true
                
                let location = sender.location(in: peelViewScene)
                let hitResults = peelViewScene.hitTest(location, options: nil)
            
            
                if hitResults.count > 0 {
                    let result = hitResults.first
                    if let onion_this_peel = result?.node{
                        if (onion_this_peel.name?.starts(with: "onion_peel"))!{
                            
                            SCNTransaction.animationDuration = 3
                            onion_this_peel.position = onion_bottom.position
                            SCNTransaction.animationDuration = 1
                            onion_this_peel.opacity = 0
                            
                            
                            onionPeeled = onionPeeled + 1
                            print(onionPeeled)
                            
                            
                            
                        
                        }
                        
                    }
                    
 
            }
            
            if onionPeeled == 11{
                
                perform(#selector(peeled), with: nil, afterDelay: 1.0)
                
                if let peels = numberOfPeels.text, var peelsInt = Int(peels){
                    peelsInt = peelsInt + 1
                    
                    numberOfPeels.text =  String(peelsInt)
                    
                    
                }
                
                onionPeeled = 0
                
            }
       }
        
        if sender.state == .ended{
            print("it has ended")
            peelGestureActive = false
        }
    }
    
    @IBAction func touchMenu(_ sender: UIButton) {
        performSegue(withIdentifier: "peelToMenu", sender: nil)
    }
    
    @IBAction func touchHelp(_ sender: UIButton) {
        performSegue(withIdentifier: "helpBackPeel", sender: nil)
    }
    
    @objc func peeled(){
        var count = 0
        for onion_slice in onion.childNodes[0].childNodes{

            onion_slice.position = initialLocation[count]
            
            SCNTransaction.animationDuration = 0.5
            onion_slice.opacity = 1
            
            
            print(count)
            count += 1
        
        }
        
        
        
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    

}
 

