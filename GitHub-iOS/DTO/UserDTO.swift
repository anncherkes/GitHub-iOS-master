//
//  UserDTO.swift
//  GitHub-iOS
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit

public class UserDTO: NSObject {
    
    public var login: String?
    public var id: Int?
    public var avatarURL: String?
    public var repoURL: String?
    
    public init(_ user: User) {
        super.init()
        self.login = user.login
        self.id = user.id
        self.avatarURL = user.avatar_url
        self.repoURL = user.repos_url
    }
}
