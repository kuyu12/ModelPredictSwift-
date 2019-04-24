//
//  ModelUtils.swift
//  ModelPredictSwift
//
//  Created by yair hadad on 24/04/2019.
//  Copyright © 2019 yair hadad. All rights reserved.
//

import UIKit
import CoreML

class ModelUtils {
    
    // preprocess image to return as MLMultiArray
    class func preprocess(image: UIImage) -> MLMultiArray? {
        let size = CGSize(width: 28, height: 28)
        
        
        guard let pixels = image.resize(to: size).pixelData()?.map({ (Double($0) / 255.0 - 0.5) * 2 }) else {
            return nil
        }
        
        guard let array = try? MLMultiArray(shape: [3, 28, 28], dataType: .double) else {
            return nil
        }
        
        let r = pixels.enumerated().filter { $0.offset % 4 == 0 }.map { $0.element }
        let g = pixels.enumerated().filter { $0.offset % 4 == 1 }.map { $0.element }
        let b = pixels.enumerated().filter { $0.offset % 4 == 2 }.map { $0.element }
        
        let combination = r + g + b
        for (index, element) in combination.enumerated() {
            array[index] = NSNumber(value: element)
        }
        
        return array
    }
    
}
