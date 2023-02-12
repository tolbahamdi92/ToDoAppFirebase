//
//  UserManager.swift
//  TodoList
//
//  Created by Tolba Hamdi on 2/12/23.
//

import Foundation
import Combine
import FirebaseAuth

struct UserManager {
    //MARK:- Properties
    static let shared = UserManager()
    
    //MARK:- initializer
    private init(){}
    
    func signIn(email: String, password: String) -> AnyPublisher< Void, Error> {
        let subject = PassthroughSubject<Void, Error>()
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            if let error {
                subject.send(completion: .failure(error))
            }
                subject.send(completion: .finished)
        }
        return subject.handleEvents().eraseToAnyPublisher()
    }
    
    func signUp(name: String, email: String, password: String) -> AnyPublisher< Void, Error> {
        let subject = PassthroughSubject<Void, Error>()
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error {
                subject.send(completion: .failure(error))
            }
            let changeRequest = result!.user.createProfileChangeRequest()
            changeRequest.displayName = name
            changeRequest.commitChanges { error in
                if let error {
                    subject.send(completion: .failure(error))
                }
            }
                subject.send(completion: .finished)
        }
        return subject.handleEvents().eraseToAnyPublisher()
    }
    
}
