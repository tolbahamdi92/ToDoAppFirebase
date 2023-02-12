//
//  ToDoCell.swift
//  TodoList
//
//  Created by Tolba Hamdi on 1/31/23.
//

import UIKit
import Combine

class ToDoCell: UITableViewCell {
    
    //MARK:- IBOutlet
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var deleteBtnOutlet: UIButton!
    
    //MARK:- Properities
    let deleteTodo = PassthroughSubject<Int, Never>()
    
    //MARK:- IBAction
    @IBAction func deleteBtnTapped(_ sender: UIButton) {
        deleteTodo.send(sender.tag)
    }
    
    //MARK:- configureCell Function
    func configureCell(todo: Todo) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        dateAndTimeLabel.text = formatter.string(from: todo.date)
        contentLabel.text = todo.content
    }
}
