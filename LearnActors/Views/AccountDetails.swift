//
//  AccountDetails.swift
//  LearnActors
//
//  Created by Diegoe012 on 5/09/24.
//

import SwiftUI

struct AccountDetails: View {
    
    @ObservedObject var bankAccount: BankAccountViewModel
    
    var body: some View {
        Text("Savings")
            .frame(maxWidth: .infinity, alignment: .leading)
        HStack {
            Text("\(bankAccount.getAccountNumber())")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Available Balance")
        }
        .frame(maxWidth: .infinity, alignment: .center)
        
        Text( "$" + String(format:"%.2f", bankAccount.currentBalance ?? 0))
            .frame(maxWidth: .infinity, alignment: .trailing)
            .bold()
        
        NavigationLink(destination: Movements(bankAccountViewModel: bankAccount)) {
            Text("View details and movements")
                .bold()
                .underline()
                .foregroundStyle(Color.black)
                .padding()
        }
    }
}

#Preview {
    AccountDetails(bankAccount: BankAccountViewModel(accountNumber: "212121", balance: 312313))
}
