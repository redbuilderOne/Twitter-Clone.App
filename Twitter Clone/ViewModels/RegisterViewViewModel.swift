//
//  RegisterViewViewModel.swift
//  Twitter Clone
//
//  Created by Дмитрий Скворцов on 31.10.2022.
//

import Foundation

final class RegisterViewViewModel: ObservableObject {

    @Published var email: String?
    @Published var password: String?
    @Published var isRegistrationFormValid: Bool = false

    func validateRegistrationForm() {
        guard let email = email,
              let password = password else {
            isRegistrationFormValid = false
            return
        }
        isRegistrationFormValid = isValidEmail(email) && password.count >= 8
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}
