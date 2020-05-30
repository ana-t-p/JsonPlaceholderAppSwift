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
    func displayUserPosts(viewModel: SelectedUser.UserPosts.ViewModel)
    func displayUserPostsError(viewModel: SelectedUser.UserPostsError.ViewModel)
    func displayUserPhoto(viewModel: SelectedUser.UserPhoto.ViewModel)
    func displayUserPhotoError(viewModel: SelectedUser.UserPhotoError.ViewModel)
}

class SelectedUserViewController: UIViewController, SelectedUserDisplayLogic {

    var interactor: SelectedUserBusinessLogic?
    var router: (NSObjectProtocol & SelectedUserRoutingLogic & SelectedUserDataPassing)?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var collectionHolder: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
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
        tryGetUserPhoto()
        tryGetUserPosts()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
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
        
        collectionView.isHidden = true
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
    
    // MARK: Actions
    @IBAction func todoButtonAction(_ sender: Any) {
        
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
    
    private func tryGetUserPhoto() {
        
        let request = SelectedUser.UserPhoto.Request()
        interactor?.doGetUserPhoto(request: request)
    }
    
    private func tryGetUserPosts() {
        
        let request = SelectedUser.UserPosts.Request()
        interactor?.doGetUserPosts(request: request)
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
    
    func displayUserPhoto(viewModel: SelectedUser.UserPhoto.ViewModel) {
        
        imageView.image = viewModel.photo
    }
    
    func displayUserPhotoError(viewModel: SelectedUser.UserPhotoError.ViewModel) {
        
        ErrorPopup.showErrorPopup(viewModel.error, vc: self)
    }
    
    
    func displayUserPosts(viewModel: SelectedUser.UserPosts.ViewModel) {
        
        posts = viewModel.posts
        ui { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.collectionView.isHidden = false
            self?.collectionView.reloadData()
        }
    }
    
    func displayUserPostsError(viewModel: SelectedUser.UserPostsError.ViewModel) {
        
        ui { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.collectionHolder.isHidden = true
        }
        ErrorPopup.showErrorPopup(viewModel.error, vc: self)
    }
}
