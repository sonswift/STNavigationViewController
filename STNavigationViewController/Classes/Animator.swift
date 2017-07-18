//
//  Animator.swift
//  STNavigationViewController
//
//  Created by Sơn Thái on 7/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

open class Animator: NSObject, UIViewControllerAnimatedTransitioning {

  open static let transitionDuration: TimeInterval = 0.23

  open func getMinimumAlpha(using context: UIViewControllerContextTransitioning?) -> CGFloat {
    return 0.3
  }

  open func getMaximumAlpha(using context: UIViewControllerContextTransitioning?) -> CGFloat {
    return 1.0
  }

  open func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0
  }

  open func animateTransition(using context: UIViewControllerContextTransitioning) {
    guard let fromVC = context.viewController(forKey: .from) as? STViewController,
      let toVC = context.viewController(forKey: .to) as? STViewController else {
        return
    }

    self.attackSubviews(from: fromVC, to: toVC, withContext: context)
    self.prepareForTransition(from: fromVC, to: toVC, withContext: context)
    UIView.animate(withDuration: self.transitionDuration(using: context), animations: {
      self.animatedTransition(from: fromVC, to: toVC, withContext: context)
    }) { (_) in
      self.completion(from: fromVC, to: toVC, withContext: context)
      context.completeTransition(!context.transitionWasCancelled)
    }
  }

  open func attackSubviews(from fromVC: STViewController,
                           to toVC: STViewController,
                           withContext context: UIViewControllerContextTransitioning) {
    context.containerView.addSubview(toVC.view)
  }

  open func prepareForTransition(from fromVC: STViewController,
                                 to toVC: STViewController,
                                 withContext context: UIViewControllerContextTransitioning) {}

  open func animatedTransition(from fromVC: STViewController,
                               to toVC: STViewController,
                               withContext context: UIViewControllerContextTransitioning) {}

  open func completion(from fromVC: STViewController,
                       to toVC: STViewController,
                       withContext context: UIViewControllerContextTransitioning) {}
}
