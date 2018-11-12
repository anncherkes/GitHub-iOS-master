//
//  RepositoryDTO.swift
//  GitHub-iOS
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit

public class RepositoryDTO: NSObject {
    public let avatarImage: String?
    public let repositoryName: String?
    public let repositoryDescription: String?
    public var watchersCount: Int = 0
    public var forksCount: Int = 0
    public let forksURL: String?
    
    public init(_ repo: RepositoryItem) {
        self.avatarImage = repo.owner?.avatar_url
        self.repositoryName = repo.name
        self.repositoryDescription = repo.description
        self.watchersCount = repo.watchers_count ?? 0
        self.forksCount = repo.forks_count ?? 0
        self.forksURL = repo.forks_url
    }
}
