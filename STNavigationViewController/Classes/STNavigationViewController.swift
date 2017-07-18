//
//  STNavigationViewController.swift
//  STNavigationViewController
//
//  Created by Sơn Thái on 7/17/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

open class STNavigationViewController: UINavigationController {

  // MARK: - Static properites
  open static var isPanGestureEnabling = false

  // MARK: - Internal properties
  open var isPushInteractionEnabled = false

  // MARK: - Private properties
  fileprivate var isPushingViewController = false
  private var leftGesture: UIPanGestureRecognizer?

  // MARK: - Initiation
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override public init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
  }

  override public init(nibName: String?, bundle: Bundle?) {
    super.init(nibName: nibName, bundle: bundle)
    self.commonInit()
  }

  override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
    isPushingViewController = true
    super.pushViewController(viewController, animated: animated)
  }

  override open func viewDidLoad() {
    super.viewDidLoad()

    let left = UIPanGestureRecognizer(target: self, action: #selector(handleSwipeFromLeft(_:)))
    left.delegate = self
    left.cancelsTouchesInView = false
    left.delaysTouchesBegan = false
    left.delaysTouchesEnded = false
    self.view.addGestureRecognizer(left)
    self.leftGesture = left

    if self.isPushInteractionEnabled {
      let right = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleSwipeFromRight(_:)))
      right.edges = .right
      right.cancelsTouchesInView = false
      right.delaysTouchesBegan = false
      right.delaysTouchesEnded = false
      self.view.addGestureRecognizer(right)
    }
  }

  open func commonInit() {
    self.delegate = self
    self.transitioningDelegate = self
    self.navigationBar.isHidden = true
    self.interactivePopGestureRecognizer?.isEnabled = false
  }

  fileprivate var interactionController: UIPercentDrivenInteractiveTransition?

  public func handleSwipeFromLeft(_ gesture: UIScreenEdgePanGestureRecognizer) {
    let percent = gesture.translation(in: gesture.view!).x / gesture.view!.bounds.size.width

    if gesture.state == .began {
      interactionController = UIPercentDrivenInteractiveTransition()
      if viewControllers.count > 1 {
        STNavigationViewController.isPanGestureEnabling = true
        popViewController(animated: true)
      } else {
        dismiss(animated: true)
      }
    } else if gesture.state == .changed {
      interactionController?.update(percent)
    } else if gesture.state == .ended {
      if percent > 0.2 && gesture.state != .cancelled {
        interactionController?.finish()
      } else {
        interactionController?.cancel()
      }
      interactionController = nil

      // Unlock pan gesture state
      let delayTimeDispatch = DispatchTime.now() + Double(0.23)
      DispatchQueue.main.asyncAfter(deadline: delayTimeDispatch) {
        STNavigationViewController.isPanGestureEnabling = false
      }
    }
  }

  public func handleSwipeFromRight(_ gesture: UIScreenEdgePanGestureRecognizer) {
    let percent = -gesture.translation(in: gesture.view!).x / gesture.view!.bounds.size.width

    if gesture.state == .began {
      guard let currentViewController = viewControllers.last as? STViewController else {
        return
      }
      interactionController = UIPercentDrivenInteractiveTransition()
      currentViewController.pushInteractionController()
    } else if gesture.state == .changed {
      interactionController?.update(percent)
    } else if gesture.state == .ended {
      if percent > 0.5 {
        interactionController?.finish()
      } else {
        interactionController?.cancel()
      }
      interactionController = nil
    }
  }

  public func lockLeftInteractionGesture(_ isLocked: Bool) {
    self.leftGesture?.isEnabled = !isLocked
  }
}

extension STNavigationViewController: UINavigationControllerDelegate {
  public func navigationController(_ navigationController: UINavigationController,
                            animationControllerFor operation: UINavigationControllerOperation,
                            from fromVC: UIViewController,
                            to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    guard interactionController == nil else {
      return (fromVC as? STViewController)?.getPopInteractionAnimatedTransitioning(from: fromVC, to: toVC)
    }
    if operation == UINavigationControllerOperation.push {
      return (fromVC as? STViewController)?.getPushAnimatedTransitioning(from: fromVC, to: toVC)
    } else if operation == UINavigationControllerOperation.pop {
      return (fromVC as? STViewController)?.getPopAnimatedTransitioning(from: fromVC, to: toVC)
    }

    return nil
  }

  public func navigationController(_ navigationController: UINavigationController,
                            didShow viewController: UIViewController,
                            animated: Bool) {
    isPushingViewController = false
  }

  public func navigationController(_ navigationController: UINavigationController,
                            interactionControllerFor animationController: UIViewControllerAnimatedTransitioning)
    -> UIViewControllerInteractiveTransitioning? {
      return interactionController
  }
}

extension STNavigationViewController: UIViewControllerTransitioningDelegate {

  public func animationController(forPresented presented: UIViewController,
                           presenting: UIViewController,
                           source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return (source as? STViewController)?.getPushAnimatedTransitioning(from: source, to: presenting)
  }

  public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return (dismissed as? STViewController)?.getPopAnimatedTransitioning(from: STViewController(), to: dismissed)
  }

  public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning)
    -> UIViewControllerInteractiveTransitioning? {
      return interactionController
  }

  public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning)
    -> UIViewControllerInteractiveTransitioning? {
      return interactionController
  }

  public func presentationController(forPresented presented: UIViewController,
                              presenting: UIViewController?,
                              source: UIViewController) -> UIPresentationController? {
    return PresentationController(presentedViewController: presented, presenting: presenting)
  }

}

extension STNavigationViewController: UIGestureRecognizerDelegate {
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    guard gestureRecognizer is UIScreenEdgePanGestureRecognizer else { return true }
    return viewControllers.count > 1 && !isPushingViewController
  }
}

class PresentationController: UIPresentationController {
  override var shouldRemovePresentersView: Bool { return true }
}
