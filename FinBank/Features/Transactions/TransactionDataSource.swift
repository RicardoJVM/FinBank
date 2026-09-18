//
//  TransactionDataSource.swift
//  FinBank
//
//  Created by Ricardo Valencia on 5/8/26.
//

import Foundation

protocol TransactionDataSourceProtocol {
    func fetchTransactions() async throws -> [Transaction]
}

class TransactionDataSource: TransactionDataSourceProtocol {
    
    private var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchTransactions() async throws -> [Transaction] {
        try await networkManager.request(urlString: "https://api.v1/transactions")
    }
}

final class MockTransactionDataSource: TransactionDataSourceProtocol {
    func fetchTransactions() async throws -> [Transaction] {
        try await Task.sleep(nanoseconds: 500_000_000)
        return [
            Transaction(id: "1", date: "Supermercado", amount: 120.50, description: "2026-08-05"),
            Transaction(id: "2", date: "Transferencia Recibida", amount: 450.00, description: "2026-08-04")
            ]
    }
}
