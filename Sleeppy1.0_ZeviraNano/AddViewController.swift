//
//  AddViewController.swift
//  Sleeppy1.0_ZeviraNano
//
//  Created by Zevira varies martan on 09/05/22.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var titleField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    public var completion: ((String, Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(didTapSaveButtone))
    }
    
    @objc func didTapSaveButtone() {
        if let titleText = titleField.text, !titleText.isEmpty {
            let targetDate = datePicker.date
            let targetTime = datePicker.timeZone
            
            completion?(titleText, targetDate)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
