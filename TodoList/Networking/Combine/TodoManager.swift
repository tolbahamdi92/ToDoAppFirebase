//
//  TodoManager.swift
//  TodoList
//
//  Created by Tolba Hamdi on 2/12/23.
//

import Foundation
import Combine
import FirebaseFirestore

struct ToDoManager {
    
    //MARK:- Properties
    static let shared = ToDoManager()
    private let db = Firestore.firestore()
    private let userId = UserManager.shared.getCurrentUserID() ?? ""
    
    //MARK:- initializer
    private init(){}
    
    //MARK:- saveToDo
    func saveToDo(time: String, content: String) -> AnyPublisher< Void, Error> {
        let subject = PassthroughSubject<Void, Error>()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        let date = formatter.date(from: time) ?? Date()
        let data = [ToDoKeys.date: Timestamp(date: date), ToDoKeys.content: content] as [String : Any]
        db.collection(FireBase.toDosColl).document(userId).collection(FireBase.toDosUser).document().setData(data) { error in
            if let error {
                subject.send(completion: .failure(error))
            }
            subject.send(completion: .finished)
        }
        return subject.handleEvents().eraseToAnyPublisher()
    }
    
    //MARK:- getToDos
    func getToDos() -> AnyPublisher< [Todo]?, Error> {
        let subject = PassthroughSubject<[Todo]?, Error>()
        var todoArr: [Todo]? = []
        let listener = db.collection(FireBase.toDosColl).document(userId).collection(FireBase.toDosUser)
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    subject.send(completion: .failure(error!))
                    return
                }
                
                todoArr = documents.map { (queryDocumentSnapshot) -> Todo in
                    let data = queryDocumentSnapshot.data()
                    let timeStamp = data[ToDoKeys.date] as! Timestamp
                    let content = data[ToDoKeys.content] as! String
                    let date = timeStamp.dateValue()
                    return Todo(date: date, content: content)
                }
                subject.send(todoArr)
            }
        return subject.handleEvents(receiveCancel: {
            listener.remove()
        }).eraseToAnyPublisher()
    }
    
    //MARK:- removeTodo
    func removeTodo(_ todo: Todo) {
        let ref =  db.collection(FireBase.toDosColl).document(userId).collection(FireBase.toDosUser)
        ref.whereField(ToDoKeys.content, isEqualTo: todo.content)
            .whereField(ToDoKeys.date, isEqualTo: Timestamp(date: todo.date))
            .getDocuments { (querySnapshot, error) in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    for document in querySnapshot!.documents {
                        document.reference.delete()
                    }
                }
            }
    }
}
