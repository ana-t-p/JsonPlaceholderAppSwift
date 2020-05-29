//
//  HomeViewController.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 28/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: class {
    
    func displayGetUserList(viewModel: Home.UserResults.ViewModel)
    func displayGetUserListError(viewModel: Home.UserResultsError.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var names: [String] = ["---"]
    
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
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
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
        
        pickerView.delegate = self
        pickerView.dataSource = self
        showLoading()
        tryGetUserList()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    // MARK: Methods
    private func showLoading() {
        
        subtitleLabel.isHidden = true
        pickerView.isHidden = true
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
}

// MARK: - Delegates
extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return names.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return names[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
    }
}

// MARK: - Input
extension HomeViewController {
    
    private func tryGetUserList() {
        
        interactor?.doGetUserList()
    }
}

// MARK: - Output
extension HomeViewController {
    
    func displayGetUserList(viewModel: Home.UserResults.ViewModel) {
        
        names.append(contentsOf: viewModel.names)
        ui { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.subtitleLabel.isHidden = false
            self?.pickerView.isHidden = false
            self?.pickerView.reloadAllComponents()
        }
    }
    
    func displayGetUserListError(viewModel: Home.UserResultsError.ViewModel) {
        
        ui { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
}

// MARK: - Routing
extension HomeViewController {
    
    private func prepareForSelectedUser() {
        
        router?.routeToSelectedUser()
    }
}
