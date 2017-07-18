//
//  ParalaxAnimator.swift
//  STNavigationViewController
//
//  Created by Sơn Thái on 7/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

open class ParalaxPushAnimator: PushAnimator {
  override open func attackSubviews(from fromVC: STViewController,
                                    to toVC: STViewController,
                                    withContext context: UIViewControllerContextTransitioning) {
    context.containerView.addSubview(toVC.view)
  }

  override open func prepareForTransition(from fromVC: STViewController,
                                          to toVC: STViewController,
                                          withContext context: UIViewControllerContextTransitioning) {
    fromVC.view.frame.origin.x = 0

    toVC.view.frame.origin.x = UIScreen.main.bounds.width
  }

  override open func animatedTransition(from fromVC: STViewController,
                                        to toVC: STViewController,
                                        withContext context: UIViewControllerContextTransitioning) {
    fromVC.view.frame.origin.x = -UIScreen.main.bounds.width * 0.3

    toVC.view.frame.origin.x = 0
  }

  override open func completion(from fromVC: STViewController,
                                to toVC: STViewController,
                                withContext context: UIViewControllerContextTransitioning) {
  }
}

open class ParalaxPopAnimator: PushAnimator {
  override open func attackSubviews(from fromVC: STViewController,
                                    to toVC: STViewController,
                                    withContext context: UIViewControllerContextTransitioning) {
    context.containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
  }

  override open func prepareForTransition(from fromVC: STViewController,
                                          to toVC: STViewController,
                                          withContext context: UIViewControllerContextTransitioning) {
    fromVC.view.frame.origin.x = 0

    toVC.view.frame.origin.x = -UIScreen.main.bounds.width * 0.3
  }

  override open func animatedTransition(from fromVC: STViewController,
                                        to toVC: STViewController,
                                        withContext context: UIViewControllerContextTransitioning) {
    fromVC.view.frame.origin.x = UIScreen.main.bounds.width

    toVC.view.frame.origin.x = 0
  }

  override open func completion(from fromVC: STViewController,
                                to toVC: STViewController,
                                withContext context: UIViewControllerContextTransitioning) {
  }
}
