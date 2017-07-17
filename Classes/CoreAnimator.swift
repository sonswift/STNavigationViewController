//
//  CoreAnimatorViewController.swift
//  STNavigationViewController
//
//  Created by Sơn Thái on 7/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class PushAnimator: Animator {

  var duration: TimeInterval = 0.23

  override func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
    return self.duration
  }

  override func attackSubviews(from fromVC: STViewController,
                               to toVC: STViewController,
                               withContext context: UIViewControllerContextTransitioning) {
    context.containerView.addSubview(toVC.view)
  }

  override func prepareForTransition(from fromVC: STViewController,
                                     to toVC: STViewController,
                                     withContext context: UIViewControllerContextTransitioning) {
    toVC.view.frame.origin.x = UIScreen.main.bounds.width
    toVC.contentView.alpha = self.getMinimumAlpha(using: context)

    fromVC.view.frame.origin.x = 0
    fromVC.contentView.alpha = 1.0
  }

  override func animatedTransition(from fromVC: STViewController,
                                   to toVC: STViewController,
                                   withContext context: UIViewControllerContextTransitioning) {
    fromVC.view.frame.origin.x = -UIScreen.main.bounds.width
    fromVC.contentView.alpha = self.getMinimumAlpha(using: context)

    toVC.view.frame.origin.x = 0.0
    toVC.contentView.alpha = self.getMaximumAlpha(using: context)
  }
}

class PopAnimator: Animator {

  var duration: TimeInterval = 0.23

  override func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
    return Animator.transitionDuration
  }

  override func attackSubviews(from fromVC: STViewController,
                               to toVC: STViewController,
                               withContext context: UIViewControllerContextTransitioning) {
    context.containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
  }

  override func prepareForTransition(from fromVC: STViewController,
                                     to toVC: STViewController,
                                     withContext context: UIViewControllerContextTransitioning) {
    toVC.view.frame.origin.x = -UIScreen.main.bounds.width
    toVC.contentView.alpha = self.getMinimumAlpha(using: context)
  }

  override func animatedTransition(from fromVC: STViewController,
                                   to toVC: STViewController,
                                   withContext context: UIViewControllerContextTransitioning) {
    toVC.view.frame.origin.x = 0
    toVC.contentView.alpha = self.getMaximumAlpha(using: context)

    fromVC.view.frame.origin.x = UIScreen.main.bounds.width
    fromVC.contentView.alpha = self.getMinimumAlpha(using: context)
  }

  override func completion(from fromVC: STViewController,
                           to toVC: STViewController,
                           withContext context: UIViewControllerContextTransitioning) {}
}

class InteractionPopAnimator: PopAnimator {
  // Custom animation if need a different interaction for pop pan gesture.
}
