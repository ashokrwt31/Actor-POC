//
//  ViewController.swift
//  Actor-POC
//
//  Created by Ashok Rawat on 14/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    let isActor = false
    let account1 = BankAccountClass(balance: 500.0)
    let account2 = BankAccountClass(balance: 800.0)
    let account3 = BankAccountClass(balance: 0.0)
    
    let accountActor1 = BankAccount(balance: 500.0)
    let accountActor2 = BankAccount(balance: 800.0)
    let accountActor3 = BankAccount(balance: 0.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        testShopActor()
//        testBuildMessage()
//        testUser()
        print("view controller....viewDidLoad")
        let queue1 = DispatchQueue(label: "com.checkBankBalance.queue1")
        let queue2 = DispatchQueue(label: "com.checkBankBalance.queue1")
        
        
        queue1.async {
            self.checkBankBalance("1")
        }
        queue2.async {
            self.checkBankBalance("2")
        }
    }
}

extension ViewController {
    func testShopActor() {
        let shop = Shop()
        print(shop.id)

        Task {
            await shop.purchase()
            print(await shop.itemCount)
            print(await shop.purchase())
        }
        
        Task {
            var owner = await shop.owner
            owner?.name = "abc"
        }
        

    }
    
    func testBuildMessage() {
        let hello = BuildMessage()

        print(hello.greetings)

        Task {
//            hello.message = "Hi"
            await hello.setName(name: "Ashok")
            print(await hello.message)
        }

        print(hello.getGreetings())
        Task {
            var owner = await hello.owner
            owner?.name = "abc"
        }
    }
    
    func testUser() {
        let user1 = User()
        let user2 = User()
        
        Task {
            await user1.printScore()
            await user1.copyScore(from: user2)
            print("User 1 \(await user1.score)")
            print("User 2 \(await user2.score)")
        }
    }
    
    func checkBankBalance(_ topQueue: String) {
        
        if isActor {
            
            
            Task {
                
                print("TopQueue \(topQueue)Balance before transfer in account1 -- \(await accountActor1.balance)")
                print("TopQueue \(topQueue) Balance before transfer in account2 -- \(await accountActor2.balance)")
                print("TopQueue \(topQueue) Balance before transfer in account3 -- \(await accountActor3.balance)")
                print("\r\n")
                
                await accountActor2.transfer(amount: 500, to: accountActor1)
                print("TopQueue \(topQueue) queue 1 account1 Balance after transfer 500rs account2 to account1 -- \(await accountActor1.balance)")
                print("TopQueue \(topQueue) queue 1 account2 Balance after transfer 500rs account2 to account1 -- \(await accountActor2.balance)")
                print("TopQueue \(topQueue) queue 1 account3 Balance after transfer 500rs account2 to account1 -- \(await accountActor3.balance)")
                print("\r\n")
                
                await accountActor2.transfer(amount: 300, to: accountActor3)
                await self.accountActor2.deposit(amount: 100)
                print("\r\n")
                print("TopQueue \(topQueue) queue 2 account1 Balance after transfer 500rs account2 to account3 -- \(await accountActor1.balance)")
                print("TopQueue \(topQueue) queue 2 account2 Balance after transfer 500rs account2 to account3 -- \(await accountActor2.balance)")
                print("TopQueue \(topQueue) queue 2 account3 Balance after transfer 500rs account2 to account3 -- \(await accountActor3.balance)")
                print("\r\n")
                
                await accountActor2.transfer(amount: 300, to: accountActor3)
                print("\r\n")
                print("TopQueue \(topQueue) queue 3 account1 Balance after transfer 500rs account2 to account3 -- \(await accountActor1.balance)")
                print("TopQueue \(topQueue) queue 3 account2 Balance after transfer 500rs account2 to account3 -- \(await accountActor2.balance)")
                print("TopQueue \(topQueue) queue 3 account3 Balance after transfer 500rs account2 to account3 -- \(await accountActor3.balance)")
                print("\r\n")
            }
        }
        else {
            
            
            print("TopQueue \(topQueue) Balance before transfer in account1 -- \(account1.balance)")
            print("TopQueue \(topQueue) Balance before transfer in account2 -- \(account2.balance)")
            print("TopQueue \(topQueue) Balance before transfer in account3 -- \(account3.balance)")
            print("\r\n")
            
//            let queue1 = DispatchQueue(label: "com.knowstack.queue1")
//            let queue2 = DispatchQueue(label: "com.knowstack.queue2")
//            let queue3 = DispatchQueue(label: "com.knowstack.queue3")
            let globalQueue = DispatchQueue.global()

            
            globalQueue.async {
                self.account2.transfer(amount: 500, to: self.account1)
                print("TopQueue \(topQueue) queue 1 account1 Balance after transfer 500rs account2 to account1 -- \(self.account1.balance)")
                print("TopQueue \(topQueue) queue 1 account2 Balance after transfer 500rs account2 to account1 -- \(self.account2.balance)")
                print("TopQueue \(topQueue) queue 1 account3 Balance after transfer 500rs account2 to account1 -- \(self.account3.balance)")
                print("\r\n")
            }
            globalQueue.async {
                self.account2.transfer(amount: 300, to: self.account3)
                self.account2.deposit(amount: 100)
                print("\r\n")
                print("TopQueue \(topQueue) queue 2 account1 Balance after transfer 500rs account2 to account3 -- \(self.account1.balance)")
                print("TopQueue \(topQueue) queue 2 account2 Balance after transfer 500rs account2 to account3 -- \(self.account2.balance)")
                print("TopQueue \(topQueue) queue 2 account3 Balance after transfer 500rs account2 to account3 -- \(self.account3.balance)")
                print("\r\n")
            }
            globalQueue.async {
                self.account2.transfer(amount: 300, to: self.account3)
                print("\r\n")
                print("TopQueue \(topQueue) queue 3 account1 Balance after transfer 500rs account2 to account3 -- \(self.account1.balance)")
                print("TopQueue \(topQueue) queue 3 account2 Balance after transfer 500rs account2 to account3 -- \(self.account2.balance)")
                print("TopQueue \(topQueue) queue 3 account3 Balance after transfer 500rs account2 to account3 -- \(self.account3.balance)")
                print("\r\n")
            }
        }
    }
}

