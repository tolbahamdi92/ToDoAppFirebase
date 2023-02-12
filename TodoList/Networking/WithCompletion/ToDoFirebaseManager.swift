//
//  ToDoFirebaseManager.swift
//  TodoList
//
//  Created by Tolba Hamdi on 1/30/23.
//

import UIKit
import FirebaseFirestore

class ToDoFirebaseManager {
    
    //MARK:- Properties
    static let shared = ToDoFirebaseManager()
    let db = Firestore.firestore()
    
    //MARK:- initializer
    private init(){}
    
    //MARK:- saveToDo
    func saveToDo(time: String, content: String, completion: @escaping (Error?) -> Void) {
        let userId = UserFireBaseManager.shared.getCurrentUserID() ?? ""
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        let date = formatter.date(from: time) ?? Date()
        let data = [ToDoKeys.date: Timestamp(date: date), ToDoKeys.content: content] as [String : Any]
        db.collection(FireBase.toDosColl).document(userId).collection(FireBase.toDosUser).document().setData(data) { error in
            completion(error)
        }
    }
    
    //MARK:- getToDos
    func getToDos(completion: @escaping (Error?,[Todo]?) -> Void) {
        var todoArr: [Todo]? = []
        let userId = UserFireBaseManager.shared.getCurrentUserID() ?? ""
        db.collection(FireBase.toDosColl).document(userId).collection(FireBase.toDosUser)
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    completion(error,nil)
                    return
                }
                
                todoArr = documents.map { (queryDocumentSnapshot) -> Todo in
                    let data = queryDocumentSnapshot.data()
                    let timeStamp = data[ToDoKeys.date] as! Timestamp
                    let content = data[ToDoKeys.content] as! String
                    let date = timeStamp.dateValue()
                    return Todo(date: date, content: content)
                }
                completion(nil,todoArr)
            }
    }
    
    //MARK:- removeTodo
    func removeTodo(_ todo: Todo) {
        let userId = UserFireBaseManager.shared.getCurrentUserID() ?? ""
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
