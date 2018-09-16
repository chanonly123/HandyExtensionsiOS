//
//  StackViewHidingViewController.swift
//  HandyExtensionsiOS
//
//  Created by Chandan on 16/09/18.
//  Copyright © 2018 Chandan. All rights reserved.
//

import UIKit

class StackViewHidingVC: UIViewController {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toggleLabel1(_ sender: Any) {
        lbl1.setHidden(!lbl1.isHidden, layout: self.view)
    }
    
    @IBAction func toggleLabel2(_ sender: Any) {
        lbl2.setHidden(!lbl2.isHidden, layout: self.view)
    }
    
    @IBAction func togglePic(_ sender: Any) {
        img.setHidden(!img.isHidden, layout: self.view)
    }
}

extension UIView {
    func setHidden(_ hidden: Bool, layout: UIView? = nil, duration: Double = 0.3) {
        let parent = layout ?? superview
        if hidden {
            UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
                self.alpha = 0
            }, completion: { fin in
                if !fin { return }
                self.isHidden = true
                UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
                    parent?.layoutIfNeeded()
                }, completion: nil)
            })
        } else {
            isHidden = false
            alpha = 0
            UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
                parent?.layoutIfNeeded()
            }, completion: { fin in
                if !fin { return }
                UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
                    self.alpha = 1
                }, completion: nil)
            })
        }
    }
}
