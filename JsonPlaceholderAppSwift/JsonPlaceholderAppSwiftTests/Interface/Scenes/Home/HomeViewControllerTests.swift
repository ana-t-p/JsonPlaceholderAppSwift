//
//  HomeViewControllerTests.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 31/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

@testable import JsonPlaceholderAppSwift
import XCTest

class HomeViewControllerTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: HomeViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    override func setUp() {
        
        super.setUp()
        window = UIWindow()
        setupHomeViewController()
    }
    
    override func tearDown() {
        
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupHomeViewController() {
        
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Home", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
    }
    
    func loadView() {
        
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    class HomeBusinessLogicSpy: HomeBusinessLogic, HomeRoutingLogic, HomeDataStore {

        var selectedUser: ChoosenUser? = ChoosenUser(id: 1, name: "FakeName", surname: "FakeSurname", email: "FakeEmail", phone: "123456789")
        
        var doGetUserListCalled = false
        var doGoToSelectedUserCalled = false
        
        func doGetUserList() {
            
            doGetUserListCalled = true
        }
        
        func doGoToSelectedUser(request: Home.SelectedUserResults.Request) {
            
            doGoToSelectedUserCalled = true
        }
        
        // Routing
        var routeToSelectedUserCalled = false
        
        func routeToSelectedUser() {
            
            routeToSelectedUserCalled = true
        }
    }
    
    // MARK: Tests
    func testEnableButton() {
        
        // Given
        let spy = HomeBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        
        // When
        sut.pushedButton(sut.nextButton ?? UIButton())
        
        // Then
        XCTAssertTrue(spy.doGoToSelectedUserCalled)
    }
    
    func testDidSelectRow() {
        
        // Given
        let spy = HomeBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        
        // When
        sut.pickerView(sut.pickerView, didSelectRow: 1, inComponent: 0)
        
        // Then
        XCTAssertEqual(sut.selectedUserId, 1)
    }
    
    func testDisplayGetUserList() {
        
        // Given
        let spy = HomeBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        
        // When
        let viewModel = Home.UsersResults.ViewModel(names: ["FakeName1", "FakeName2", "FakeName3"])
        sut.displayGetUserList(viewModel: viewModel)
        waitUI()
        
        // Then
        XCTAssertFalse(sut.pickerView.isHidden)
    }
    
    func testDisplayGetUserListError() {
        
        // Given
        let spy = HomeBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        
        // When
        let viewModel = Home.UsersResultsError.ViewModel(error: "FakeError")
        sut.displayGetUserListError(viewModel: viewModel)
        waitUI()
        
        // Then
        XCTAssertFalse(sut.activityIndicator.isAnimating)
    }
    
    func testDisplaySelectedUser() {
        
        // Given
        let spy = HomeBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        _ = UINavigationController(rootViewController: sut)
        
        // When
        let viewModel = Home.SelectedUserResults.ViewModel()
        sut.displaySelectedUser(viewModel: viewModel)
        waitUI()
        
        // Then
        XCTAssertEqual(sut.navigationController?.viewControllers.count, 2)
        XCTAssertTrue(sut.navigationController?.viewControllers.last is SelectedUserViewController)
    }
    
    func testDisplaySelectedUserError() {
        
        // Given
        let spy = HomeBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        
        // When
        let viewModel = Home.SelectedUserResultsError.ViewModel(error: "FakeError")
        sut.displaySelectedUserError(viewModel: viewModel)
        waitUI()
        
        // Then
        XCTAssertNotNil(sut.presentedViewController)
        XCTAssertTrue(sut.presentedViewController is UIAlertController)
    }
}
