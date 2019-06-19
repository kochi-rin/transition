//
//  NavigationController.swift
//  transition
//
//  Created by kouchi.rin on 2019/06/18.
//  Copyright © 2019 kouchi.rin. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        delegate = self
    }
}

extension NavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let animator = CoverVerticalWithFadeByPushAnimator(operation, fromVC: fromVC, toVC: toVC) {
            return animator
        }

        return nil
    }
}
