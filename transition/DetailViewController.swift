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
    @IBOutlet weak var collecitonView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        imageView.image = image
        imageView.addMask(rect: CGRect(origin: CGPoint(x: 100, y: 200), size: CGSize(width: 300, height: 300)))

        collecitonView.contentInset.top = 400
        guard let fl = collecitonView?.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        fl.sectionHeadersPinToVisibleBounds = true
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    func tappedClose(_ sender: Any) {
        imageView.deleteMask()
        collecitonView.isHidden = true
        navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath) as? SampleHeaderView else {
            fatalError("Could not find proper header")
        }

        if kind == UICollectionView.elementKindSectionHeader {
            return header
        }

        return UICollectionReusableView()
    }
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            collecitonView.contentInset.top = min(400, abs(scrollView.contentOffset.y))
        } else {
            collecitonView.contentInset.top = 0
        }
    }
}

extension DetailViewController: CoverVerticalWithFadeByPushAnimatorProtocol {
    var animateView: UIView? {
        return imageView
    }
}
