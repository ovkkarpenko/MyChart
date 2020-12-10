//
//  MyChart.swift
//  ChartApp
//
//  Created by Oleksandr Karpenko on 10.12.2020.
//

import UIKit

class MyChart: UIView {
    
    private var items: [ChartItem] = []
    private var shapeLayers: [CAShapeLayer] = []
    
    convenience init(_ items: [ChartItem]) {
        self.init()
        self.items = items
    }
    
    func draw() {
        shapeLayers.forEach { $0.removeFromSuperlayer() }
        
        let spacing = Int(UIScreen.main.bounds.width-30)/items.count
        var x = 20
        
        for i in 0..<items.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)/10) { [weak self, x, i] in
                guard let self = self else { return }
                if i < self.items.count {
                    self.drawRectangle(x: x, value: self.items[i].value)
                }
            }
            x += spacing
        }
    }
    
    func setItems(_ items: [ChartItem]) {
        self.items = items
    }
    
    private func drawRectangle(x: Int, value: Int) {
        let height = 300
        let shapeLayer = CAShapeLayer()
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: x, y: height))
        path.addLine(to: CGPoint(x: x, y: height * value / 100))
        
        shapeLayer.path = path.cgPath
        shapeLayer.strokeEnd = 0
        shapeLayer.lineWidth = CGFloat(Int(UIScreen.main.bounds.width)/items.count * 50 / 100)
        shapeLayer.strokeColor = UIColor.blue.cgColor
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 1
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        
        shapeLayer.add(animation, forKey: "stroke")
        
        shapeLayers.append(shapeLayer)
        layer.addSublayer(shapeLayer)
    }
}
