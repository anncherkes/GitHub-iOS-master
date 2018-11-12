//
//  LoginServiseMock.swift
//  GitHub-iOSTests
//
//  Created by Anna Cherkes on 11/12/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import Foundation
import UIKit

@testable import GitHub_iOS

class LoginServiseMock:  LoginServiseProtocol {
    
    func isUserLogged() -> Bool {
        return true
    }
    func token() -> String? {
        return ""
    }
    func login() -> String? {
        return "anncherkes"
    }
    func save(token: String?, login: String?) {
        
    }
}
