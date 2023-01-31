//
//  AddToDoVC.swift
//  TodoList
//
//  Created by Tolba Hamdi on 1/28/23.
//

import UIKit
import FirebaseFirestore

class AddToDoVC: UIViewController {

    //MARK:- Properties
    private let datePicker: UIDatePicker = UIDatePicker()
    
    //MARK:- IBOutlet
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var dateAndTimeTF: UITextField!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentTF: UITextField!
    @IBOutlet weak var saveBtnOutlet: UIButton!
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- IBActions
    @IBAction func endEditingDateAndTimeTF(_ sender: UITextField) {
        handleEditingTF(sender: sender, label: dateAndTimeLabel, placeholder: PlaceholderText.dateAndTime)
    }
    @IBAction func startEditingDateAndTimeTF(_ sender: UITextField) {
        handleEditingTF(sender: sender, label: dateAndTimeLabel, placeholder: PlaceholderText.dateAndTime)
        showDatePickerFrom()
    }
    
    @IBAction func endEditingContentTF(_ sender: UITextField) {
        handleEditingTF(sender: sender, label: contentLabel, placeholder: PlaceholderText.content)
    }
    
    @IBAction func startEditingContentTF(_ sender: UITextField) {
        handleEditingTF(sender: sender, label: contentLabel, placeholder: PlaceholderText.content)
    }
    
    @IBAction func saveToDoBtnTapped(_ sender: Any) {
        saveBtnActionTapped()
    }
    
}

//MARK:- Private Function
extension AddToDoVC {
    private func handleEditingTF(sender: UITextField, label: UILabel, placeholder: String) {
        if sender.text == "" {
            sender.placeholder = sender.isEditing ? "" : placeholder
            label.text = sender.isEditing ? placeholder : ""
            sender.addBottomBorder(height: sender.isEditing ? 2 : 1, color: sender.isEditing ? Colors.purpleColor.cgColor : Colors.grayColor.cgColor)
        }
    }
    
    @objc func showDatePickerFrom(){
            let toolbar = UIToolbar();
            toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: ButtonsTitle.done, style: .plain, target: self, action: #selector(donedatePicker))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: ButtonsTitle.cancel, style: .plain, target: self, action: #selector(cancelDatePicker))
            toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
            dateAndTimeTF.inputAccessoryView = toolbar
        
            dateAndTimeTF.inputView = datePicker
            datePicker.datePickerMode = .dateAndTime
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }

        datePicker.minimumDate = Date()
        
        }
        
        @objc func donedatePicker(){
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .medium
            dateAndTimeTF.text = formatter.string(from: datePicker.date)
            self.view.endEditing(true)
        }
        
        @objc func cancelDatePicker(){
            self.view.endEditing(true)
        }
    
    private func isEnteredData() -> Bool {
        guard dateAndTimeTF.text != "" else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.noTime)
            return false
        }
        guard contentTF.text != "" else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.noContent)
            return false
        }
        return true
    }
    
    private func saveBtnActionTapped() {
        if isEnteredData()  {
            self.view.showLoader()
            self.saveBtnOutlet.isEnabled = false
            ToDoFirebaseManager.shared.saveToDo(time: dateAndTimeTF.text!, content: contentTF.text!) { error in
                self.view.hideLoader()
                self.saveBtnOutlet.isEnabled = true
                if let error = error {
                    self.showAlert(title: Alerts.sorryTitle, message: error.localizedDescription)
                } else {
                    self.showAlert(title: Alerts.successTitle, message: Alerts.saveSuccess) { _ in
                        self.gotoToDoListVC()
                    }
                }
            }
        }
    }
    
    private func gotoToDoListVC() {
        dismiss(animated: true)
    }
}
