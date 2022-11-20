//
//  SetView.swift
//  point_test_1
//
//  Created by 小林千浩 on 2022/11/18.
//

import UIKit

class SetView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touchevent = touches.first, let touchesView = touchevent.view as? UIImageView else {
            return
        }
        
        let previousPoint = touchevent.previousLocation(in: self)
        let point = touchevent.location(in: self)
        
        let deltaX = point.x - previousPoint.x
        let deltaY = point.y - previousPoint.y
        
        touchesView.frame.origin.x += deltaX
        touchesView.frame.origin.y += deltaY
    }
}
