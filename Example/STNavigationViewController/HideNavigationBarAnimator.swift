//
//  CusViewController.swift
//  STNavigationViewController
//
//  Created by Sơn Thái on 7/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import STNavigationViewController

class HideNavigationBarPushAnimator: PushAnimator {

  override func attackSubviews(from fromVC: STViewController,
                               to toVC: STViewController,
                               withContext context: UIViewControllerContextTransitioning) {
    super.attackSubviews(from: fromVC, to: toVC, withContext: context)

    guard let fromVC = fromVC as? ViewController, let toVC = toVC as? ViewController else {
      return
    }
    context.containerView.addSubview(fromVC.navigationBar)
    context.containerView.addSubview(toVC.navigationBar)
  }

  override func prepareForTransition(from fromVC: STViewController,
                                     to toVC: STViewController,
                                     withContext context: UIViewControllerContextTransitioning) {
    super.prepareForTransition(from: fromVC, to: toVC, withContext: context)

    guard let fromVC = fromVC as? ViewController, let toVC = toVC as? ViewController else {
      return
    }

    toVC.navigationBar.alpha = 0.0
    toVC.navigationBar.backgroundView.alpha = 1.0

    fromVC.navigationBar.alpha = 1.0
    fromVC.navigationBar.backgroundView.alpha = 1.0
  }

  override func animatedTransition(from fromVC: STViewController,
                                   to toVC: STViewController,
                                   withContext context: UIViewControllerContextTransitioning) {
    super.animatedTransition(from: fromVC, to: toVC, withContext: context)

    guard let fromVC = fromVC as? ViewController, let toVC = toVC as? ViewController else {
      return
    }
    fromVC.navigationBar.backgroundView.alpha = 0

    toVC.navigationBar.alpha = 1.0
  }

  override func completion(from fromVC: STViewController,
                           to toVC: STViewController,
                           withContext context: UIViewControllerContextTransitioning) {
    super.completion(from: fromVC, to: toVC, withContext: context)

    guard let fromVC = fromVC as? ViewController, let toVC = toVC as? ViewController else {
      return
    }

    fromVC.contentView.addSubview(fromVC.navigationBar)

    toVC.contentView.addSubview(toVC.navigationBar)
  }
}

class HideNavigationBarPopAnimator: PopAnimator {

  override func attackSubviews(from fromVC: STViewController,
                               to toVC: STViewController,
                               withContext context: UIViewControllerContextTransitioning) {
    super.attackSubviews(from: fromVC, to: toVC, withContext: context)

    guard let fromVC = fromVC as? ViewController, let toVC = toVC as? ViewController else {
      return
    }

    context.containerView.addSubview(toVC.navigationBar)
    context.containerView.addSubview(fromVC.navigationBar)
  }

  override func prepareForTransition(from fromVC: STViewController,
                                     to toVC: STViewController,
                                     withContext context: UIViewControllerContextTransitioning) {
    super.prepareForTransition(from: fromVC, to: toVC, withContext: context)

    guard let fromVC = fromVC as? ViewController, let toVC = toVC as? ViewController else {
      return
    }

    toVC.navigationBar.alpha = 1.0
    toVC.navigationBar.backgroundView.alpha = 0.0

    fromVC.navigationBar.alpha = 1.0
    fromVC.navigationBar.backgroundView.alpha = 1.0
  }

  override func animatedTransition(from fromVC: STViewController,
                                   to toVC: STViewController,
                                   withContext context: UIViewControllerContextTransitioning) {
    super.animatedTransition(from: fromVC, to: toVC, withContext: context)

    guard let fromVC = fromVC as? ViewController, let toVC = toVC as? ViewController else {
      return
    }

    toVC.navigationBar.backgroundView.alpha = 1.0

    fromVC.navigationBar.alpha = 0.0
  }

  override func completion(from fromVC: STViewController,
                           to toVC: STViewController,
                           withContext context: UIViewControllerContextTransitioning) {
    super.completion(from: fromVC, to: toVC, withContext: context)

    guard let fromVC = fromVC as? ViewController, let toVC = toVC as? ViewController else {
      return
    }

    toVC.contentView.addSubview(toVC.navigationBar)

    fromVC.contentView.addSubview(fromVC.navigationBar)

  }
}
