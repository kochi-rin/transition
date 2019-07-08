//
//  SheetWithHeaderAnimator.swift
//  transition
//
//  Created by kouchi.rin on 2019/06/18.
//  Copyright © 2019 kouchi.rin. All rights reserved.
//

import UIKit

protocol CoverVerticalWithFadeByPushAnimatorProtocol: NSObjectProtocol {
    var animateBackgroundView: UIView? { get }
    var animateView: UIView? { get }
}

class CoverVerticalWithFadeByPushAnimator: NSObject {
    let kAnimationDuration: TimeInterval = 0.5

    var navigationOperation: UINavigationController.Operation = .none

    convenience init?(_ navigationOperation: UINavigationController.Operation, fromVC: UIViewController, toVC: UIViewController) {
        self.init()
        self.navigationOperation = navigationOperation

        if !(navigationOperation == .push && toVC is CoverVerticalWithFadeByPushAnimatorProtocol)
            && !(navigationOperation == .pop && fromVC is CoverVerticalWithFadeByPushAnimatorProtocol) {

            return nil
        }
    }

    private func customAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from), let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }

        let containerView = transitionContext.containerView

        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)

        switch navigationOperation {
        case .none:
            break
        case .push:
            if let animator = toVC as? CoverVerticalWithFadeByPushAnimatorProtocol,
                let backgroundView = animator.animateBackgroundView,
                let contentView = animator.animateView {
                // insert capture of fromVC's view to toVC to pretense over current context
                backgroundView.insertSubview(UIImageView(image: fromVC.view.capture()), at: 0)

                contentView.transform = CGAffineTransform(translationX: 0, y: transitionContext.containerView.bounds.height - contentView.frame.minY)
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)

                UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                    contentView.transform = .identity
                }, completion: nil)
            }
        case .pop:
            if let animator = fromVC as? CoverVerticalWithFadeByPushAnimatorProtocol,
                let contentView = animator.animateView {
                UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                    contentView.transform = CGAffineTransform(translationX: 0, y: transitionContext.containerView.bounds.height - contentView.frame.minY)
                }, completion: { _ in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
            }
        @unknown default:
            break
        }
    }
}

extension CoverVerticalWithFadeByPushAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return kAnimationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        customAnimation(transitionContext)
    }
}
