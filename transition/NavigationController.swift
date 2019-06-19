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

    // Push: From -> To / Pop: From <- To それぞれのペアを定義する
    private var classPairs: [(from: AnyClass, to: AnyClass)] {
        return [
            (from: MasterViewController.self, to: DetailViewController.self),
            (from: DetailViewController.self, to: MasterViewController.self),
        ]
    }

    private func isTargetViewControllerPair(from: UIViewController, to: UIViewController) -> Bool {
        for pair in classPairs {
            if from.classForCoder == pair.from && to.classForCoder == pair.to {
                return true
            }
        }

        return false
    }
}

extension NavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if isTargetViewControllerPair(from: fromVC, to: toVC) {
            return SimilarGoodsSheetAnimator(operation)
        }

        return nil
    }
}
