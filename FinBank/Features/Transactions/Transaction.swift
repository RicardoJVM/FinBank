//
//  Transaction.swift
//  FinBank
//
//  Created by Ricardo Valencia on 5/8/26.
//

import Foundation

struct Transaction: Codable, Identifiable {
    let id: String
    let date: String
    let amount: Double
    let description: String
}
