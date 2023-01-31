//
//  Constants.swift
//  MediaFinder
//
//  Created by Tolba on 23/06/1444 AH.
//

import UIKit

//  MARK:- StoryBoard
struct StoryBoard {
    static let main = "Main"
}

//MARK:- Colors
struct Colors {
    static let grayColor = UIColor.lightGray
    static let purpleColor = UIColor(red: 0.278, green: 0.078, blue: 0.396, alpha: 1.0)
}

//  MARK:- ViewController
struct ViewController {
    static let signUpVC = "SignUpVC"
    static let signInVC = "SignInVC"
    static let toDoListsVC = "ToDoListsVC"
    static let addToDoVC = "AddToDoVC"
    
}

//  MARK:- ViewControllerTitle
struct ViewControllerTitle {
    static let signUp = "Sign Up"
    static let signIn = "Sign In"
    
}

//MARK:- ButtonsTitle
struct ButtonsTitle {
    static let signUp = "Sign Up"
    static let saveData = "Save Data"
    static let logOut = "Log out"
    static let profile = "Profile"
    static let ok = "OK"
    static let cancel = "Cancel"
    static let done = "Done"
}

//MARK:- UserDefaultsKeys
struct UserDefaultsKeys {
    static let isLoggedIn = "isLoggedIn"
    static let email = "email"
}

//MARK:- ToDoKeys
struct ToDoKeys {
    static let date = "date"
    static let content = "content"
}

// MARK:- FireBase
struct FireBase {
    static let toDosColl = "toDos"
    static let toDosUser = "toDosUser"
}

//MARK:- Cells
struct Cells {
    static let toDoCell = "ToDoCell"
}

// MARK:- URLs
struct URLs {
    static let base = "https://itunes.apple.com/search?"
}

// MARK:- ParameterKey
struct ParameterKey {
    static let term = "term"
    static let media = "media"
}

// MARK:- ValidationRegex
struct ValidationRegex {
    static let formate = "SELF MATCHES %@"
    static let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9._]+\\.[A-Za-z]{2,}"
    static let password = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*?[#?!@$%^&*-]).{8,}"
    static let phone = "^[0-9]{11}$"
}

// MARK:- SQL
struct SQL {
    static let userTable = "users"
    static let id = "id"
    static let email = "email"
    static let userData = "userData"
    static let userPathComponent = "users"
    static let pathExtension = "sqlite3"
    
    static let searchDataTable = "searchData"
    static let mediaType = "mediaType"
    static let results = "results"
    static let searchPathComponent = "searchData"
}

// MARK:- PlaceholderImage
struct PlaceholderImage {
    static let user = "user"
    static let search = "search"
}

// MARK:- PlaceholderText
struct PlaceholderText {
    static let userName = "User Name"
    static let userEmail = "Email"
    static let userPassword = "Password"
    
    static let dateAndTime = "DateAndTime"
    static let content = "Content"
}

// MARK:- Alerts
struct Alerts {
    static let sorryTitle = "Sorry"
    static let successTitle = "Success"
    static let validEmail = " Please enter valid email \n Example tolba@gmail.com"
    static let validPassword = "Please enter valid password. that must contain minimum 8 characters, at least \n - one uppercase letter \n - one lowercase letter \n - one number \n - one special character"
    static let noName = "Please enter your name"
    static let noEmail = "Please enter your email"
    static let noPassword = "Please enter your password"
    static let dataLoginWrong = "email or password is wrong"
    static let tryAgain = "Possibly something is wrong try again"
    static let saveSuccess = "Data saved successfully"
    static let signUpSuccess = "Sign Up successfully"
    static let signInSuccess = "Sign In successfully"
    static let userFound = "account already found"
    
    static let noTime = "Please determine todo time"
    static let noContent = "Please enter content of ToDo"
}
