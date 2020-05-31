//
//  SelectedUserViewControllerTests.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 31/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

@testable import JsonPlaceholderAppSwift
import XCTest

class SelectedUserViewControllerTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: SelectedUserViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    override func setUp() {
        
        super.setUp()
        window = UIWindow()
        setupSelectedUserViewController()
    }
    
    override func tearDown() {
        
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupSelectedUserViewController() {
        
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "SelectedUser", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "SelectedUserViewController") as? SelectedUserViewController
    }
    
    func loadView() {
        
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    class SelectedUserBusinessLogicSpy: SelectedUserBusinessLogic, SelectedUserRoutingLogic {

        var doSetUserInformationCalled = false
        var doGetUserDetailsCalled = false
        
        func doSetUserInformation(request: SelectedUser.UserInformation.Request) {
            
            doSetUserInformationCalled = true
        }
        
        func doGetUserDetails(request: SelectedUser.UserDetails.Request) {
            
            doGetUserDetailsCalled = true
        }
        
        // Routing
        var routeToUserTodoListCalled = false
        
        func routeToUserTodoList() {
            
            routeToUserTodoListCalled = true
        }
    }
    
    // MARK: Tests
    func testTodoButtonAction() {
        
        // Given
        let spy = SelectedUserBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        
        // When
        sut.todoButtonAction(sut.todoButton ?? UIButton())
        
        // Then
        XCTAssertNotNil(sut.presentedViewController)
        XCTAssertTrue(sut.presentedViewController is TodoListViewController)
    }
    
    func testNumberOfItemsInSection() {
        
        // Given
        let spy = SelectedUserBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        sut.posts = ["FakePost1", "FakePost2"]
        
        // When
        let numItems = sut.collectionView(sut.collectionView, numberOfItemsInSection: 0)
        
        // Then
        XCTAssertEqual(numItems, sut.posts?.count)
    }
    
    func testCellForItemAt() {
        
        // Given
        let spy = SelectedUserBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        sut.posts = ["FakePost1", "FakePost2"]
        
        // When
        let cell = sut.collectionView(sut.collectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as? PostsCollectionViewCell
        
        // Then
        XCTAssertEqual(cell?.postLabel.text, sut.posts?.first)
    }
    
    func testDisplayUserInformation() {
        
        // Given
        let spy = SelectedUserBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        sut.posts = ["FakePost1", "FakePost2"]
        
        // When
        let viewModel = SelectedUser.UserInformation.ViewModel(name: "FakeName", email: "FakeEmail", phone: "123456789")
        sut.displayUserInformation(viewModel: viewModel)
        
        // Then
        XCTAssertEqual(sut.nameLabel.text, viewModel.name)
        XCTAssertEqual(sut.emailLabel.text, viewModel.email)
        XCTAssertEqual(sut.phoneLabel.text, viewModel.phone)
    }
    
    func testdisplayUserInformationError() {
        
        // Given
        let spy = SelectedUserBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        sut.posts = ["FakePost1", "FakePost2"]
        
        // When
        let viewModel = SelectedUser.UserInformationError.ViewModel(error: "FakeError")
        sut.displayUserInformationError(viewModel: viewModel)
        waitUI()

        // Then
        XCTAssertNotNil(sut.presentedViewController)
        XCTAssertTrue(sut.presentedViewController is UIAlertController)
    }
    
    func testDisplayUserDetails() {
        
        // Given
        let spy = SelectedUserBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        sut.posts = ["FakePost1", "FakePost2"]
        
        // When
        let viewModel = SelectedUser.UserDetails.ViewModel(photo: UIImage(), posts: ["FakePost"], thereAreTodos: true)
        sut.displayUserDetails(viewModel: viewModel)
        waitUI()
        
        // Then
        XCTAssertNotNil(sut.imageView.image)
        XCTAssertNotNil(sut.posts)
        XCTAssertFalse(sut.buttonHolder.isHidden)
        
        // When
        let viewModel2 = SelectedUser.UserDetails.ViewModel(photo: UIImage(), posts: [], thereAreTodos: true)
        sut.displayUserDetails(viewModel: viewModel2)
        waitUI()
        
        // Then
        XCTAssertTrue(sut.collectionHolder.isHidden)
    }
    
    
    func testDisplayUserDetailsError() {
        
        // Given
        let spy = SelectedUserBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        sut.posts = ["FakePost1", "FakePost2"]
        
        // When
        let viewModel = SelectedUser.UserDetailsError.ViewModel(error: "FakeError")
        sut.displayUserDetailsError(viewModel: viewModel)
        waitUI()
        
        // Then
        XCTAssertNotNil(sut.presentedViewController)
        XCTAssertTrue(sut.presentedViewController is UIAlertController)
    }
}
