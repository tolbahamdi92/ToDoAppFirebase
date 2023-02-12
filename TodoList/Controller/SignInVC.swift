//
//  SignInVC.swift
//  TodoList
//
//  Created by Tolba Hamdi on 1/27/23.
//

import UIKit
import Combine

class SignInVC: UIViewController {
    
    //MARK:- Property
    private var cancelables = Set<AnyCancellable>()
    
    //MARK:- IBOutlet
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTextFieldUI()
        statusBarColorChange()
    }
    
    //MARK:- IBAction
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
    
    @IBAction func signInBtnTapped(_ sender: UIButton) {
        signInBtnActionTapped()
    }
    
    @IBAction func signUpLabelTapped(_ sender: UITapGestureRecognizer) {
        gotoSignUp()
    }
}

//MARK:- Private functions
extension SignInVC {
    private func setupNavBar() {
        self.navigationItem.hidesBackButton = true
    }
    
    private func setupTextFieldUI() {
        emailTF.addBottomBorder()
        passwordTF.addBottomBorder()
    }
    
    private func handleEditingTF(sender: UITextField, label: UILabel, placeholder: String) {
        if sender.text == "" {
            sender.placeholder = sender.isEditing ? "" : placeholder
            label.text = sender.isEditing ? placeholder : ""
            sender.addBottomBorder(height: sender.isEditing ? 2 : 1, color: sender.isEditing ? Colors.purpleColor.cgColor : Colors.grayColor.cgColor)
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
    
    private func signInBtnActionTapped() {
        if isEnteredData() && isValidData() {
            self.view.showLoader()
            UserManager.shared.signIn(email: emailTF.text!, password: passwordTF.text!)
                .sink { [weak self] error in
                    guard let self else {return}
                    self.view.hideLoader()
                    if case let .failure(error) = error {
                        self.showAlert(title: Alerts.sorryTitle, message: error.localizedDescription)
                    }
                    self.showAlert(title: Alerts.successTitle, message: Alerts.signInSuccess) { _ in
                        self.gotoToDoListsVC()
                    }
                } receiveValue: { _ in }
                .store(in: &cancelables)
        }
    }
    
    private func gotoSignUp() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func gotoToDoListsVC() {
        let toDoListsVC = UIStoryboard(name: StoryBoard.main, bundle: nil).instantiateViewController(withIdentifier: ViewController.toDoListsVC)
        self.navigationController?.pushViewController(toDoListsVC, animated: true)
    }
}
