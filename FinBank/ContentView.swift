//
//  ContentView.swift
//  FinBank
//
//  Created by Ricardo Valencia on 5/8/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TransactionListView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
