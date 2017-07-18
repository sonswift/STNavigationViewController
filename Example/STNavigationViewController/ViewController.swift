//
//  ViewController.swift
//  STNavigationViewController
//
//  Created by son11592 on 07/17/2017.
//  Copyright (c) 2017 son11592. All rights reserved.
//

import UIKit
import STNavigationViewController

class ViewController: STViewController {

  internal var navigationBar: NavigationBar!

  override func commonInit() {
    super.commonInit()
    self.contentView.backgroundColor = UIColor.white
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    self.setupNavigation()
  }

  override func getPushAnimatedTransitioning(from fromVC: UIViewController,
                                             to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning {
    return PushAnimator()
  }

  override func getPopAnimatedTransitioning(from fromVC: UIViewController,
                                            to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning {
    return PopAnimator()
  }

  override func getPopInteractionAnimatedTransitioning(from fromVC: UIViewController,
                                                       to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning {
    return PopAnimator()
  }

  private func setupNavigation() {
    guard let navigationController = UIApplication.shared.delegate?.window!?.rootViewController as? UINavigationController else {
      return
    }

    self.navigationBar.backBtn.isHidden = navigationController.viewControllers.count < 2
  }
}
