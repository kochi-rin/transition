//
//  UIView+isShowing.swift
//  zozo
//
//  Created by kenichi.nakamoto on 2017/04/20.
//  Copyright © 2017年 START TODAY Engineering CO.,LTD. All rights reserved.
//

import UIKit

extension UIView {

    var hitTest: Bool {
        if let window = UIApplication.shared.delegate?.window as? UIWindow {
            return window.hitTest(convert(CGPoint.zero, to: window), with: nil) == self
        } else {
            return false
        }
    }

    @objc func capture(renderBefore: ((_ view: UIView) -> Void)? = nil, renderAfter: ((_ view: UIView) -> Void)? = nil) -> UIImage? {
        renderBefore?(self)

        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)

        var image: UIImage?
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }

        UIGraphicsEndImageContext()

        renderAfter?(self)

        return image
    }

}
