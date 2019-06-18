//
//  UIImage+Mask.swift
//  imageMask
//
//  Created by kouchi.rin on 2019/06/13.
//  Copyright © 2019 kouchi.rin. All rights reserved.
//

import UIKit

extension UIImage {
    func blurredImage() -> UIImage? {
        // 背景画像のblur画像の作成
        var imageRef: CGImage?
        let baseCIImage = CIImage(image: self)
        let ciContext = CIContext(options: nil)

        if let filter = CIFilter(name: "CIGaussianBlur") {
            // フィルタの設定
            filter.setValue(baseCIImage, forKey: kCIInputImageKey)
            filter.setValue(NSNumber(value: 2.0), forKey: kCIInputRadiusKey)
            imageRef = ciContext.createCGImage((filter.outputImage)!,
                                               from: (filter.outputImage!.extent))
            // blur処理後の画像には余白ができてしまうのでトリミングする
            let cgSize = self.size
            let x = (CGFloat(imageRef!.width) - cgSize.width * self.scale) / 2
            let y = (CGFloat(imageRef!.height) - cgSize.height * self.scale) / 2
            let rect = CGRect(x: x,
                              y: y,
                              width: cgSize.width * self.scale,
                              height: cgSize.height * self.scale)
            imageRef = imageRef!.cropping(to: rect)

            return UIImage(cgImage: imageRef!)
        } else {
            return nil
        }
    }

    func maskWithColor(color: UIColor) -> UIImage? {
        var maskImage: CGImage?
        let baseCIImage = CIImage(image: self)
        let ciContext = CIContext(options: nil)

        if let blackGenerator = CIFilter(name: "CIConstantColorGenerator") {
            blackGenerator.setValue(CIColor(cgColor: color.cgColor), forKey: "inputColor")
            let blackImage = blackGenerator.outputImage

            if let compositeFilter = CIFilter(name: "CIOverlayBlendMode") {
                compositeFilter.setValue(blackImage, forKey: "inputImage")
                compositeFilter.setValue(baseCIImage, forKey: "inputBackgroundImage")

                maskImage = ciContext.createCGImage((compositeFilter.outputImage)!,
                                                    from: (baseCIImage!.extent))

                return UIImage(cgImage: maskImage!)
            }
        }

        return nil
    }

    func transparent(rect: CGRect, radius: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContext(self.size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let path = UIBezierPath(roundedRect: rect, cornerRadius: radius)
        self.draw(at: CGPoint.zero)
        context.addPath(path.cgPath)
        context.clip()
        context.clear(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
