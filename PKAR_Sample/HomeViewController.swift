//
//  HomeViewController.swift
//  PKAR_Sample
//
//  Created by Pradeep on 2/13/19.
//  Copyright © 2019 Tarento Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import Lottie

class HomeViewController: BaseViewController {

    @IBOutlet weak var homeContainerView: UIView!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var subContainerView: UIView!
    typealias ResponseCallback = (UIView, Bool) -> ()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.actionButton.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            self.loadAnimation()
        }
    }
    
    func loadAnimation() {
        self.centerView.isHidden = true
        self.actionButton.isHidden = true
        var frame = CGRect(x: 0, y: 0, width: Int(self.view.bounds.size.width), height: Int(self.view.bounds.size.height))
        self.animate(onView: self.homeContainerView, frame:frame ,animationFile: "summer") { (animatedView: UIView, isFinished : Bool) in
            animatedView.removeFromSuperview()
            frame = CGRect(x: 0, y: 0, width: Int(self.view.bounds.size.width), height: Int(self.view.bounds.size.width))
            self.animate(onView: self.homeContainerView, frame:frame ,animationFile: "fabulous-onboarding-animation") { (animatedView: UIView, isFinished : Bool) in
                animatedView.removeFromSuperview()
                frame = self.homeContainerView.bounds
                self.centerView.isHidden = false
                self.actionButton.isHidden = false
                self.animateProgressive(onView: self.homeContainerView, frame:frame , from: 0.0, to: 0.75, animationFile: "floral-loading-animation") { (animatedView: UIView, isFinished : Bool) in
                    animatedView.removeFromSuperview()
                     self.animate(onView: self.homeContainerView, frame:frame ,animationFile: "dice-animation") { (animatedView: UIView, isFinished : Bool) in
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func animate(onView:UIView, frame:CGRect, animationFile : String, onCompletion : @escaping ResponseCallback) {
        let animationView = LOTAnimationView(name: animationFile)
        animationView.bounds = frame//CGRect(x: Int(onView.bounds.origin.x), y: Int(onView.bounds.origin.y), width: Int(onView.bounds.size.width), height: Int(onView.bounds.size.width))
        animationView.center = onView.center
        animationView.backgroundColor = UIColor.clear
        self.homeContainerView.addSubview(animationView)
        animationView.play{ (finished) in
            onCompletion(animationView, true)
        }
    }
    
    func animateProgressive(onView:UIView, frame:CGRect, from: CGFloat, to:CGFloat, animationFile : String, onCompletion : @escaping ResponseCallback) {
        let animationView = LOTAnimationView(name: animationFile)
        animationView.bounds = frame//CGRect(x: Int(onView.bounds.origin.x), y: Int(onView.bounds.origin.y), width: Int(onView.bounds.size.width), height: Int(onView.bounds.size.width))
        animationView.center = onView.center
        animationView.backgroundColor = UIColor.clear
        self.homeContainerView.addSubview(animationView)
        animationView.play(fromProgress: from, toProgress: to) { (finished) in
            onCompletion(animationView, true)
        }
    }
    
    @IBAction func tapHereClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "ARSegueIdentifier", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
