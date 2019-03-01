//
//  ARViewController.swift
//  PKAR_Sample
//
//  Created by Pradeep on 2/13/19.
//  Copyright © 2019 Tarento Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import ARKit

class ARViewController: BaseViewController {

    @IBOutlet weak var sceneKitView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let configuration = ARWorldTrackingConfiguration()
        sceneKitView.session.run(configuration)
        addBox()
        addTapGestureToSceneView()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneKitView.session.pause()
    }
    
    func addBox() {
        let sphere = SCNSphere(radius: 0.1)
        
        let boxNode = SCNNode()
        boxNode.geometry = sphere
        boxNode.position = SCNVector3(0, 0, -1)
        
        addLightNodeTo(boxNode)
        
        sphere.firstMaterial?.diffuse.contents  = UIColor(red: 30.0 / 255.0, green: 150.0 / 255.0, blue: 30.0 / 255.0, alpha: 1)
        let scene = SCNScene()
        scene.rootNode.addChildNode(boxNode)
        sceneKitView.scene = scene
    }
    
    func getLightNode() -> SCNNode {
        let light = SCNLight()
        light.type = .omni
        light.intensity = 5000
        light.temperature = 5000
        
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3(-1,-1,1)
        
        return lightNode
    }
    
    func addLightNodeTo(_ node: SCNNode) {
        let lightNode = getLightNode()
        node.addChildNode(lightNode)
    }
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ARViewController.didTap(withGestureRecognizer:)))
        sceneKitView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneKitView)
        let hitTestResults = sceneKitView.hitTest(tapLocation)
        guard let node = hitTestResults.first?.node else { return }
        node.removeFromParentNode()
        //        let hitTestResultsWithFeaturePoints = sceneKitView.hitTest(tapLocation, types: .featurePoint)
        //
        //        if let hitTestResultWithFeaturePoints = hitTestResultsWithFeaturePoints.first {
        //            let translation = hitTestResultWithFeaturePoints.worldTransform.translation
        //            addBox(x: translation.x, y: translation.y, z: translation.z)
        //        }
    }
    
    func addBox(x: Float = 0, y: Float = 0, z: Float = -0.2) {
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        
        let boxNode = SCNNode()
        boxNode.geometry = box
        boxNode.position = SCNVector3(x, y, z)
        
        sceneKitView.scene.rootNode.addChildNode(boxNode)
    }
    
    //    @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
    //        let tapLocation = recognizer.location(in: sceneView)
    //        let hitTestResults = sceneKitView.hitTest(tapLocation)
    //        guard let node = hitTestResults.first?.node else {
    //            let hitTestResultsWithFeaturePoints = sceneView.hitTest(tapLocation, types: .featurePoint)
    //            if let hitTestResultWithFeaturePoints = hitTestResultsWithFeaturePoints.first {
    //                let translation = hitTestResultWithFeaturePoints.worldTransform.translation
    //                addBox(x: translation.x, y: translation.y, z: translation.z)
    //            }
    //            return
    //        }
    //        node.removeFromParentNode()
    //    }
}

extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}
