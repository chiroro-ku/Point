//
//  ViewController.swift
//  point_test_1
//
//  Created by 小林千浩 on 2022/11/04.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayView: DisplayView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var backSubButton: UIButton!
    @IBOutlet weak var frontSubButton: UIButton!
    @IBOutlet weak var pointTextView: UITextView!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var frontButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.closeButton.isHidden = true
        self.closeButton.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
        self.backSubButton.isHidden = true
        self.backSubButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        self.frontSubButton.isHidden = true
        self.frontSubButton.addTarget(self, action: #selector(frontButtonTapped(_:)), for: .touchUpInside)
        self.imageButton.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
        self.backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        self.frontButton.addTarget(self, action: #selector(frontButtonTapped(_:)), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func closeButtonTapped(_ sender: UIButton) {
        self.pointTextView.resignFirstResponder()
    }
    
    @objc private func saveButtonTapped(_ sender: UIButton) {
        print("imageButtonTapped")
        
        guard let imageViewController = storyboard?.instantiateViewController(withIdentifier: "imageViewController") as? ImageViewController else {
            return
        }
        imageViewController.modalPresentationStyle = .fullScreen
        imageViewController.model = displayView.toImage()
        imageViewController.text = pointTextView.toImage()
        self.present(imageViewController, animated: true)
        
    }
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        print("backButtonTapped")
    }
    
    @objc private func frontButtonTapped(_ sender: UIButton) {
        print("frontButtonTapped")
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= displayView.frame.origin.y - 57//keyboardSize.height
                
                self.closeButton.isHidden = false
                self.backSubButton.isHidden = false
                self.frontSubButton.isHidden = false
            } else {
                let suggestionHeight = self.view.frame.origin.y + keyboardSize.height
                self.view.frame.origin.y -= suggestionHeight
                
                self.closeButton.isHidden = true
                self.backSubButton.isHidden = true
                self.frontSubButton.isHidden = true
            }
        }
    }
    
    @objc func keyboardWillHide() {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

extension UITextView {
    func toImage() -> UIImage?{
        self.backgroundColor = .clear
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
