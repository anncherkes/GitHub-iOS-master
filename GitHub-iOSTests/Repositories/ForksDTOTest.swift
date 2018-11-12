//
//  FoksDTOTest.swift
//  GitHub-iOSTests
//
//  Created by Anna Cherkes on 11/12/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit
import XCTest

@testable import GitHub_iOS

class ForksDTOTest: XCTestCase {
    
    let network = ForkNetworkManager(requestManager: RequestManagerMock())
    
    func testForkDTO() {
        
        let exp = self.expectation(description: "forkDTOTest")
        
        network.downloadForks(url: "https://api.github.com/repos/Datacup/dfhackscripts/forks") { (data, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(data)            
            let first = data?.first

            XCTAssertNotNil(first)
            XCTAssertNotNil(first?.full_name)
            XCTAssertNotNil(first?.id)
            XCTAssertNotNil(first?.name)
            XCTAssertNotNil(first?.node_id)
            XCTAssertNotNil(first?.owner)
            XCTAssertNotNil(first?.private)

            guard let item = first else { fatalError("FatalError: first is nil")}

            let forkDTO = ForkDTO(item)

            XCTAssertEqual(first?.full_name, forkDTO.fullName)
            XCTAssertEqual(first?.id, forkDTO.id)
            XCTAssertEqual(first?.name, forkDTO.name)
            XCTAssertEqual(first?.owner?.login, forkDTO.ownerLogin)
            XCTAssertEqual(first?.owner?.avatar_url, forkDTO.ownerAvatarURL)

             exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }
}
