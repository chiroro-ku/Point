//
//  DisplayView.swift
//  point_test_1
//
//  Created by 小林千浩 on 2022/11/09.
//

import UIKit

class DisplayView: UIView {
    var model:Model!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.displayInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.displayInit()
    }
    
    private func displayInit(){
        
        let facePoint = CGPoint(x: frame.width/2, y: frame.height/5)
        let faceSize = CGSize(width: 55, height: 55)
        let boneSize = CGSize(width: 20, height: 60)
        let bodySize = CGSize(width: 60, height: 120)
        
        self.model = Model(facePoint: facePoint, faceSize: faceSize, bodySize: bodySize, boneSize: boneSize)
        
        self.addSubview(model.face)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touchesEvent = touches.first, let touchesView = touchesEvent.view as? BoneView else {
            return
        }
        
        let touchesPoint = touchesEvent.location(in: touchesView.superview)
        let targetPoint = touchesView.center
        let angle = atan2(targetPoint.y-touchesPoint.y, targetPoint.x-touchesPoint.x)
        touchesView.rotated(by: angle)
    }
    
    func toImage() -> UIImage?{
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else{
            return nil
        }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
