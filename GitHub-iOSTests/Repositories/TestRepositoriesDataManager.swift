//
//  TestRepositoriesDataManager.swift
//  GitHub-iOSTests
//
//  Created by Anna Cherkes on 11/12/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import Foundation
import UIKit
import XCTest

@testable import GitHub_iOS

class TestRepositoriesDataManager: XCTestCase {
    
    let network = RepositoriesNetworkManager(requestManager: RequestManagerMock())
    let loginServise = LoginServiseMock()
    
    func testRepositoriesDataManager() {
        
        let exp = self.expectation(description: "testRepositoriesDataManager")
        
        let dataManager = RepositoriesDataManager()
        loginServise.save(token: nil, login: "anncherkes")
        dataManager.setNetwork(network, loginServise: loginServise)
        
        dataManager.getPersonalRepositories { (items, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(items)
            
            let first = items?.first
            XCTAssertNotNil(first)
            XCTAssertNotNil(first?.avatarImage)
            XCTAssertNotNil(first?.forksURL)
            XCTAssertNotNil(first?.repositoryName)
            XCTAssertNotNil(first?.watchersCount)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 15)
    }
}

