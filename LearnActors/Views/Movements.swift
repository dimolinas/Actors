//
//  Movements.swift
//  LearnActors
//
//  Created by Diegoe012 on 5/09/24.
//

import SwiftUI

struct Movements: View {
    @ObservedObject var bankAccountViewModel: BankAccountViewModel
    
    var body: some View {
        VStack {
            Header(firstTitle: "Accounts", secondTitle: "Account")
            
            AccountDetails(bankAccount: bankAccountViewModel)
            
            Divider()
             
            List(bankAccountViewModel.transactions, id: \.self) { transition in
                TransactionView(transaction: transition)
            }
            .frame(maxWidth: .infinity)
            .listStyle(.plain)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    Movements(bankAccountViewModel: BankAccountViewModel(accountNumber: "12121-323232", balance: 213123))
}
