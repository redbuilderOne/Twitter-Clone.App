//
//  StorageManager.swift
//  Twitter Clone
//
//  Created by Дмитрий Скворцов on 26.11.2022.
//

import Foundation
import Combine
import FirebaseStorage
import FirebaseStorageCombineSwift

final class StorageManager {
    static let shared = StorageManager()

    let storage = Storage.storage().reference()

    func uploadProfilePhoto(with randomID: String, image: Data, metadata: StorageMetadata) -> AnyPublisher<StorageMetadata, Error> {
        return storage
            .child("images/\(randomID).jpg")
            .putData(image, metadata: metadata)
            .eraseToAnyPublisher()
    }

}
