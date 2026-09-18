//
//  TransactionViewModel.swift
//  FinBank
//
//  Created by Ricardo Valencia on 5/8/26.
//

import SwiftUI
internal import Combine

enum State {
    case idle
    case loading
    case error(String)
    case success([Transaction])
}

@MainActor
final class TransactionViewModel: ObservableObject {
    @Published private(set) var state: State = .idle
    private let repository: TransactionRepositoryProtocol
    
    init(repository: TransactionRepositoryProtocol? = nil) {
        self.repository = repository ?? TransactionRepository()
    }
    
    func getTransactions() async {
        state = .loading
        
        Task {
            do {
                let transactions = try await repository.getTransactions()
                state = .success(transactions)
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
}
