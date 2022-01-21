//
//  UIImage+Extensions.swift
//  Week14-Random
//
//  Created by Mehmet Salih ÇELİK on 21.01.2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func configureKF(url: String?) {
        guard let url = url else { return }
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string: url),
                         placeholder: nil,
                         options: [.transition(.fade(0.7 ))],
                         progressBlock: nil)
    }
}
