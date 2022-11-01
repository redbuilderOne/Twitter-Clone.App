//
//  ProfileDataFormViewViewModel.swift
//  Twitter Clone
//
//  Created by Дмитрий Скворцов on 01.11.2022.
//

import Foundation
import Combine

final class ProfileDataFormViewViewModel: ObservableObject {

    @Published var displayName: String?
    @Published var userName: String?
    @Published var bio: String?
    @Published var avatarPath: String?

}
