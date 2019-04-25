//
//  UIView+Extras.swift
//  ModelPredictSwift
//
//  Created by yair hadad on 26/04/2019.
//  Copyright © 2019 yair hadad. All rights reserved.
//

import UIKit

extension UIView {
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
}
