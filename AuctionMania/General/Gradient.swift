//
//  Gradient.swift
//  AuctionMania
//
//  Created by usear on 7/3/24.
//

import UIKit
@IBDesignable
class Gradient: UIView {

    @IBInspectable var FirstColour: UIColor = .clear{
        didSet{
            updateGradient()
        }
    }
    @IBInspectable var SecondColour: UIColor = .clear{
        didSet{
            updateGradient()
        }
    }
    
    override class var layerClass: AnyClass{
        get{
            return CAGradientLayer.self
        }
    }
    
    func updateGradient(){
        let layer = self.layer as! CAGradientLayer
        layer.colors = [FirstColour.cgColor, SecondColour.cgColor]
    }

}
