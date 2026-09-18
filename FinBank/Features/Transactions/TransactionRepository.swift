//
//  TransactionRepository.swift
//  FinBank
//
//  Created by Ricardo Valencia on 5/8/26.
//

import Foundation

protocol TransactionRepositoryProtocol {
    func getTransactions() async throws -> [Transaction]
}

class TransactionRepository: TransactionRepositoryProtocol {
    private let dataSource: TransactionDataSourceProtocol
    
    init(dataSource: TransactionDataSourceProtocol = MockTransactionDataSource()) {
        self.dataSource = dataSource
    }
    
    func getTransactions() async throws -> [Transaction] {
        return try await dataSource.fetchTransactions()
    }
}
