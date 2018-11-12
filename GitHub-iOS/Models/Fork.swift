//
//  Fork.swift
//  GitHub-iOS
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import Foundation
import UIKit

public struct Fork: Decodable {
    public let id: Int?
    public let node_id: String?
    public let name: String?
    public let full_name: String?
    public let `private`: Bool?
    public let owner: RepositoryPersonal?
}
