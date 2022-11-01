//
//  TwitterUser.swift
//  Twitter Clone
//
//  Created by Дмитрий Скворцов on 01.11.2022.
//

import Foundation
import Firebase

struct TwitterUser: Codable {
    let id: String
    var displayName: String = ""
    var userName: String = ""
    var followersCount: Double = 0
    var followingCount: Double = 0
    var createdOn: Date = Date()
    var bio: String = ""
    var avatarPath: String = ""
    var isUserOnboarded: Bool = false

    init(from user: User) {
        self.id = user.uid
    }

}
