//
//  SignUpVC.swift
//  TodoList
//
//  Created by Tolba Hamdi on 1/22/23.
//

import UIKit

class SignUpVC: UIViewController {

    //MARK:- IBOutlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    
    //MARK:- Properties
    let grayColor: CGColor = UIColor.lightGray.cgColor
    let purpleColor: CGColor = UIColor(red: 0.278, green: 0.078, blue: 0.396, alpha: 1.0).cgColor
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFieldUI()
        statusBarColorChange()
    }

    //MARK:- IBAction
    @IBAction func endEditingNameTF(_ sender: UITextField) {
        handleEditingTF(sender: sender, label: nameLabel, placeholder: PlaceholderText.userName)
    }
    
    @IBAction func startEditingNameTF(_ sender: UITextField) {
        handleEditingTF(sender: sender, label: nameLabel, placeholder: PlaceholderText.userName)
    }
    
    @IBAction func endEditingEmailTF(_ sender: UITextField) {
        handleEditingTF(sender: sender, label: emailLabel, placeholder: PlaceholderText.userEmail)
    }
    @IBAction func startEditingEmailTF(_ sender: UITextField) {
        handleEditingTF(sender: sender, label: emailLabel, placeholder: PlaceholderText.userEmail)
    }
    
    @IBAction func endEditingTF(_ sender: UITextField) {
        handleEditingTF(sender: sender, label: passwordLabel, placeholder: PlaceholderText.userPassword)
    }
    
    @IBAction func startEditingTF(_ sender: UITextField) {
        handleEditingTF(sender: sender, label: passwordLabel, placeholder: PlaceholderText.userPassword)
    }
    
    @IBAction func signUpBtnTapped(_ sender: UIButton) {
        signUpBtnActionTapped()
    }
    
    @IBAction func signInLabelTapped(_ sender: UITapGestureRecognizer) {
        gotoSignInVC()
    }
}

//MARK:- Private functions
extension SignUpVC {
    private func setupTextFieldUI() {
        nameTF.addBottomBorder()
        emailTF.addBottomBorder()
        passwordTF.addBottomBorder()
    }
    
    private func handleEditingTF(sender: UITextField, label: UILabel, placeholder: String) {
        if sender.text == "" {
            sender.placeholder = sender.isEditing ? "" : placeholder
            label.text = sender.isEditing ? placeholder : ""
            sender.addBottomBorder(height: sender.isEditing ? 2 : 1, color: sender.isEditing ? purpleColor : grayColor)
        }
    }
    
    private func isValidData() -> Bool {
        guard ValidtionDataManager.shared.isValidEmail(email: emailTF.text!) else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.validEmail)
            return false
        }
        guard ValidtionDataManager.shared.isValidPassword(password: passwordTF.text!) else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.validPassword)
            return false
        }
        return true
    }
    
    private func isEnteredData() -> Bool {
        guard nameTF.text != "" else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.noName)
            return false
        }
        guard emailTF.text != "" else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.noEmail)
            return false
        }
        guard passwordTF.text != "" else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.noPassword)
            return false
        }
        return true
    }
    
    private func signUpBtnActionTapped() {
        if isEnteredData() && isValidData() {
            UserFireBaseManager.shared.saveUserInFB(name: nameTF.text!, email: emailTF.text!, password: passwordTF.text!) { error in
                if error != nil {
                    self.showAlert(title: Alerts.sorryTitle, message: error!.localizedDescription)
                } else {
                    
                    self.showAlert(title: Alerts.successTitle, message: Alerts.saveSuccess) { _ in
                        self.gotoToDoListsVC()
                    }
                }
            }
        }
    }
    
    private func gotoSignInVC() {
        let signInVC = UIStoryboard(name: StoryBoard.main, bundle: nil).instantiateViewController(withIdentifier: ViewController.signInVC)
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
    
    private func gotoToDoListsVC() {
        let toDoListsVC = UIStoryboard(name: StoryBoard.main, bundle: nil).instantiateViewController(withIdentifier: ViewController.toDoListsVC)
        self.navigationController?.pushViewController(toDoListsVC, animated: true)
    }
}
