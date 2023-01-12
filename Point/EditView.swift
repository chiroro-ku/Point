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
        
        let point = CGPoint(x: frame.width/2, y: frame.height/3)
        self.odorikoModel = OdorikoModel(center: point)
        
        self.addSubview(odorikoModel.centerBody())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touchesEvent = touches.first, let touchesView = touchesEvent.view as? BoneView else {
            return
        }
        
        let touchesLocation = touchesEvent.location(in: touchesView.superview)
        let targetCenter = touchesView.center
        let angle = atan2(targetCenter.y-touchesLocation.y, targetCenter.x-touchesLocation.x)
        touchesView.rotated(by: angle)
    }
    
    func toImage(_ transparent: Bool = true) -> UIImage?{
        
        if transparent {
            self.backgroundColor = .clear
        }
        
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
