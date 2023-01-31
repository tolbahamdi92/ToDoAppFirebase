//
//  ToDoListsVC.swift
//  TodoList
//
//  Created by Tolba Hamdi on 1/28/23.
//

import UIKit

class ToDoListsVC: UIViewController {

    //MARK:- IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var popupView: UIView!
    
    //MARK:- Properties
    var todosArr: [Todo] = []

    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
        getTodosList()
    }
}

//MARK:- Private Functions
extension ToDoListsVC {
    private func setupNavBar() {
        self.navigationController?.navigationBar.backgroundColor = Colors.purpleColor
        self.navigationItem.hidesBackButton = true
        self .title = UserFireBaseManager.shared.getCurrentUserName()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backArrow") , style: .plain, target: self, action:  #selector(backBtnTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addToDoBtnTapped))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 25, weight: .medium), .foregroundColor : UIColor.white], for: .normal)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.separatorColor = purpleColor
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "ToDoCell", bundle: nil), forCellReuseIdentifier: Cells.toDoCell)
    }
    private func getTodosList() {
        self.view.showLoader()
        ToDoFirebaseManager.shared.getToDos { (error, result) in
            self.view.hideLoader()
            if let error = error {
                self.showAlert(title: Alerts.sorryTitle, message: error.localizedDescription)
            } else {
                if let result = result {
                    self.todosArr = result
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc private func backBtnTapped(){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc private func addToDoBtnTapped(){
        let popupVC = UIStoryboard(name: StoryBoard.main, bundle: nil).instantiateViewController(withIdentifier: ViewController.addToDoVC)
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        present(popupVC, animated: true)
    }
}

//MARK:- TableViewDataSource
extension ToDoListsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todosArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.toDoCell, for: indexPath) as? ToDoCell else {
            return UITableViewCell()
        }
        cell.configureCell(todo: todosArr[indexPath.row])
        cell.deleteBtnOutlet.tag = indexPath.row
        cell.delegate = self
        return cell
    }
}

//MARK:- TableViewDelegate
extension ToDoListsVC: UITableViewDelegate {
    
    
}

//Mark:- RemoveTodoDelegate
extension ToDoListsVC: RemoveTodo {
    func removeTodo(with index: Int) {
        ToDoFirebaseManager.shared.removeTodo(todosArr[index])
    }
    
    
}
