//
//  LearnActorsApp.swift
//  LearnActors
//
//  Created by Diegoe012 on 5/09/24.
//

import SwiftUI

@main
struct LearnActorsApp: App {
    
    @StateObject var bankAccountViewModel = BankAccountViewModel(accountNumber: "123-45632237-89", balance: 1000)
    @StateObject var secondBankAccountViewModel = BankAccountViewModel(accountNumber: "4324-43242-43", balance: 1000)
    
    var body: some Scene {
        WindowGroup {
            ContentView(accountOne: bankAccountViewModel, accountTwo: secondBankAccountViewModel)
        }
    }
}
