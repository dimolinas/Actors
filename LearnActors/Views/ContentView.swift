//
//  ContentView.swift
//  LearnActors
//
//  Created by Diegoe012 on 5/09/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var accountOne: BankAccountViewModel
    @ObservedObject var accountTwo: BankAccountViewModel
    
    let semaphore = DispatchSemaphore(value: 10)
    let queue = DispatchQueue(label: "ConcurrentQueue", attributes: .concurrent)
    
    let dispatchGroup = DispatchGroup()
    let queueGlobal = DispatchQueue.global(qos: .userInitiated)
    
    var body: some View {
        NavigationStack{
            VStack {
        
                Header(firstTitle: "TRANSACTIONS", secondTitle: "Balance and movements")
                                
                HStack {
                    VStack {
                        VStack {
                            HStack {
                                Image(systemName: "dollarsign.square")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(Color.black)
                                
                                Text("Accounts")
                                
                                Spacer()
                                
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .shadow(color: Color.black ,radius: 2)
                            )
                            
                        }
                        
                        VStack {
                            Text("Account")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .bold()
                            
                            Divider()
                            
                            AccountDetails(bankAccount: accountOne)
                            
                            HStack{
                                Button("Withdraw", systemImage:"tray.and.arrow.down.fill") {
                                    Task.detached {
                                        await accountOne.withdraw(200)
                                    }
                                    
                                    Task.detached {
                                        await accountOne.withdraw(500)
                                    }
                                }
                                
                        
                                Button("Sent ", systemImage:"paperplane.fill") {
                                    Task {
                                        let totalTask = 100
                                        print("Start")
                                        let startDate = Date()
                                        
                                        await withTaskGroup(of: Void.self){ group in
                                            for _ in 0..<totalTask {
                                                group.addTask(priority: .high){
                                                    await accountOne.tranfer(amount:1, to:accountTwo)
                                                }
                                                await accountOne.update()
                                            }
                                            await accountOne.update()
                                        }
                                        
                                        print("End")
                                        let endtime = Date()
                                        print("Real: ", endtime.timeIntervalSince(startDate))
                                        print("Theorical: ",  await accountOne.getTotalTimeTransaction())
                                        
                                    }
                                    
                                }
                            }
                            
                            Divider()
                            
                            AccountDetails(bankAccount: accountTwo)
                            
                            HStack{
                                Button("Withdraw", systemImage:"tray.and.arrow.down.fill") {
                                    Task.detached {
                                        await accountTwo.withdraw(200)
                                    }
                                    
                                    Task.detached {
                                        await accountTwo.withdraw(500)
                                    }
                                }
                                
                                Button("Sent ", systemImage:"paperplane.fill") {
                                    DispatchQueue.concurrentPerform(iterations: 100){ _ in
                                        Task{
                                            await accountTwo.tranfer(amount:1, to: accountOne)
                                        }
                                    }
                                }
                            }
                            
                            
                        }
                        .padding()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(color: Color.black, radius: 2)
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
    
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
    
    }
}

#Preview {
    ContentView(accountOne: BankAccountViewModel(accountNumber: "123-45632237-89", balance: 2500000), accountTwo: BankAccountViewModel(accountNumber: "123-45632237-89", balance: 2500000))
}
