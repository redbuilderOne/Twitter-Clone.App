//
//  AuthManager.swift
//  Twitter Clone
//
//  Created by Дмитрий Скворцов on 31.10.2022.
//

import Foundation
import Combine
import Firebase
import FirebaseAuthCombineSwift

class AuthManager {
    static let shared = AuthManager()

    func registerUser(with email: String, password: String) -> AnyPublisher<User, Error> {
        return Auth.auth().createUser(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }

}

