//
//  User.swift
//  FireB
//
//  Created by Vlad Tagunkov on 17/06/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import Foundation
import Firebase

struct UserB {
    let uid: String
    let email: String
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email!
    }
}
