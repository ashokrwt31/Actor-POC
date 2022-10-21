//
//  AccountViewModel.swift
//  Actor-POC
//
//  Created by Ashok Rawat on 17/10/22.
//

import Foundation

class AccountViewModel {
    
    var reloadTableViewClosure: (() -> ())?
    
    var account: Account
    var currentBalance: Double?
    
    var transactions: [String] = []  {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    init(balance: Double) {
        account = Account(balance: balance)
    }
    
    func withdraw(_ amount: Double) async  {
        await account.withdraw(amount: amount)

        self.currentBalance = await self.account.getBalance()
        self.transactions =  await self.account.transactions
        
    }
}
