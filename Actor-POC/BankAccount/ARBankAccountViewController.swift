//
//  ARBankAccountViewController.swift
//  Actor-POC
//
//  Created by Ashok Rawat on 17/10/22.
//

import UIKit

class ARBankAccountViewController: UIViewController {

    @IBOutlet weak var transcationTableView: UITableView!
    private var bankAccountVM = AccountViewModel(balance: 500)
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        // Do any additional setup after loading the view.
        loadRightBarItem()
        
        self.bankAccountVM.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.transcationTableView.reloadData()
            }
        }
    }
    
    
    private func loadRightBarItem() {
        let logoutBarButtonItem = UIBarButtonItem(image: .add, style: .done, target: self, action: #selector(handleEditBtn))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
        self.navigationController?.navigationBar.backgroundColor = .systemGreen
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func handleEditBtn() {
        DispatchQueue.concurrentPerform(iterations: 2) { _ in
            Task {
                await self.bankAccountVM.withdraw(500)
            }
        }
    }
}

extension ARBankAccountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankAccountVM.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = transcationTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = bankAccountVM.transactions[indexPath.row]
        return cell
        
    }
}


/*
 
 //        let lockQueue = DispatchQueue(label: "my.serial.lock.queue")
 //        let semaphore = DispatchSemaphore(value: 1)
         
         DispatchQueue.concurrentPerform(iterations: 2) { _ in
 //            lockQueue.sync {
 //                semaphore.wait()
                 self.bankAccountVM.withdraw(500)
 //                semaphore.signal()
                 
 //            }
 */


/*
 
 var lock = os_unfair_lock_s()
 
 os_unfair_lock_lock(&lock)
 os_unfair_lock_unlock(&lock)
 
 */



