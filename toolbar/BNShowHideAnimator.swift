//
//  BNShowHideAnimator.swift
//  toolbar
//
//  Created by ヨト　ジャンフランソワ on 03/12/2017.
//  Copyright © 2017 tcmobile. All rights reserved.
//

import Foundation
import UIKit

class BNShowHideAnimator {

    let animationDuration: TimeInterval = 0.4
    let viewHeight: CGFloat
    let parentView: UIView
    let heightConstraint: NSLayoutConstraint
    var oldOffset: CGFloat = 0
    var animating = false
    var viewVisible = true
    
    init(parentView: UIView, heightConstraint layoutConstraint: NSLayoutConstraint, viewHeight: CGFloat? = nil) {
        self.viewHeight = viewHeight ?? layoutConstraint.constant
        self.parentView = parentView
        heightConstraint = layoutConstraint
    }
    
    func hideToolbar(animated: Bool) {
        guard viewVisible else {
            return
        }
        if animating {
            guard animating == false else {
                return
            }
            animating = true
            
            UIView.animate(withDuration: animationDuration, animations: {
                self.heightConstraint.constant = 0
                self.parentView.layoutIfNeeded()
            }, completion: { (value: Bool) in
                self.animating = false
                self.viewVisible = false
            })
        } else {
            self.heightConstraint.constant = 0
            self.parentView.layoutIfNeeded()
            self.animating = false
            self.viewVisible = false
        }
    }
    
    func showToolbar(animated: Bool) {
        guard viewVisible == false else {
            return
        }
        if animated {
            guard animating == false else {
                return
            }
            animating = true
            
            UIView.animate(withDuration: animationDuration, animations: {
                self.heightConstraint.constant = self.viewHeight
                self.parentView.layoutIfNeeded()
            }, completion: { (value: Bool) in
                self.animating = false
                self.viewVisible = true
            })
        } else {
            self.heightConstraint.constant = self.viewHeight
            self.parentView.layoutIfNeeded()
            self.animating = false
            self.viewVisible = true
        }
    }
    
    func showHide(scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        guard currentOffset >= 0 else {
            return
        }
        
        if currentOffset > oldOffset {
            hideToolbar(animated: true)
        } else if currentOffset < oldOffset {
            showToolbar(animated: true)
        }
        oldOffset = currentOffset
    }
    
}
