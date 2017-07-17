//
//  ChainViewController.swift
//  STNavigationViewController
//
//  Created by Sơn Thái on 7/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class ChainViewController: ViewController {

  internal let navigation = NavigationBar()
  internal let titleLb = UILabel()
  internal let segment = UISegmentedControl(items: ["0.23s", "3s", "5s"])

  override func commonInit() {
    super.commonInit()
    self.contentView.backgroundColor = UIColor.green.withAlphaComponent(0.5)
  }

  override func loadView() {
    super.loadView()
    let mainBounds = UIScreen.main.bounds

    self.navigation.setTitle("Chain View Controller")
    self.navigationBar = self.navigation

    self.titleLb.frame = CGRect(x: 15, y: 90, width: mainBounds.width - 30, height: 25)
    self.titleLb.textColor = UIColor.black
    self.titleLb.textAlignment = .center
    self.titleLb.text = "Select duration for pop animation"

    self.segment.frame = CGRect(x: 40, y: self.titleLb.frame.maxY + 20, width: mainBounds.width - 80, height: 40)
    self.segment.selectedSegmentIndex = 0

    self.contentView.addSubview(self.titleLb)
    self.contentView.addSubview(self.segment)
    self.contentView.addSubview(self.navigation)
  }

  override func getPopAnimatedTransitioning(from fromVC: UIViewController,
                                            to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning {
    let animator = PopAnimator()
    animator.duration = self.getDuration(from: self.segment)
    return animator
  }

  override func getPopInteractionAnimatedTransitioning(from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning {
    return PopAnimator()
  }

  private func getDuration(from segment: UISegmentedControl) -> TimeInterval {
    switch segment.selectedSegmentIndex {
    case 1:
      return 3
    case 2:
      return 5
    default:
      return 0.23
    }
  }
}
