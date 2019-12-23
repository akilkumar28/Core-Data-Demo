//
//  EmployeeVC.swift
//  Core Data Demo
//
//  Created by AKIL KUMAR THOTA on 12/20/19.
//  Copyright © 2019 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit
import CoreData

class EmployeeVC: UITableViewController {

    let parentCompany: NSManagedObject

    

    init(parentCompany: NSManagedObject) {
        self.parentCompany = parentCompany
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor.rgb(red: 9, green: 45, blue: 64, alpha: 1)
        tableView.separatorColor = .white

        title = parentCompany.value(forKey: "name") as? String

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))

    }

    @objc private func addButtonTapped() {
        let createEmployeeVC = CreateEmployeeVC()
        navigationController?.pushViewController(createEmployeeVC, animated: true)

        let appDelegate = UIApplication.shared.delegate as? AppDelegate

        appDelegate?.persistentContainer.performBackgroundTask(<#T##block: (NSManagedObjectContext) -> Void##(NSManagedObjectContext) -> Void#>)
    }
}
