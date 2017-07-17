//
//  ParalaxAnimator.swift
//  STNavigationViewController
//
//  Created by Sơn Thái on 7/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class ParalaxPushAnimator: PushAnimator {
  override func attackSubviews(from fromVC: STViewController,
                               to toVC: STViewController,
                               withContext context: UIViewControllerContextTransitioning) {
    context.containerView.addSubview(toVC.view)
  }

  override func prepareForTransition(from fromVC: STViewController,
                                     to toVC: STViewController,
                                     withContext context: UIViewControllerContextTransitioning) {
    fromVC.view.frame.origin.x = 0

    toVC.view.frame.origin.x = UIScreen.main.bounds.width
  }

  override func animatedTransition(from fromVC: STViewController,
                                   to toVC: STViewController,
                                   withContext context: UIViewControllerContextTransitioning) {
    fromVC.view.frame.origin.x = -UIScreen.main.bounds.width * 0.3

    toVC.view.frame.origin.x = 0
  }

  override func completion(from fromVC: STViewController,
                           to toVC: STViewController,
                           withContext context: UIViewControllerContextTransitioning) {
  }
}

class ParalaxPopAnimator: PushAnimator {
  override func attackSubviews(from fromVC: STViewController,
                               to toVC: STViewController,
                               withContext context: UIViewControllerContextTransitioning) {
    context.containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
  }

  override func prepareForTransition(from fromVC: STViewController,
                                     to toVC: STViewController,
                                     withContext context: UIViewControllerContextTransitioning) {
    fromVC.view.frame.origin.x = 0

    toVC.view.frame.origin.x = -UIScreen.main.bounds.width * 0.3
  }

  override func animatedTransition(from fromVC: STViewController,
                                   to toVC: STViewController,
                                   withContext context: UIViewControllerContextTransitioning) {
    fromVC.view.frame.origin.x = UIScreen.main.bounds.width

    toVC.view.frame.origin.x = 0
  }

  override func completion(from fromVC: STViewController,
                           to toVC: STViewController,
                           withContext context: UIViewControllerContextTransitioning) {
  }
}
