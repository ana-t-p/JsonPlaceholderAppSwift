//
//  XCTestExtension.swift
//  JsonPlaceholderAppSwiftTests
//
//  Created by Ana Tirado Pro on 28/05/2020.
//  Copyright © 2020 Ana Tirado Pro. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func waitUI() {
        
        let desiredExpectation = expectation(description: "waiting")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            desiredExpectation.fulfill()
        }
        wait(for: [desiredExpectation], timeout: 1.5)
    }
}
