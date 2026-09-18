//
//  TransactionListView.swift
//  FinBank
//
//  Created by Ricardo Valencia on 5/8/26.
//

import SwiftUI

struct TransactionListView: View {
   @StateObject var viewModel = TransactionViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                    case .idle, .loading:
                        ProgressView("Loading Data...")
                    case .success(let items):
                        List(items) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.description).font(.headline)
                                    Text(item.date).font(.caption).foregroundColor(.gray)
                                }
                                Spacer()
                                Text("$\(item.amount)").bold()
                            }
                        }
                case .error(let error):
                    VStack(spacing: 12) {
                        Text(error).foregroundColor(.red)
                        Button("Retry") {
                            Task { await viewModel.getTransactions() }
                        }
                    }
                }
            }
            .navigationTitle("Transactions")
            .task {
                await viewModel.getTransactions()
            }
        }
    }
}

#Preview {
    TransactionListView()
}
