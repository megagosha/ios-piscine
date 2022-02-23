//
//  Shape.swift
//  MotionCube
//
//  Created by George Tevosov on 16.02.2022.
//

import Foundation
import UIKit

enum ShapeType: CaseIterable {
    case square, circle
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red:   .random(),
            green: .random(),
            blue:  .random(),
            alpha: 1.0
        )
    }
}

class Shape: UIView {
    public var shape: ShapeType
    
    init(x: Int, y: Int, width: Int, height: Int, color: UIColor = UIColor.random(), shape: ShapeType = ShapeType.allCases.randomElement()!) {
        self.shape = shape
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        self.backgroundColor = UIColor.random()
        switch shape {
        case .circle:
            self.layer.cornerRadius = CGFloat(width / 2)
            self.layer.masksToBounds = true
        default:
            print ("default")
        }
        self.isUserInteractionEnabled = true;
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
