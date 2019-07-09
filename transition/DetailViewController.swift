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

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        imageView.image = image
        imageView.addMask(rect: CGRect(origin: CGPoint(x: 100, y: 200), size: CGSize(width: 300, height: 300)))

        tableView.contentInset.top = 500
//        tableView.contentInset.bottom = UIApplication.shared.statusBarFrame.height + view.safeAreaInsets.bottom
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    func tappedClose(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath)
        cell.textLabel?.text = "Item\(indexPath.row)"

        return cell
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SampleHeaderView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 200, height: 50)))
        view.didTouchUpInside = { button in
            self.tappedClose(button)
        }
        return view
    }
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -100 {
            print(min(500, abs(scrollView.contentOffset.y)))
            tableView.contentInset.top = min(500, abs(scrollView.contentOffset.y))
        }
    }
}

extension DetailViewController: CoverVerticalWithFadeByPushAnimatorProtocol {
    var animateView: UIView? {
        return imageView
    }
}
