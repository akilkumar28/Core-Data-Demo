//
//  HomeVC.swift
//  Core Data Demo
//
//  Created by AKIL KUMAR THOTA on 12/17/19.
//  Copyright © 2019 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

protocol createCompanyVCDelegate {
    func addedCompany(company: Company)
}

final class CompanyVC: UITableViewController {

    var companies: [Company] = [Company(name: "Microsoft", foundedDate: "29 09 10")]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CompanyCell.self, forCellReuseIdentifier: "cell")

        configureNavBar()
        configureTableViewAppearance()
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
        let createCompanyVC = CreateCompanyVC()
        createCompanyVC.createCompanyVCDelegate = self
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
        cell.textLabel?.text = company.name
        cell.imageView?.image = UIImage(systemName: "airplane")
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
        return UIView()
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
}

extension CompanyVC: createCompanyVCDelegate {
    func addedCompany(company: Company) {
        companies.append(company)
        let indexPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}
