//
//  ViewController.swift
//  HandyExtensionsiOS
//
//  Created by Chandan on 16/09/18.
//  Copyright © 2018 Chandan. All rights reserved.
//

import UIKit

class GradientLoadingVC: UIViewController {
    
    var enabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapButton(view)
    }
    
    @IBAction func tapButton(_ sender: Any) {
        enabled = !enabled
        view.subviews.filter({ !($0 is UIButton) }).forEach({ $0.setLoading(enabled) })
    }
    
}

extension UIView {
    func setLoading(_ enable: Bool, width: Double = 0.15) {
        clipsToBounds = true
        if enable {
            let colors: [UIColor] = [UIColor(white: 0.92, alpha: 1), UIColor(white: 0.95, alpha: 1), UIColor(white: 0.92, alpha: 1)]
            let gradient: CAGradientLayer = (layer.sublayers?.first(where: { $0.name == "loading_layer" }) as? CAGradientLayer) ?? CAGradientLayer()
            gradient.name = "loading_layer"
            gradient.frame = CGRect(x: -UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width * 3, height: bounds.height)
            gradient.locations = [0, NSNumber(value: width), NSNumber(value: width * 2)]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 0)
            gradient.cornerRadius = layer.cornerRadius
            gradient.colors = colors.map { $0.cgColor }
            
            
            let anim = (gradient.animation(forKey: "loading_layer_anim") as? CABasicAnimation) ?? CABasicAnimation(keyPath: "locations")
            anim.fromValue = [0, NSNumber(value: width), NSNumber(value: width * 2)]
            anim.toValue = [NSNumber(value: 1 - width * 2), NSNumber(value: 1 - width), 1]
            anim.duration = 0.8
            anim.fillMode = kCAFillModeForwards
            anim.isRemovedOnCompletion = false
            anim.repeatCount = Float.greatestFiniteMagnitude
            gradient.add(anim, forKey: "loading_layer_anim")
            layer.addSublayer(gradient)
        } else {
            layer.sublayers?.first(where: { $0.name == "loading_layer" })?.removeFromSuperlayer()
        }
    }
}
