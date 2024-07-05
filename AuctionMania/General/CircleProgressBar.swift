//
//  CircleProgressBar.swift
//  AuctionMania
//
//  Created by user on 7/4/24.
//

import UIKit

class CircleProgressBar: UIView {
    
    
    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    
    let percentLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .tertiarySystemBackground
        label.textAlignment = .center
        return label
    }()
    
    var primaryColour: CGColor = UIColor.black.cgColor {
        didSet{
            shapeLayer.strokeColor = primaryColour
        }
    }
    
    var backgroundColour: CGColor = UIColor.gray.cgColor {
        didSet{
            trackLayer.strokeColor = backgroundColour
        }
    }
    
    var percentColour: UIColor = UIColor.label{
        didSet{
            percentLabel.textColor = percentColour
        }
    }
    
    var percentage: Int = 100{
        didSet{
            strokeDestination = Double(percentage)/100.0
        }
    }
    var strokeDestination: Double = 1.0{
        didSet{
            doAnimation()
        }
    }
    
    private var displayLink: CADisplayLink?
    private func makeCircle(){
        self.backgroundColour = UIColor.clear.cgColor
        primaryColour = UIColor.systemBackground.cgColor
        backgroundColour = UIColor.systemFill.cgColor
        
        shapeLayer.lineWidth = 5
        trackLayer.lineWidth = 5
        shapeLayer.fillColor = UIColor.clear.cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 0
        let path = UIBezierPath(arcCenter: CGPoint(x: frame.width/2, y: frame.height/2), radius: 30, startAngle: -(CGFloat.pi / 2), endAngle: (CGFloat.pi*2)-(CGFloat.pi / 2), clockwise: true).cgPath
        shapeLayer.path = path
        trackLayer.path = path
        
        self.layer.addSublayer(shapeLayer)
        self.layer.addSublayer(trackLayer)
    }
    
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeCircle()
        doAnimation()
        percentLabel.text = String(percentage)+"%"
        addSubview(percentLabel)

    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeCircle()
        doAnimation()
        percentLabel.text = String(percentage)+"%"
        addSubview(percentLabel)

    }
    override func layoutSubviews() {
        percentLabel.frame = bounds
    }
    
    
    func doAnimation(){
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = strokeDestination
        animation.duration = 1
        
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        shapeLayer.add(animation, forKey: "blabla")
        
        displayLink = CADisplayLink(target: self, selector: #selector(updateProgressDuringAnimation))
                displayLink?.add(to: .main, forMode: .default)
    }
    
    @objc private func updateProgressDuringAnimation() {
            // Implement any logic you need to update during animation intervals
            // Example: You can update the label text here based on animation progress
            // For example, you can access the current value of strokeEnd from shapeLayer
            // and update the progressLabel accordingly.
            let currentStrokeEnd = shapeLayer.presentation()?.strokeEnd ?? 0.0
            let currentPercentage = Int(currentStrokeEnd * 100)+1
            percentLabel.text = "\(currentPercentage)%"
        }
    deinit {
            displayLink?.invalidate()
        }

}


