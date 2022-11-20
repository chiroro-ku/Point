//
//  SetupViewController.swift
//  Point
//
//  Created by 小林千浩 on 2022/11/20.
//

import UIKit

class SetupViewController: UIViewController {
    
    
    @IBOutlet weak var setupView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var modelImage: UIImage!
    var textImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let modelImageView = UIImageView(image: modelImage)
        modelImageView.isUserInteractionEnabled = true
        self.setupView.addSubview(modelImageView)
        
        let textImageView = UIImageView(image: textImage)
        textImageView.frame.origin = CGPoint(x: 0, y: modelImageView.frame.height)
        textImageView.isUserInteractionEnabled = true
        self.setupView.addSubview(textImageView)
        
        self.doneButton.addTarget(self, action: #selector(doneButtonTapped(_:)), for: .touchUpInside)
        self.deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func doneButtonTapped(_ sender: UIButton) {
        
        UIGraphicsBeginImageContextWithOptions(setupView.bounds.size, false, 0.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        self.setupView.layer.render(in: context)
        let image : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activity, animated: true, completion: nil)
    }
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touchevent = touches.first, let touchesView = touchevent.view as? UIImageView else {
            return
        }
        
        let previousLocation = touchevent.previousLocation(in: self.view)
        let touchesLocation = touchevent.location(in: self.view)
        
        let deltaX = touchesLocation.x - previousLocation.x
        let deltaY = touchesLocation.y - previousLocation.y
        
        touchesView.frame.origin.x += deltaX
        touchesView.frame.origin.y += deltaY
    }

}
