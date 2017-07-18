# STNavigationViewController

[![Version](https://img.shields.io/cocoapods/v/STNavigationViewController.svg?style=flat)](http://cocoapods.org/pods/STNavigationViewController)
[![License](https://img.shields.io/cocoapods/l/STNavigationViewController.svg?style=flat)](http://cocoapods.org/pods/STNavigationViewController)
[![Platform](https://img.shields.io/cocoapods/p/STNavigationViewController.svg?style=flat)](http://cocoapods.org/pods/STNavigationViewController)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/sonacle/0.99)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Feature

- [x] Parallax Push/Pop animator.
- [x] Chaining Push/Pop animator (PushAnimator/PopAnimator).
- [x] Allow custom Push/Pop/PopInteraction Animator.
- [x] Custom duration of animation.
- [ ] Support Push Interaction Animator.


## Installation

STNavigationViewController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "STNavigationViewController"
```

## How to use

- Set up STNavigationViewController is rootViewController in `ApplicationDelegate.swift`

```
let window = UIWindow(frame: UIScreen.main.bounds)
self.window = window

let rootViewController = STNavigationViewController(rootViewController: NormalViewController())
window.rootViewController = rootViewController
window.makeKeyAndVisible()
```

- Custom animation when transition between 2 controller. - (See example for more information)

```
override func getPushAnimatedTransitioning(from fromVC: UIViewController,
                                           to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning {
  switch self.buttonTag {
    case 3:
      let animator = ParalaxPushAnimator()
      // Uncomment line below to edit transition duration of animator
      // animator.duration = //<Custom transition animator>
      return animator

    case 2:
      let animator = HideNavigationBarPushAnimator()
      // Uncomment line below to edit transition duration of animator
      // animator.duration = //<Custom transition animator>
      return animator

    case 1:
      let animator = PushAnimator()
      // Uncomment line below to edit transition duration of animator
      // animator.duration = //<Custom transition animator>
      return animator

    default:
      return PushAnimator()
  }
}
```

- Other protocol you can custom in STViewController or STViewController's subclasses

```
func getPushAnimatedTransitioning(from fromVC: UIViewController,
                                  to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning {
  // You can return your new PUSH animtor here
  // Default: return PushAnimator()
  return PushAnimator()
}

func getPopAnimatedTransitioning(from fromVC: UIViewController,
                                 to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning {
  // You can return your new POP animtor here
  // Default: return PopAnimator()
  return PopAnimator()
}

func getPopInteractionAnimatedTransitioning(from fromVC: UIViewController,
                                            to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning {
  // You can return your new INTERACTION animtor here
  // Default: return InteractionPopAnimator()
  return InteractionPopAnimator()
}

```

- Create new animator
```
class CustomPushAnimator: PushAnimator { // OR CustomPopAnimator: PopAnimator
  override func attackSubviews(from fromVC: STViewController,
                               to toVC: STViewController,
                               withContext context: UIViewControllerContextTransitioning) {
    // Set view views in context before animation start
  }

  override func prepareForTransition(from fromVC: STViewController,
                                     to toVC: STViewController,
                                     withContext context: UIViewControllerContextTransitioning) {
    // Set up FromViewController and ToViewController position, alpha, etc...
  }

  override func animatedTransition(from fromVC: STViewController,
                                   to toVC: STViewController,
                                   withContext context: UIViewControllerContextTransitioning) {
    // Animation executing.
    // Add any transition you want STViewController's view to do
  }

  override func completion(from fromVC: STViewController,
                           to toVC: STViewController,
                           withContext context: UIViewControllerContextTransitioning) {
    // Complete animation actions.
  }
}

```


## Author

Son Thai, hoangson11592@gmail.com

## License

STNavigationViewController is available under the MIT license. 

Copyright (c) 2017 Son Thai (hoangson11592@gmail.com).

See the LICENSE file for more info.
