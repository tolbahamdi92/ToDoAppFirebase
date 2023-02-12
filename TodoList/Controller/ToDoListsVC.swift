//
//  ToDoListsVC.swift
//  TodoList
//
//  Created by Tolba Hamdi on 1/28/23.
//

import UIKit
import Combine

class ToDoListsVC: UIViewController {

    //MARK:- IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var popupView: UIView!
    
    //MARK:- Properties
    var todosArr: [Todo] = []
    var cancelables = Set<AnyCancellable>()

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
        self .title = UserManager.shared.getCurrentUserName()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: PlaceholderImage.backArow) , style: .plain, target: self, action:  #selector(backBtnTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addToDoBtnTapped))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 25, weight: .medium), .foregroundColor : UIColor.white], for: .normal)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: Cells.toDoCell, bundle: nil), forCellReuseIdentifier: Cells.toDoCell)
    }
    private func getTodosList() {
        self.view.showLoader()
        ToDoManager.shared.getToDos()
            .sink { [weak self] error in
                guard let self else {return}
                self.view.hideLoader()
                if case let .failure(error) = error {
                    self.showAlert(title: Alerts.sorryTitle, message: error.localizedDescription)
                }
            } receiveValue: { todosList in
                self.view.hideLoader()
                if let todosList {
                    self.todosArr = todosList.sorted {
                        $0.date > $1.date
                    }
                    self.tableView.reloadData()
                }
            }
            .store(in: &cancelables)
    }
    
    private func removeTodo(with index: Int) {
        ToDoManager.shared.removeTodo(todosArr[index])
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
        cell.deleteTodo
            .handleEvents(receiveOutput: { [unowned self] index in
                self.removeTodo(with: index)
            })
            .sink { _ in }
            .store(in: &cancelables)
        return cell
    }
}

//MARK:- TableViewDelegate
extension ToDoListsVC: UITableViewDelegate {
}
