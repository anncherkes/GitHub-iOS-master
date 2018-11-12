//
//  ForkDTO.swift
//  GitHub-iOS
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import Foundation
import UIKit

public class ForkDTO: NSObject {
    public let id: Int?
    public let name: String?
    public let fullName: String?
    public let ownerLogin: String?
    public let ownerAvatarURL: String?
    
    public init(_ fork: Fork) {
        self.id = fork.id
        self.name = fork.name
        self.fullName = fork.full_name
        self.ownerLogin = fork.owner?.login
        self.ownerAvatarURL = fork.owner?.avatar_url
    }
}
