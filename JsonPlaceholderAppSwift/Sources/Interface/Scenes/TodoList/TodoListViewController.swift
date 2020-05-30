//
//  TodoListViewController.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 30/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

protocol TodoListDisplayLogic: class {
    
    func displayUserTodoList(viewModel: TodoList.UserTodoList.ViewModel)
    func displayUserTodoListError(viewModel: TodoList.UserTodoListError.ViewModel)
}

class TodoListViewController: UIViewController, TodoListDisplayLogic {

    var interactor: TodoListBusinessLogic?
    var router: (NSObjectProtocol & TodoListRoutingLogic & TodoListDataPassing)?
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var todos: [SingleTodo] = []
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        
        let viewController = self
        let interactor = TodoListInteractor()
        let presenter = TodoListPresenter()
        let router = TodoListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupView()
        trySetUserTodoList()
    }
    
    // MARK: Methods
    private func setupView() {
        
        navigationController?.navigationBar.isHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: "todoListTableViewCell")
        tableView.register(UINib(nibName: "TodoListTableViewCell", bundle: .main), forCellReuseIdentifier: "todoListTableViewCell")
    }
    
    // MARK: Actions
    @IBAction func close(_ sender: Any) {
        
        prepareForSelectedUser()
    }
}

// MARK: - Delegates
extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath) as? TodoListTableViewCell else {
            
            return UITableViewCell()
        }
        
        return cell
    }
}

// MARK: - Input
extension TodoListViewController {
    
    private func trySetUserTodoList() {
        
        let request = TodoList.UserTodoList.Request()
        interactor?.doSetUserTodoList(request: request)
    }
}

// MARK: - Output
extension TodoListViewController {
    
    func displayUserTodoList(viewModel: TodoList.UserTodoList.ViewModel) {
        
        todos = viewModel.todoList
        ui { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func displayUserTodoListError(viewModel: TodoList.UserTodoListError.ViewModel) {
        
        ErrorPopup.showErrorPopup(viewModel.error, vc: self)
    }
}

// MARK: - Route
extension TodoListViewController {
    
    private func prepareForSelectedUser() {
        
        router?.routeToSelectedUser()
    }
}
