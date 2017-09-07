//
//  NavigationBar.swift
//  STNavigationViewController
//
//  Created by Sơn Thái on 7/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class NavigationBar: UIView {

  internal let backgroundView = UIView()
  internal let contentView = UIView()
  internal let titleLb = UILabel()
  internal let backBtn = UIButton()

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  init() {
    super.init(frame: CGRect.zero)
    self.commonInit()
    self.initView()
  }

  func commonInit() {
  }

  func initView() {
    self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
    self.backgroundColor = UIColor.white

    self.backgroundView.frame = self.bounds
    self.backgroundView.backgroundColor = UIColor.white
    self.backgroundView.layer.shadowColor = UIColor.black.cgColor
    self.backgroundView.layer.shadowOffset = CGSize(width: 0, height: 1.5)
    self.backgroundView.layer.shadowOpacity = 0.15

    self.contentView.frame = self.bounds
    self.contentView.backgroundColor = UIColor.white

    self.titleLb.frame = CGRect(x: 50, y: 20, width: UIScreen.main.bounds.width - 100, height: 40)
    self.titleLb.textColor = UIColor.black
    self.titleLb.textAlignment = .center

    self.backBtn.frame = CGRect(x: 0, y: 10, width: 40, height: 60)
    self.backBtn.setImage(UIImage(named: "back"), for: .normal)
    self.backBtn.isHidden = true
    self.backBtn.addTarget(self, action: #selector(popViewController), for: .touchUpInside)

    self.addSubview(self.backgroundView)
    self.addSubview(self.contentView)
    self.contentView.addSubview(self.titleLb)
    self.contentView.addSubview(self.backBtn)
  }

  public func setTitle(_ title: String) {
    self.titleLb.text = title
  }

  @objc public func popViewController() {
    (UIApplication.shared.delegate?.window!?.rootViewController as? UINavigationController)?.popViewController(animated: true)
  }

  deinit {
  }
}
