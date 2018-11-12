//
//  RepositoryDTOTest.swift
//  GitHub-iOSTests
//
//  Created by Anna Cherkes on 11/12/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import XCTest

@testable import GitHub_iOS

class RepositoryDTOTest: XCTestCase {

    let network = RepositoriesNetworkManager(requestManager: RequestManagerMock())
    
    func testRepositoryDTO() {
        
        let exp = self.expectation(description: "repositoryDTOTest")
        
        network.getRepositories(with: "Alomofire-swift") { (data, error) in
            
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            XCTAssertEqual(data?.items?.count, 3)
            
            let first = data?.items?.first
            
            XCTAssertNotNil(first)
            XCTAssertNotNil(first?.name)
            XCTAssertNotNil(first?.owner)
            XCTAssertNotNil(first?.owner?.login)
            XCTAssertNotNil(first?.owner?.avatar_url)
            XCTAssertNotNil(first?.description)
            XCTAssertNotNil(first?.watchers_count)
            XCTAssertNotNil(first?.forks_count)
            XCTAssertNotNil(first?.forks_url)
            
            guard let item = first else { fatalError("first is nil")}
            
            let repositoryDTO = RepositoryDTO(item)
            
            XCTAssertEqual(first?.name, repositoryDTO.repositoryName)
            XCTAssertEqual(first?.forks_url, repositoryDTO.forksURL)
            XCTAssertEqual(first?.forks_count, repositoryDTO.forksCount)
            XCTAssertEqual(first?.owner?.avatar_url, repositoryDTO.avatarImage)
            XCTAssertEqual(first?.description, repositoryDTO.repositoryDescription)
            XCTAssertEqual(first?.watchers_count, repositoryDTO.watchersCount)
            
            exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }
}
