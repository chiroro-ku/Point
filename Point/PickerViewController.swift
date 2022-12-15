//
//  PickerViewController.swift
//  Point
//
//  Created by 小林千浩 on 2022/12/09.
//

import UIKit

class PickerViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var list: [String] = []
    var delegate: PickerData?
    var selectedData: String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        
        self.textField.delegate = self
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        let row = pickerView.selectedRow(inComponent: 0)
        self.selectedData = list[row]
        
    }
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        
        self.delegate?.pickerSelectedDataLoad(selectedData)
        
        self.dismiss(animated: true)
        
    }

}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let row = pickerView.selectedRow(inComponent: 0)
        self.selectedData = list[row]
        
    }
}

extension PickerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.selectedData = textField.text ?? ""
        self.textField.resignFirstResponder()
        
        return true
    }
}
