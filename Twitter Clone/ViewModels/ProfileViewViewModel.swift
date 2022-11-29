//
//  ProfileViewViewModel.swift
//  Twitter Clone
//
//  Created by Дмитрий Скворцов on 29.11.2022.
//

import Foundation
import Combine
import FirebaseAuth

final class ProfileViewViewModel: ObservableObject {

    private var subscriptions: Set<AnyCancellable> = []

    @Published var user: TwitterUser?
    @Published var error: String?

    func retreiveUser() {
        guard let id = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.collectionUsers(retreive: id)
            .sink { [weak self] completion in

                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }

            } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &subscriptions)
    }


}
