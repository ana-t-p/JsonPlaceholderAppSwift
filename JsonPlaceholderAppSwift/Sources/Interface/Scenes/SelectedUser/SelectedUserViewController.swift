//
//  SelectedUserViewController.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 29/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

protocol SelectedUserDisplayLogic: class {
    
    func displaySomething(viewModel: SelectedUser.Something.ViewModel)
}

class SelectedUserViewController: UIViewController, SelectedUserDisplayLogic {
    
    var interactor: SelectedUserBusinessLogic?
    var router: (NSObjectProtocol & SelectedUserRoutingLogic & SelectedUserDataPassing)?
    
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
        let interactor = SelectedUserInteractor()
        let presenter = SelectedUserPresenter()
        let router = SelectedUserRouter()
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
        doSomething()
    }
    
    func doSomething() {
        
        let request = SelectedUser.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: SelectedUser.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
