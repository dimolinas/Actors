//
//  BankAccount.swift
//  LearnActors
//
//  Created by Diegoe012 on 5/09/24.
//

import Foundation

actor BankAccount {
    
    private let accountNumber: String
    private(set) var balance: Double
    private(set) var transactions: [Transaction] = []
    private var totalSeconds : Int = 0
    
    init(accountNumber: String, balance: Double) {
        self.balance = balance
        self.accountNumber = accountNumber
    }
    
    func getAccountNumber() -> String {
        return self.accountNumber
    }
    
    func getTotalSeconds() -> Int {
        return self.totalSeconds
    }
    
    func getBalance() -> Double {
        return self.balance
    }
    
    func withdraw(_ amount: Double) {
        if self.balance >= amount {
            let processingTime = UInt32.random(in: 0...3)
            sleep(processingTime)
            transactions.append(Transaction(id: UUID(), date: Date.now.description, value: -amount, description: "Withdraw"))
            self.balance -= amount
        }
    }
    
    func deposit(_ amount: Double) {
        self.balance += amount
        transactions.append(Transaction(id: UUID(), date: Date.now.description, value: amount, description: "Deposit"))
    }
    
    func transfer(amount: Double) async {
        if self.balance >= amount {
            let processingTime = UInt32.random(in: 0...3)
            sleep(processingTime)
            transactions.append(Transaction(id: UUID(), date: Date.now.description, value: -amount, description: "Transfer"))
            self.balance -= amount
            print("balance after transfer \(self.balance) wait: \(processingTime)")
            totalSeconds += Int(processingTime)
        }
    }
    
}
