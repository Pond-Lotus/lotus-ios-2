//
//  Extensions.swift
//  TODORI
//
//  Created by Dasol on 2023/05/17.
//

import UIKit

extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension UIImage {
    var circleMasked: UIImage? {
        // 이미지의 크기를 가져옵니다.
        let imageRect = CGRect(origin: .zero, size: size)

        // 새로운 그래픽 컨텍스트를 만듭니다.
        UIGraphicsBeginImageContextWithOptions(imageRect.size, false, 0)

        // 원형으로 잘라낼 범위를 계산합니다.
        let path = UIBezierPath(ovalIn: imageRect)
        path.addClip()

        // 이미지를 그립니다.
        draw(in: imageRect)

        // 새로운 이미지를 가져옵니다.
        let maskedImage = UIGraphicsGetImageFromCurrentImageContext()

        // 그래픽 컨텍스트를 종료합니다.
        UIGraphicsEndImageContext()

        // 새로운 이미지를 반환합니다.
        return maskedImage
    }
}
