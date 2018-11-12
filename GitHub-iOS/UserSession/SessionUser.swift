//
//  UserSession.swift
//  GitHub-iOS
//
//  Created by Anna Cherkes on 11/11/18.
//  Copyright © 2018 Anna Cherkes. All rights reserved.
//

import UIKit

let sessionKeyName = "github.session"

class UserSession: NSObject, NSCoding {
    
    private static var currentSession: UserSession?
    var login: String?
    var token: String?
    
    class func sharedSession() -> UserSession {
        
        if let session = UserSession.currentSession {
            return session
        }
        
        let defaults = UserDefaults.standard
        let userSession = UserSession()
        
        
        if let savedSettings = defaults.object(forKey: sessionKeyName) as? NSData {
            do {
                guard let userSession = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedSettings as Data)  as? UserSession else {
                    fatalError("Can't saved")
                }
                return userSession
            } catch {
                fatalError("Can't saved: \(error)")
            }
        }
    
        UserSession.currentSession = userSession
        return userSession
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(login, forKey: "login")
        aCoder.encode(token, forKey: "token")
    }
    
    func killSession(session : UserSession) {
        session.login = nil
        session.token = nil
    }
    
    convenience required init?(coder aDecoder: NSCoder)  {
        self.init()
        decodeData(aDecoder: aDecoder)
    }
    
    private final func decodeData(aDecoder: NSCoder) {
        login = aDecoder.decodeObject(forKey: "login") as? String ?? nil
        token = aDecoder.decodeObject(forKey: "token") as? String ?? nil
    }
    
    func save() {
        do {
            let savedData = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: sessionKeyName)
            defaults.synchronize()
        } catch {
            print("Can`t saved settings")
        }
    }
    
    func delete() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: sessionKeyName)
        defaults.removeObject(forKey: "login")
        defaults.removeObject(forKey: "token")
        defaults.synchronize()
    }
}
