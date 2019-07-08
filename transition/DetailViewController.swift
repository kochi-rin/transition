//
//  DetailViewController.swift
//  transition
//
//  Created by kouchi.rin on 2019/06/18.
//  Copyright © 2019 kouchi.rin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var image: UIImage?
    var imageView: UIImageView!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: -500), size: CGSize(width: UIScreen.main.bounds.size.width, height: 500)))
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        imageView.addMask(rect: CGRect(origin: CGPoint(x: 100, y: 200), size: CGSize(width: 300, height: 300)))

        tableView.addSubview(imageView)
        tableView.contentInset.top = 500 - UIApplication.shared.statusBarFrame.height
    }

//    override var prefersStatusBarHidden: Bool {
//        return true
//    }

    func tappedClose(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController: CoverVerticalWithFadeByPushAnimatorProtocol {
    var animateBackgroundView: UIView? {
        return view
    }

    var animateView: UIView? {
        return tableView
    }
}
