//
//  TIReactionConfettiView.swift
//  EmojiReactionBarDemo
//
//  Created by Tecocraft on 21/11/22.
//

import UIKit
import QuartzCore

public enum ConfettiDirection {
    case top
    case bottom
}

public class TIReactionConfettiView: UIView {
    var emitterLayer: CAEmitterLayer = CAEmitterLayer()
    private var isActive: Bool!
    private var image: UIImage?
    private var arrImageName: [String]?
    var direction: ConfettiDirection = .bottom
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    func setup() {
        direction = .bottom
        isActive = false
    }

    // Duration is time active anitmation.Default is 0 -> It won't stop
    public func startConfetti(duration: TimeInterval = 0) {
        
        if (image == nil && arrImageName == nil) || isActive {
            return
        }

        let x = frame.size.width / 2
        let y = frame.size.height
        emitterLayer.emitterPosition = CGPoint(x: x, y: y)
        emitterLayer.emitterShape = CAEmitterLayerEmitterShape.line
        emitterLayer.emitterSize = CGSize(width: frame.size.width, height: 1)
        emitterLayer.birthRate = 1
        
        if let images = arrImageName {
            var cells: [CAEmitterCell] = []
            var count = 0
            for image in images {
                print("Count \(count)")
                self.image = UIImage(named: image)
                cells.append(confettiForComments())
                count += 1
            }
        
            emitterLayer.emitterCells = cells
        } else {
            emitterLayer.emitterCells = [confettiForComments()]
        }
        
        layer.addSublayer(emitterLayer)
        isActive = true
        if duration != 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
                self.emitterLayer.birthRate = 0
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(emitterLayer.emitterCells?[0].lifetime ?? 0.0), execute: {
                self.isActive = false
            })
        }
    }

    public func stopConfetti() {
        emitterLayer.birthRate = 0
        isActive = false
    }

    public func setImageForConfetti(image: UIImage) {
        self.image = image
    }
    
    public func setImagesForConfetti(arrImage: [String]) {
        self.arrImageName = arrImage
    }
    
    func confettiForComments() -> CAEmitterCell {
        let confetti = CAEmitterCell()
        
        confetti.birthRate = 1.6
        confetti.lifetime = 4
        confetti.velocity = CGFloat(120)
        confetti.emissionLongitude = CGFloat(0)
        confetti.emissionRange = .pi / 10
        confetti.contents = image?.cgImage
        confetti.scale = 1 / UIScreen.main.scale
        
        return confetti
    }
    
    public func isConfettiActive() -> Bool {
        return self.isActive
    }
}
