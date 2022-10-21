//
//  Account.swift
//  Actor-POC
//
//  Created by Ashok Rawat on 17/10/22.
//

import Foundation

actor Account {
    var balance: Double
    var transactions: [String] = []
    
    init(balance: Double) {
        self.balance = balance
    }
    
    func getBalance() -> Double {
        return self.balance
    }
    
    func withdraw(amount: Double) {
        
        if balance >= amount {
            let processingTime = UInt32.random(in: 0...3)
            print("[Withdraw] Processing for \(amount) \(processingTime) seconds")
            transactions.append("[Withdraw] Processing for \(amount) \(processingTime) seconds")
            sleep(processingTime)
            print("Withdrawing \(amount) from account")
            transactions.append("Withdrawing \(amount) from account")
            
            self.balance -= amount
            
            print("Balance is \(balance)")
            transactions.append("Balance is \(balance)")
        }
    }
}
