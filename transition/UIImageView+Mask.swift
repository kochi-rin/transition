//
//  UIImageView+Mask.swift
//  zozo
//
//  Created by kouchi.rin on 2019/06/13.
//  Copyright © 2019 ZOZO Technologies, Inc. All rights reserved.
//

import UIKit

extension UIImageView {
    struct maskDefaut {
        static let radius: CGFloat = 5.0
    }

    func addMask(rect: CGRect) {
        guard let image = image else {
            return
        }

        DispatchQueue.global(qos: .userInteractive).async {
            let maskedImage = image.maskWithColor(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5))?.transparent(rect: rect, radius: maskDefaut.radius)

            DispatchQueue.main.async {
                let maskedImageView = UIImageView(image: maskedImage)
                maskedImageView.contentMode = self.contentMode
                maskedImageView.translatesAutoresizingMaskIntoConstraints = false

                self.addSubview(maskedImageView)

                let views = ["maskedImageView" : maskedImageView]
                let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[maskedImageView]|", options: [], metrics: nil, views: views)
                let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[maskedImageView]|", options: [], metrics: nil, views: views)

                self.addConstraints(horizontalConstraints + verticalConstraints)
            }
        }
    }
}
