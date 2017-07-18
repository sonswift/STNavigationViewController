//
//  NormalViewController.swift
//  STNavigationViewController
//
//  Created by Sơn Thái on 7/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import STNavigationViewController

class NormalViewController: ViewController {

  internal let titleLb = UILabel()
  internal let navigation = NavigationBar()

  internal let normalBtn = UIButton()
  internal let normalSegment = UISegmentedControl(items: ["0.23s", "3s", "5s"])

  internal let chainBtn = UIButton()
  internal let chainSegment = UISegmentedControl(items: ["0.23s", "3s", "5s"])

  internal let parallaxBtn = UIButton()
  internal let parallaxSegment = UISegmentedControl(items: ["0.23s", "3s", "5s"])

  private var buttonTag: Int = -1

  override func commonInit() {
    super.commonInit()
    self.contentView.backgroundColor = UIColor.white
  }

  override func loadView() {
    super.loadView()
    let mainBounds = UIScreen.main.bounds

    let buttonMaxWidth: CGFloat = 0.5 * mainBounds.width

    self.titleLb.frame = CGRect(x: mainBounds.midX, y: 80, width: mainBounds.width * 0.5, height: 25)
    self.titleLb.font = UIFont.boldSystemFont(ofSize: 22)
    self.titleLb.textColor = UIColor.black
    self.titleLb.textAlignment = .center
    self.titleLb.text = "Duration"

    self.normalBtn.frame = CGRect(x: 10, y: self.titleLb.frame.maxY + 30, width: buttonMaxWidth - 20, height: 60)
    self.normalBtn.backgroundColor = UIColor.green.withAlphaComponent(0.5)
    self.normalBtn.setTitle("Normal transition \n(Duration: 0.23s)", for: .normal)
    self.normalBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
    self.normalBtn.titleLabel?.textAlignment = .center
    self.normalBtn.titleLabel?.numberOfLines = 2
    self.normalBtn.setTitleColor(UIColor.black, for: .normal)
    self.normalBtn.layer.cornerRadius = 5
    self.normalBtn.clipsToBounds = true
    self.normalBtn.tag = 1
    self.normalBtn.addTarget(self, action: #selector(pushChainViewController), for: .touchUpInside)

    self.normalSegment.frame = CGRect(x: mainBounds.midX, y: self.normalBtn.frame.minY + 10, width: mainBounds.width * 0.5 - 5, height: 40)
    self.normalSegment.selectedSegmentIndex = 0

    self.chainBtn.frame = CGRect(x: 10, y: self.normalBtn.frame.maxY + 20, width: buttonMaxWidth - 20, height: 60)
    self.chainBtn.backgroundColor = UIColor.red.withAlphaComponent(0.5)
    self.chainBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
    self.chainBtn.setTitle("Hide nav transition", for: .normal)
    self.chainBtn.setTitleColor(UIColor.white, for: .normal)
    self.chainBtn.layer.cornerRadius = 5
    self.chainBtn.clipsToBounds = true
    self.chainBtn.tag = 2
    self.chainBtn.addTarget(self, action: #selector(pushHideNavigationViewController), for: .touchUpInside)

    self.chainSegment.frame = CGRect(x: mainBounds.midX, y: self.chainBtn.frame.minY + 10, width: mainBounds.width * 0.5 - 5, height: 40)
    self.chainSegment.selectedSegmentIndex = 0

    self.parallaxBtn.frame = CGRect(x: 10, y: self.chainBtn.frame.maxY + 20, width: buttonMaxWidth - 20, height: 60)
    self.parallaxBtn.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
    self.parallaxBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
    self.parallaxBtn.setTitle("Parallax transition", for: .normal)
    self.parallaxBtn.setTitleColor(UIColor.blue, for: .normal)
    self.parallaxBtn.layer.cornerRadius = 5
    self.parallaxBtn.clipsToBounds = true
    self.parallaxBtn.tag = 3
    self.parallaxBtn.addTarget(self, action: #selector(pushParallaxViewController), for: .touchUpInside)

    self.parallaxSegment.frame = CGRect(x: mainBounds.midX, y: self.parallaxBtn.frame.minY + 10, width: mainBounds.width * 0.5 - 5, height: 40)
    self.parallaxSegment.selectedSegmentIndex = 0

    self.navigation.setTitle("Normal View Controller")
    self.navigationBar = self.navigation

    self.contentView.addSubview(self.titleLb)
    self.contentView.addSubview(self.normalBtn)
    self.contentView.addSubview(self.normalSegment)
    self.contentView.addSubview(self.chainBtn)
    self.contentView.addSubview(self.chainSegment)
    self.contentView.addSubview(self.parallaxBtn)
    self.contentView.addSubview(self.parallaxSegment)
    self.contentView.addSubview(self.navigation)
  }

  public func pushChainViewController() {
    self.buttonTag = self.normalBtn.tag
    let controller = ChainViewController()
    self.navigationController?.pushViewController(controller, animated: true)
  }

  public func pushHideNavigationViewController() {
    self.buttonTag = self.chainBtn.tag
    let controller = HideNavigationViewController()
    self.navigationController?.pushViewController(controller, animated: true)
  }

  public func pushParallaxViewController() {
    self.buttonTag = self.parallaxBtn.tag
    let controller = ParallaxViewController()
    self.navigationController?.pushViewController(controller, animated: true)
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

  override func getPushAnimatedTransitioning(from fromVC: UIViewController,
                                             to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning {
    switch self.buttonTag {
    case 3:
      let animator = ParalaxPushAnimator()
      animator.duration = self.getDuration(from: self.parallaxSegment)
      return animator

    case 2:
      let animator = HideNavigationBarPushAnimator()
      animator.duration = self.getDuration(from: self.chainSegment)
      return animator

    case 1:
      let animator = PushAnimator()
      animator.duration = self.getDuration(from: self.normalSegment)
      return animator

    default:
      return PushAnimator()
    }
  }
}
