//
//  ImageViewController.swift
//  point_test_1
//
//  Created by 小林千浩 on 2022/11/18.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var setView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var model: UIImage!
    var text: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let modelView = UIImageView(image: model)
        self.setView.addSubview(modelView)
        modelView.isUserInteractionEnabled = true
        
        let textView = UIImageView(image: text)
        textView.frame.origin = CGPoint(x: 0, y: modelView.frame.height)
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = .clear
        self.setView.addSubview(textView)
        
        self.saveButton.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func saveButtonTapped(_ sender: UIButton) {
        
        UIGraphicsBeginImageContextWithOptions(setView.bounds.size, false, 0.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        self.setView.layer.render(in: context)
        let image : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let pngImageData = image.pngData()
        
        let documentsURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("test")
        //Library/Developer/CoreSimulator/Devices/CEE52091-8CC5-4751-8D63-BAE37D240A00/data/Containers/Data/Application/5FA25380-87B2-4941-AE9A-7F7F3B053F92/Library/
        
        let imageData = pngImageData
        do {
            try imageData!.write(to: fileURL)
        } catch {
            print("error")
        }
        
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touchevent = touches.first, let touchesView = touchevent.view as? UIImageView else {
            return
        }
        
        let previousPoint = touchevent.previousLocation(in: self.view)
        let point = touchevent.location(in: self.view)
        
        let deltaX = point.x - previousPoint.x
        let deltaY = point.y - previousPoint.y
        
        touchesView.frame.origin.x += deltaX
        touchesView.frame.origin.y += deltaY
    }
}
