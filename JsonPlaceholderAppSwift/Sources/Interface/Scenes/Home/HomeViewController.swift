//
//  HomeViewController.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 28/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: class {
    
    func displayGetUserList(viewModel: Home.UsersResults.ViewModel)
    func displayGetUserListError(viewModel: Home.UsersResultsError.ViewModel)
    func displaySelectedUser(viewModel: Home.SelectedUserResults.ViewModel)
    func displaySelectedUserError(viewModel: Home.SelectedUserResultsError.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var nextButton: UIButton!

    var names: [String] = ["---"]
    var selectedUserId = 0
    
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
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Select neighbour", style: .plain, target: nil, action: nil)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        showLoading()
        tryGetUserList()
    }
    
    // MARK: Methods
    private func showLoading() {
        
        subtitleLabel.isHidden = true
        pickerView.isHidden = true
        nextButton.isHidden = true
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
    
    private func enableButton(_ enable: Bool) {
        
        nextButton.isUserInteractionEnabled = enable
        nextButton.isEnabled = enable
        nextButton.alpha = enable == true ? 0.9 : 0.1
    }
    
    // MARK: Actions
    @IBAction func pushedButton(_ sender: Any) {
        
        tryGoToSelectedUser()
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
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        return NSAttributedString(string: names[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        enableButton(row == 0 ? false : true)
        selectedUserId = row
    }
}

// MARK: - Input
extension HomeViewController {
    
    private func tryGetUserList() {
        
        interactor?.doGetUserList()
    }
    
    private func tryGoToSelectedUser() {
        
        let request = Home.SelectedUserResults.Request.init(id: selectedUserId)
        interactor?.doGoToSelectedUser(request: request)
    }
}

// MARK: - Output
extension HomeViewController {
    
    func displayGetUserList(viewModel: Home.UsersResults.ViewModel) {
        
        names.append(contentsOf: viewModel.names)
        ui { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.subtitleLabel.isHidden = false
            self?.pickerView.isHidden = false
            self?.pickerView.reloadAllComponents()
            self?.nextButton.isHidden = false
            self?.enableButton(false)
        }
    }
    
    func displayGetUserListError(viewModel: Home.UsersResultsError.ViewModel) {
        
        ui { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
        ErrorPopup.showErrorPopup(viewModel.error, vc: self)
    }
    
    func displaySelectedUser(viewModel: Home.SelectedUserResults.ViewModel) {
        
        router?.routeToSelectedUser()
    }
    
    func displaySelectedUserError(viewModel: Home.SelectedUserResultsError.ViewModel) {
        
        ErrorPopup.showErrorPopup(viewModel.error, vc: self)
    }
}
