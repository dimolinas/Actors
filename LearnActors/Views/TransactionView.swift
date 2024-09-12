//
//  Transaction.swift
//  LearnActors
//
//  Created by Diegoe012 on 6/09/24.
//

import SwiftUI

struct TransactionView : View {
    let transaction: Transaction
    
    var body: some View {
        VStack{
            HStack {
                Text(transaction.date)
                    .bold()
                Spacer()
                
                Text("$ " + String(transaction.value))
                    .foregroundStyle(transaction.value >= 0 ? .green : .red)
                    .bold()
                
            }
            Text(transaction.description.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    TransactionView(transaction: Transaction(id: UUID(), date: "02 sep 2024", value: Double(2321321), description: "Hello world"))
}
