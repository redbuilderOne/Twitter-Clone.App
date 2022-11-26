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
    private var subscriptions: Set<AnyCancellable> = []

    @Published var displayName: String?
    @Published var userName: String?
    @Published var bio: String?
    @Published var avatarPath: String?
    @Published var imageData: UIImage?
    @Published var isFormVaild: Bool = false
    @Published var url: URL?
    @Published var error: String = ""

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

    func uploadAvatar() {

        let randomID = UUID().uuidString
        guard let imageData = imageData?.jpegData(compressionQuality: 0.5) else { return }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        StorageManager.shared.uploadProfilePhoto(with: randomID, image: imageData, metadata: metadata)
            .flatMap({ metadata in
                StorageManager.shared.getDownloadURL(for: metadata.path)
            })
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] url in
                self?.url = url
            }
            .store(in: &subscriptions)
    }
}
