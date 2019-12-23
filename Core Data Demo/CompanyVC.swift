//
//  HomeVC.swift
//  Core Data Demo
//
//  Created by AKIL KUMAR THOTA on 12/17/19.
//  Copyright © 2019 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit
import CoreData

enum OperationType {
    case create
    case edit(company: NSManagedObject, indexPath: IndexPath)
}

protocol createCompanyVCDelegate {
    func addedCompany(operationType: OperationType, company: NSManagedObject)
}

final class CompanyVC: UITableViewController {

    var companies: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CompanyCell.self, forCellReuseIdentifier: "cell")

        configureNavBar()
        configureTableViewAppearance()

        fetchCompanies()
    }

    private func fetchCompanies() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreCompany")

        let appDelegate = UIApplication.shared.delegate as? AppDelegate

        let context = appDelegate?.persistentContainer.viewContext

        guard let companies = try? context?.fetch(fetchRequest) as? [NSManagedObject] else {
            fatalError()
        }

        self.companies = companies

        tableView.reloadData()
    }

    private func configureTableViewAppearance() {
        tableView.backgroundColor = UIColor.rgb(red: 9, green: 45, blue: 64, alpha: 1)
        tableView.separatorColor = .white
    }

    private func configureNavBar() {
        navigationItem.title = "Companies"
        navigationController?.navigationBar.prefersLargeTitles = true

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = .red

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }

    @objc private func addButtonTapped() {
        let createCompanyVC = CreateCompanyVC(operationType: .create, createCompanyVCDelegate: self)
        navigationController?.pushViewController(createCompanyVC, animated: true)
    }
}

extension CompanyVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CompanyCell
        let company = companies[indexPath.row]
        cell.textLabel?.text = company.value(forKey: "name") as? String
        if let imgData = company.value(forKey: "image") as? Data {
            cell.imageView?.image = UIImage(data: imgData)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = {
            let hV = UITableViewCell()
            hV.backgroundColor = .lightGray

            hV.imageView?.image = UIImage(systemName: "person.fill")?.withTintColor(.black)
            hV.textLabel?.text = "Names"
            hV.textLabel?.textColor = .black
            hV.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            return hV
        }()

        return headerView
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "No more rows to see"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return companies.count > 0 ? 150 : 0
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, block) in
            print("delete tapped")
            let company = self.companies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)

            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let context = appDelegate?.persistentContainer.viewContext
            context?.delete(company)
            block(true)
        }

        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, block) in
            print("edit tapped")
            let company = self.companies[indexPath.row]
            let createCompanyVC = CreateCompanyVC(operationType: .edit(company: company, indexPath: indexPath), createCompanyVCDelegate: self)
            createCompanyVC.nameTextField.text = company.value(forKey: "name") as? String
            self.navigationController?.pushViewController(createCompanyVC, animated: true)
            block(true)
        }
        let config = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        return config
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let parentCompany = companies[indexPath.row]
        let employeeVC = EmployeeVC(parentCompany: parentCompany)
        navigationController?.pushViewController(employeeVC, animated: true)
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
}

extension CompanyVC: createCompanyVCDelegate {
    func addedCompany(operationType: OperationType, company: NSManagedObject) {
        switch operationType {
        case .create:
            companies.append(company)
            let indexPath = IndexPath(row: companies.count - 1, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        case .edit(_, let indexPath):
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
