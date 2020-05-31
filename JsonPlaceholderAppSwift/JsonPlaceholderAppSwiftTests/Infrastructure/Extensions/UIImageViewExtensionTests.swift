//
//  UIImageViewExtensionTests.swift
//  JsonPlaceholderAppSwiftTests
//
//  Created by Ana Tirado Pro on 31/05/2020.
//  Copyright © 2020 Ana Tirado Pro. All rights reserved.
//

import XCTest
@testable import JsonPlaceholderAppSwift

class UIImageViewExtensionTests: XCTestCase {

    func testLoad() {
    
        guard let url = URL(string: "https://via.placeholder.com/600/92c952") else { return }
        UIImage().load(url: url) { (image, error) in
            
            XCTAssertNotNil(image)
        }
        waitUI()
    }
}
