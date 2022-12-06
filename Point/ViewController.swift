//
//  ViewController.swift
//  Point
//
//  Created by 小林千浩 on 2022/11/18.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var teamNameField: UITextField!
    @IBOutlet weak var ageButton: UIButton!
    @IBOutlet weak var performanceNameField: UITextField!
    @IBOutlet weak var partButton: UIButton!
    @IBOutlet weak var modelColorWell: UIColorWell!
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var editView: EditView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var redoSubButton: UIButton!
    @IBOutlet weak var undoSubButton: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var redoButton: UIButton!
    @IBOutlet weak var undoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.teamNameField.delegate = self
        self.performanceNameField.delegate = self
        self.modelColorWell.addAction(.init{_ in self.modelChangeColor(color: self.modelColorWell.selectedColor ?? .green)}, for: .allEvents)
        
        
        self.closeButton.isHidden = true
        self.closeButton.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
        
        self.redoSubButton.isHidden = true
        self.redoSubButton.addTarget(self, action: #selector(redoButtonTapped(_:)), for: .touchUpInside)
        
        self.undoSubButton.isHidden = true
        self.undoSubButton.addTarget(self, action: #selector(undoButtonTapped(_:)), for: .touchUpInside)
        
        
        self.doneButton.addTarget(self, action: #selector(doneButtonTapped(_:)), for: .touchUpInside)
        
        self.redoButton.addTarget(self, action: #selector(redoButtonTapped(_:)), for: .touchUpInside)
        
        self.undoButton.addTarget(self, action: #selector(undoButtonTapped(_:)), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.infoLabelLoad()
        
        let interaction = UIContextMenuInteraction(delegate: self)
        self.editView.odorikoModel.face.addInteraction(interaction)
        self.editView.isUserInteractionEnabled = true
    }
    
    
    
    @objc private func closeButtonTapped(_ sender: UIButton) {
        self.textView.resignFirstResponder()
    }
    
    @objc private func doneButtonTapped(_ sender: UIButton) {
        
        guard let setupViewController = storyboard?.instantiateViewController(withIdentifier: "setupViewController") as? SetupViewController else {
            return
        }
        
        setupViewController.modalPresentationStyle = .fullScreen
        setupViewController.modelImage = editView.toImage()
        setupViewController.textImage = textView.toImage()
        self.present(setupViewController, animated: true)
        
    }
    
    @objc private func redoButtonTapped(_ sender: UIButton) {
        print("redoButtonTapped")
    }
    
    @objc private func undoButtonTapped(_ sender: UIButton) {
        print("undoButtonTapped")
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if !textView.isFirstResponder {
            return
        }
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= editView.frame.origin.y - self.view.safeAreaInsets.top - 10
                
                self.editButtonChangeHidden()
            } else {
                let suggestionHeight = self.view.frame.origin.y + keyboardSize.height
                self.view.frame.origin.y -= suggestionHeight
                
                self.editButtonChangeHidden()
            }
        }
    }
    
    @objc func keyboardWillHide() {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    private func infoLabelLoad() {
        let teamName = teamNameField.text ?? ""
        let age = Int(ageButton.titleLabel?.text ?? "") ?? 2022
        let performanceName = performanceNameField.text ?? ""
        let part = partButton.titleLabel?.text ?? ""
        
        var teamInfo = ""
        if teamName != "" {
            teamInfo = "\(teamName) '\(age % 100)"
        }
        
        var partInfo = ""
        if performanceName != "" {
            partInfo = "\(performanceName) \(part)"
        }
        
        let info = teamInfo + "\n" + partInfo
        
        self.infoLabel.text = info
    }
    
    private func editButtonChangeHidden(){
        self.closeButton.isHidden = !closeButton.isHidden
        self.redoSubButton.isHidden = !redoSubButton.isHidden
        self.undoSubButton.isHidden = !undoSubButton.isHidden
    }
    
    private func modelChangeColor(color: UIColor){
        self.editView.odorikoModel.modelChangeColor(color: color)
        
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.teamNameField.resignFirstResponder()
        self.performanceNameField.resignFirstResponder()
        self.infoLabelLoad()
        return true
    }
}

extension ViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
            let up = UIAction(title: "UP", image: UIImage(systemName: "figure.wave")) { action in
                print("up")
            }
            let right = UIAction(title: "RIGHT", image: UIImage(systemName: "bag")) { action in
                print("right")
            }
            let left = UIAction(title: "LEFT", image: UIImage(systemName: "hare")) { action in
                print("left")
            }
            let down = UIAction(title: "DOWN", image: UIImage(systemName: "figure.walk")) { action in
                print("down")
            }
            return UIMenu(title: "Direction", children: [up, right, left, down])
        })
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
        
        self.backgroundColor = .systemBackground
        
        return image
    }
}

