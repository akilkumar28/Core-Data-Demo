//
//  CreateEmployeeVC.swift
//  Core Data Demo
//
//  Created by AKIL KUMAR THOTA on 12/20/19.
//  Copyright © 2019 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit
import CoreData

final class CreateEmployeeVC: UIViewController {

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.text = "Birthday"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter name"
        tf.borderStyle = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .lightGray
        return tf
    }()

    let birthdayTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "MM/DD/YYYY"
        tf.borderStyle = .none
        tf.backgroundColor = .lightGray
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    let segmentControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Executive", "Senior Management", "Staff"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        return sc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))

        setUpUI()
    }

    @objc private func saveButtonTapped() {
        let name = nameTextField.text
        let seg = ["Executive", "Senior", "Staff"][segmentControl.selectedSegmentIndex]

        let appDelegate = UIApplication.shared.delegate as? AppDelegate

        let context = appDelegate?.persistentContainer.viewContext

        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context!)

        employee.setValue(name, forKey: "name")

        appDelegate?.saveContext()

        navigationController?.popViewController(animated: true)
    }

    private func setUpUI() {
        let backgroundView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 0.86, green: 0.92, blue: 0.95, alpha: 1.00)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        view.addSubview(backgroundView)

        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 0).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true

        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 16).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 8).isActive = true
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        view.addSubview(birthdayLabel)
        birthdayLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16).isActive = true
        birthdayLabel.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 8).isActive = true
        birthdayLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        view.addSubview(birthdayTextField)
        birthdayTextField.centerYAnchor.constraint(equalTo: birthdayLabel.centerYAnchor, constant: 0).isActive = true
        birthdayTextField.leftAnchor.constraint(equalTo: birthdayLabel.rightAnchor, constant: 16).isActive = true
        birthdayTextField.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -8).isActive = true
        birthdayTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)

        view.addSubview(nameTextField)
        nameTextField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 0).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: birthdayTextField.leadingAnchor, constant: 0).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -8).isActive = true
        nameTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)

        view.addSubview(segmentControl)
        segmentControl.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 16).isActive = true
        segmentControl.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 8).isActive = true
        segmentControl.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -8).isActive = true

        let height = nameTextField.bounds.width + 32 + birthdayTextField.bounds.height + 32 + segmentControl.bounds.height + 32
        backgroundView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
