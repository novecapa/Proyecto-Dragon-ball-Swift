//
//  LoginViewModel.swift
//  DragonBallSwift
//
//  Created by Jacob Aguilar on 29-07-24.
//

import Foundation
import SwiftUI

@Observable
class LoginViewModel {

    var showError: Bool = false
    var errorMessage: String = ""

    private let googleService: GoogleServiceProtocol

    init (googleService: GoogleServiceProtocol = GoogleService()) {
        self.googleService = googleService
    }

    @MainActor
    func signInWithGoogle(completion: @escaping(Bool) -> Void) {
        googleService.authenticate { result in
            switch result {
            case .success(let success):
                completion(success ? true : false)
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.showError = true
                completion(false)
            }
        }
    }
}
