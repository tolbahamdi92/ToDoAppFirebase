//
//  UserFireBaseManager.swift
//  FirebaseChat
//
//  Created by Tolba on 28/06/1444 AH.
//

import UIKit
import FirebaseAuth

class UserFireBaseManager {
    
    //MARK:- Properties
    static let shared = UserFireBaseManager()
    
    //MARK:- initializer
    private init(){}
    
    //MARK:- saveUserInFB
    func saveUserInFB(name: String, email: String, password: String, completion: @escaping ((Error?) -> Void)) {
        createUser(name: name, email: email, password: password) { error in
            completion(error)
        }
    }
    
    //MARK:- signInFB
    func signInFB(email: String, password: String, completion: @escaping ((Error?) -> Void)) {
        signIn(email: email, password: password) { error in
            completion(error)
        }
    }
    
    //MARK:- getCurrentUserID
    func getCurrentUserID() -> String? {
        Auth.auth().currentUser?.uid
    }
    
    //MARK:- getCurrentUserName
    func getCurrentUserName() -> String? {
        Auth.auth().currentUser?.displayName
    }
}

//MARK:- Private Functions
extension UserFireBaseManager {
    private func createUser(name: String, email: String, password: String, completion: @escaping ((Error?) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                completion(error)
            } else {
                let changeRequest = result!.user.createProfileChangeRequest()
                changeRequest.displayName = name
                changeRequest.commitChanges { error in
                  completion(error)
                }
            }
        }
    }
    
    private func signIn(email: String, password: String, completion: @escaping ((Error?) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            completion(error)
        }
    }
}
