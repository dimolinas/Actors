//
//  BankAccountViewModel.swift
//  LearnActors
//
//  Created by Diegoe012 on 5/09/24.
//

import Foundation

@MainActor
class BankAccountViewModel: ObservableObject {
    private var bankAccount: BankAccount
    private var accountNumber: String
    @Published var currentBalance: Double?
    @Published var transactions: [Transaction] = []
    
    init(accountNumber: String, balance: Double) {
        bankAccount = BankAccount(accountNumber: accountNumber, balance: balance)
        self.currentBalance = balance
        self.accountNumber = accountNumber
    }
    
    func withdraw(_ amount: Double) async {
        await bankAccount.withdraw(amount)
        self.transactions = await self.bankAccount.transactions
        self.currentBalance = await self.bankAccount.getBalance()
    }
    
    func deposit(_ amount: Double) async {
        await bankAccount.deposit(amount)
        self.currentBalance = await self.bankAccount.getBalance()
        self.transactions = await self.bankAccount.transactions
    }
    
    func tranfer(amount: Double, to other: BankAccountViewModel) async {
        await bankAccount.transfer(amount: amount)
        await other.deposit(amount)
        await other.update()
    }
    
    func update() async {
        // Perform asynchronous operations
        let balance = await self.bankAccount.getBalance()
        let transactions = await self.bankAccount.transactions
        
        // Update the main actor
        await MainActor.run {
            self.currentBalance = balance
            self.transactions = transactions
        }
    }

    
    func getAccountNumber() -> String {
        return self.accountNumber
    }
    
    func getTotalTimeTransaction() async-> Int {
        return await self.bankAccount.getTotalSeconds()
    }
}
