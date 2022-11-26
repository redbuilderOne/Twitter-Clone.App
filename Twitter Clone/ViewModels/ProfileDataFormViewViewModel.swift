//
//  ProfileDataFormViewViewModel.swift
//  Twitter Clone
//
//  Created by Дмитрий Скворцов on 01.11.2022.
//

import UIKit
import Combine
import FirebaseAuth
import FirebaseStorage

final class ProfileDataFormViewViewModel: ObservableObject {
    @Published var displayName: String?
    @Published var userName: String?
    @Published var bio: String?
    @Published var avatarPath: String?
    @Published var imageData: UIImage?
    @Published var isFormVaild: Bool = false

    func validateUserProfileForm() {
        guard let displayName = displayName,
        displayName.count > 2,
        let userName = userName,
        userName.count > 2,
        let bio = bio,
        bio.count > 2,
        imageData != nil else {
            isFormVaild = false
            return
        }
        isFormVaild = true

    }
}
