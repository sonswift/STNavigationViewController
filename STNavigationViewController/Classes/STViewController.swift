//
//  STViewController.swift
//  STNavigationViewController
//
//  Created by Sơn Thái on 7/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

public protocol ViewControllerAnimatedTransitioningProtocol {
  func getPushAnimatedTransitioning(from fromVC: UIViewController,
                                    to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning
  func getPopAnimatedTransitioning(from fromVC: UIViewController,
                                   to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning
  func getPopInteractionAnimatedTransitioning(from fromVC: UIViewController,
                                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning
  func pushInteractionController()
}

open class STViewController: UIViewController {

  open let contentView = UIView()

  convenience public init() {
    self.init(nibName: nil, bundle: nil)
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override public init(nibName: String?, bundle: Bundle?) {
    super.init(nibName: nibName, bundle: bundle)
    self.commonInit()
  }

  override open func didReceiveMemoryWarning() {
    print("Got memory warning!!!")
  }

  override open func loadView() {
    super.loadView()
  }

  override open func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  open func commonInit() {
    self.automaticallyAdjustsScrollViewInsets = false
    self.contentView.frame = self.view.bounds
    self.contentView.backgroundColor = UIColor.white
    self.view.backgroundColor = UIColor.white
    self.view.addSubview(self.contentView)
  }
}

extension STViewController: ViewControllerAnimatedTransitioningProtocol {
  open func getPushAnimatedTransitioning(from fromVC: UIViewController,
                                         to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning {
    return PushAnimator()
  }

  open func getPopAnimatedTransitioning(from fromVC: UIViewController,
                                        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning {
    return PopAnimator()
  }

  open func getPopInteractionAnimatedTransitioning(from fromVC: UIViewController,
                                                   to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning {
    return InteractionPopAnimator()
  }

  open func pushInteractionController() {
  }
}
