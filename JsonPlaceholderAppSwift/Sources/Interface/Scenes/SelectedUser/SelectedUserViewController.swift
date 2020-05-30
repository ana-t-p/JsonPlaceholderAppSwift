//
//  SelectedUserViewController.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 29/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

protocol SelectedUserDisplayLogic: class {
    
    func displayUserInformation(viewModel: SelectedUser.UserInformation.ViewModel)
    func displayUserInformationError(viewModel: SelectedUser.UserInformationError.ViewModel)
    func displayUserDetails(viewModel: SelectedUser.UserDetails.ViewModel)
    func displayUserDetailsError(viewModel: SelectedUser.UserDetailsError.ViewModel)
}

class SelectedUserViewController: UIViewController, SelectedUserDisplayLogic {

    var interactor: SelectedUserBusinessLogic?
    var router: (NSObjectProtocol & SelectedUserRoutingLogic & SelectedUserDataPassing)?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionHolder: UIView!
    @IBOutlet weak var postsLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var buttonHolder: UIView!
    @IBOutlet weak var todoButton: UIButton!
    
    var posts: [String]?
    
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
        
        setupView()
        trySetUserInformation()
        tryGetUserDetails()
    }
    
    // MARK: Methods
    private func setupView() {
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PostsCollectionViewCell.self, forCellWithReuseIdentifier: "postsCollectionViewCell")
        collectionView.register(UINib(nibName: "PostsCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "postsCollectionViewCell")
        
        showLoading()
    }
    
    private func showLoading() {
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        thereArePosts(false)
        thereIsTodoList(false)
    }
    
    private func thereArePosts(_ existence: Bool) {
        
        postsLabel.isHidden = !existence
        collectionView.isHidden = !existence
    }
    
    private func thereIsTodoList(_ existence: Bool) {
        
        buttonHolder.isHidden = !existence
    }
    
    // MARK: Actions
    @IBAction func todoButtonAction(_ sender: Any) {
        
        prepareForUserTodoList()
    }
}

// MARK: - Delegates
extension SelectedUserViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (posts?.count ?? 1) - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postsCollectionViewCell", for: indexPath) as? PostsCollectionViewCell,
              let posts = posts else { return UICollectionViewCell ()}
        
        cell.setPost(posts[indexPath.row])
        return cell
    }
}

// MARK: - Input
extension SelectedUserViewController {
    
    private func trySetUserInformation() {
        
        let request = SelectedUser.UserInformation.Request()
        interactor?.doSetUserInformation(request: request)
    }
    
    private func tryGetUserDetails() {
        
        let request = SelectedUser.UserDetails.Request()
        interactor?.doGetUserDetails(request: request)
    }
}

// MARK: - Output
extension SelectedUserViewController {
    
    func displayUserInformation(viewModel: SelectedUser.UserInformation.ViewModel) {
        
        nameLabel.text = viewModel.name
        emailLabel.text = viewModel.email
        phoneLabel.text = viewModel.phone
    }
    
    func displayUserInformationError(viewModel: SelectedUser.UserInformationError.ViewModel) {
        
        ErrorPopup.showErrorPopup(viewModel.error, vc: self)
    }
    
    func displayUserDetails(viewModel: SelectedUser.UserDetails.ViewModel) {
        
        if let photo = viewModel.photo {
            
            imageView.image = photo
        }
        
        if let userPosts = viewModel.posts, !userPosts.isEmpty {
            
            posts = userPosts
            ui { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.thereArePosts(true)
                self?.collectionView.reloadData()
            }
        } else {
                
            ui { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.collectionHolder.isHidden = true
            }
        }
        
        thereIsTodoList(viewModel.thereAreTodos)
    }
    
    func displayUserDetailsError(viewModel: SelectedUser.UserDetailsError.ViewModel) {
        
        ErrorPopup.showErrorPopup(viewModel.error, vc: self)
    }
}

// MARK: - Route
extension SelectedUserViewController {
    
    private func prepareForUserTodoList() {
        
        router?.routeToUserTodoList()
    }
}