actor Shop {
    var owner: Owner!
    
    let id = "abc"
    var itemCount = 10
    
    func purchase() {
        itemCount -= 1
    }
}


actor BuildMessage {
    
    var owner: Owner!
    
    var message: String = ""
    
    let greetings = "Hello!"
    
    func setName(name: String) {
        self.message = "\(greetings) \(name)"
    }
    
    nonisolated func getGreetings() -> String {
            return greetings
        }
}

//class Owner  { // compiler error: Non-final class 'Owner' cannot conform to Sendable
//    var name: String = ""
//}

struct Owner: Sendable {
    var name: String = ""
}



actor User {
    var score = 0
    
    func printScore() {
        print("My score is \(score)")
    }
    
    func copyScore(from other: User) async {
        score = await other.score
    }
}


class BankAccountClass {
    var balance: Decimal

    init(balance: Decimal) {
        self.balance = balance
    }

    func deposit(amount: Decimal) {
//        var amt = amount
//        while amt > 0 {
//            self.balance += 1
//            amt +=  1
//        }

        balance = balance + amount

    }

    func transfer(amount: Decimal, to other: BankAccountClass) {
        guard balance >= amount else {
            print("Insufficient balance...")
            return
        }

//        var amt = amount
//        while amt > 0 {
//            self.balance -= 1
//            amt -=  1
//        }

        balance = balance - amount

        other.deposit(amount: amount)
    }
}


actor BankAccount {
    var balance: Decimal
    
    init(balance: Decimal) {
        self.balance = balance
    }
    
    func deposit(amount: Decimal) {
//        var amt = amount
//        while amt > 0 {
//            self.balance += 1
//            amt +=  1
//        }
        
        balance = balance + amount
        
    }
    
    func transfer(amount: Decimal, to other: BankAccount) async {
        guard balance >= amount else {
            print("Insufficient balance...")
            return
        }
        
//        var amt = amount
//        while amt > 0 {
//            self.balance -= 1
//            amt -=  1
//        }
        
        balance = balance - amount
        
        await other.deposit(amount: amount)
    }
}
