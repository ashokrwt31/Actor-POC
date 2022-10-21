//
//  ARBankAccount.swift
//  Actor-POC
//
//  Created by Ashok Rawat on 18/10/22.
//

import Foundation

enum ARBankError: Error {
    case insufficientFunds(Double)
}

actor ARBankAccount {
    let accountNumber: Int
    var balance: Double
    
    init(accountNumber: Int, balance: Double) {
        self.accountNumber = accountNumber
        self.balance = balance
    }
    
    func deposit(_ amount: Double) {
        balance += amount
    }
    
    func transfer(amount: Double, to other: isolated ARBankAccount) async throws  {
        if amount > balance {
            throw ARBankError.insufficientFunds(amount)
        }
        
        balance -= amount
        other.balance += amount
        
//        await other.deposit(amount)
        
        print(other.accountNumber)
        print("Current Account: \(balance), Other Account: \(other.balance)")
    }
}
