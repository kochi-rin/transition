//
//  SheetWithHeaderAnimator.swift
//  transition
//
//  Created by kouchi.rin on 2019/06/18.
//  Copyright © 2019 kouchi.rin. All rights reserved.
//

import UIKit

class SheetWithHeaderAnimator: NSObject {
    let kAnimationDuration: TimeInterval = 0.5

    var navigationOperation: UINavigationController.Operation = .none

    convenience init(_ navigationOperation: UINavigationController.Operation) {
        self.init()
        self.navigationOperation = navigationOperation
    }

    private func customAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let from = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from), let to = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }

        let containerView = transitionContext.containerView

        containerView.insertSubview(to.view, belowSubview: from.view)

        // add screen shot which from is master
        if navigationOperation == UINavigationController.Operation.push {
            to.view.insertSubview(UIImageView(image: from.view.capture()), at: 0)
        }

        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       options: UIView.AnimationOptions.init(rawValue: 0),
                       animations: {
                        from.view.alpha = 0.0
        },
                       completion: { _ in
                        from.view.alpha = 1.0
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

extension SheetWithHeaderAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return kAnimationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        customAnimation(transitionContext)
    }
}
