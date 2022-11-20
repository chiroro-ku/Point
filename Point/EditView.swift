//
//  EditView.swift
//  Point
//
//  Created by 小林千浩 on 2022/11/19.
//

import UIKit

class EditView: UIView {
    
    
    
    var odorikoModel:OdorikoModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.editViewInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.editViewInit()
    }
    
    private func editViewInit(){
        
        let facePoint = CGPoint(x: frame.width/2, y: frame.height/5)
        self.odorikoModel = OdorikoModel(facePoint: facePoint)
        
        self.addSubview(odorikoModel.face)
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
        
        self.backgroundColor = .clear
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else{
            return nil
        }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.backgroundColor = .systemBackground
        
        return image
    }
}
