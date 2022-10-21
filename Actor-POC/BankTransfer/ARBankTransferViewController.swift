//
//  ARBankTransferViewController.swift
//  Actor-POC
//
//  Created by Ashok Rawat on 18/10/22.
//

import UIKit

class ARBankTransferViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        performSomeAction()
    }
    
    func performSomeAction() {
        let bankAccount = ARBankAccount(accountNumber: 2468, balance: 1000)
        let otherBankAccount = ARBankAccount(accountNumber: 1357, balance: 500)
        print(bankAccount.accountNumber)
//        print(bankAccount.details)
        
        DispatchQueue.concurrentPerform(iterations: 5) { _ in
            Task {
                do {
                    try await bankAccount.transfer(amount: 500, to: otherBankAccount)
                }
                catch {
                    print(error)
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
