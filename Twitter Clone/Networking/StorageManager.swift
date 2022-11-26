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

enum FireStorageErrors: Error {
    case invalidImageID
}

final class StorageManager {
    static let shared = StorageManager()

    let storage = Storage.storage()

    func getDownloadURL(for id: String?) -> AnyPublisher<URL, Error> {
        guard let id = id else {
            return Fail(error: FireStorageErrors.invalidImageID)
                .eraseToAnyPublisher()
        }
        return storage
            .reference(withPath: id)
            .downloadURL()
            .print()
            .eraseToAnyPublisher()
    }

    func uploadProfilePhoto(with randomID: String, image: Data, metadata: StorageMetadata) -> AnyPublisher<StorageMetadata, Error> {
        return storage
            .reference()
            .child("images/\(randomID).jpg")
            .putData(image, metadata: metadata)
            .print()
            .eraseToAnyPublisher()
    }

}
