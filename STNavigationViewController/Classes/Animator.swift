//
//  Animator.swift
//  STNavigationViewController
//
//  Created by Sơn Thái on 7/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {

  static let transitionDuration: TimeInterval = 0.23

  internal func getMinimumAlpha(using context: UIViewControllerContextTransitioning?) -> CGFloat {
    return 0.3
  }

  internal func getMaximumAlpha(using context: UIViewControllerContextTransitioning?) -> CGFloat {
    return 1.0
  }

  internal func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0
  }

  internal func animateTransition(using context: UIViewControllerContextTransitioning) {
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

  internal func attackSubviews(from fromVC: STViewController,
                               to toVC: STViewController,
                               withContext context: UIViewControllerContextTransitioning) {
    context.containerView.addSubview(toVC.view)
  }

  internal func prepareForTransition(from fromVC: STViewController,
                                     to toVC: STViewController,
                                     withContext context: UIViewControllerContextTransitioning) {}

  internal func animatedTransition(from fromVC: STViewController,
                                   to toVC: STViewController,
                                   withContext context: UIViewControllerContextTransitioning) {}

  internal func completion(from fromVC: STViewController,
                           to toVC: STViewController,
                           withContext context: UIViewControllerContextTransitioning) {}
}
