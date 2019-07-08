//
//  SheetWithHeaderAnimator.swift
//  transition
//
//  Created by kouchi.rin on 2019/06/18.
//  Copyright © 2019 kouchi.rin. All rights reserved.
//

import UIKit

protocol CoverVerticalWithFadeByPushAnimatorProtocol: NSObjectProtocol {
    var animateView: UIView? { get }
    var originViewPosition: CGPoint? { get }
}

extension CoverVerticalWithFadeByPushAnimatorProtocol {
    var animateView: UIView? {
        get { return nil }
    }

    var originViewPosition: CGPoint? {
        get { return nil }
    }
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
            if let fromAnimator = fromVC as? CoverVerticalWithFadeByPushAnimatorProtocol,
                let fromPosition = fromAnimator.originViewPosition,
                let toAnimator = toVC as? CoverVerticalWithFadeByPushAnimatorProtocol,
                let toView = toAnimator.animateView {
                toView.transform = CGAffineTransform(translationX: 0, y: fromPosition.y)
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)

                UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                    toView.transform = .identity
                }, completion: nil)
            } else {
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        case .pop:
            if let fromAnimator = fromVC as? CoverVerticalWithFadeByPushAnimatorProtocol,
                let fromView = fromAnimator.animateView,
                let toAnimator = toVC as? CoverVerticalWithFadeByPushAnimatorProtocol,
                let toPosition = toAnimator.originViewPosition {
                UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                    fromView.transform = CGAffineTransform(translationX: 0, y: toPosition.y)
                }, completion: { _ in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
            } else {
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
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
