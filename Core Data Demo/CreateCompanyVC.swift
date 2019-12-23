//
//  CreateCompanyVC.swift
//  Core Data Demo
//
//  Created by AKIL KUMAR THOTA on 12/17/19.
//  Copyright © 2019 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit
import CoreData

class CreateCompanyVC: UIViewController {

    let operationType: OperationType
    var createCompanyVCDelegate: createCompanyVCDelegate?


    init(operationType: OperationType, createCompanyVCDelegate: createCompanyVCDelegate?) {
        self.operationType = operationType
        self.createCompanyVCDelegate = createCompanyVCDelegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = UIDatePicker.Mode.date
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.textAlignment = .left
        return label
    }()

    let foundedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Founded"
        return label
    }()

    let dateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Click here to select a date", for: .normal)
        button.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        return button
    }()

    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.placeholder = "Enter name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    var verticalSV: UIStackView!

    let imageView: UIImageView = {
        let im = UIImageView()
        im.translatesAutoresizingMaskIntoConstraints = false
        im.image = UIImage(systemName: "questionmark.square.fill")
        im.contentMode = .scaleAspectFill
        return im
    }()

    let selectPhotoButton: UIButton  = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Select photo", for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(selectPhotoTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 20, green: 30, blue: 50, alpha: 1)
        title = "Create Company"

        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        datePicker.isHidden = true
        view.addSubview(datePicker)
        datePicker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        datePicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 200).isActive = true


        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))


        setupVerticalStackView()
    }

    private func setupVerticalStackView() {
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        selectPhotoButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        selectPhotoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        verticalSV = UIStackView(arrangedSubviews: [imageView, selectPhotoButton])
        verticalSV.translatesAutoresizingMaskIntoConstraints = false
        verticalSV.axis = .vertical
        verticalSV.alignment = .center
        verticalSV.distribution = .fill
        verticalSV.spacing = 20

        view.addSubview(verticalSV)

        verticalSV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        verticalSV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        verticalSV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true

        let nameStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        nameStackView.axis = .horizontal
        nameStackView.distribution = .fillEqually
        verticalSV.addArrangedSubview(nameStackView)

        nameStackView.leadingAnchor.constraint(equalTo: verticalSV.leadingAnchor, constant: 0).isActive = true
        nameStackView.trailingAnchor.constraint(equalTo: verticalSV.trailingAnchor, constant: 0).isActive = true
        nameStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true


        let dateStackView = UIStackView(arrangedSubviews: [foundedLabel, dateButton])
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        dateStackView.axis = .horizontal
        dateStackView.distribution = .fillEqually

        verticalSV.addArrangedSubview(dateStackView)

        dateStackView.leadingAnchor.constraint(equalTo: verticalSV.leadingAnchor, constant: 0).isActive = true
        dateStackView.trailingAnchor.constraint(equalTo: verticalSV.trailingAnchor, constant: 0).isActive = true
        dateStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }

    @objc private func selectPhotoTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }

    @objc private func dateButtonTapped() {
        datePicker.isHidden = !datePicker.isHidden
    }

    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            dateButton.setTitle("\(day) \(month) \(year)", for: .normal)
        }
        datePicker.isHidden = !datePicker.isHidden
    }

    @objc private func doneButtonTapped() {
        navigationController?.popViewController(animated: true)
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate

        let context = appDelegate?.persistentContainer.viewContext

        let company: NSManagedObject

        switch operationType {
        case .create:
            company = NSEntityDescription.insertNewObject(forEntityName: "CoreCompany", into: context!)
        case .edit(let oldCompany, _):
            company = oldCompany
        }

        company.setValue(nameTextField.text ?? "lalalal", forKey: "name")
        company.setValue(Date(), forKey: "date")

        if let image = imageView.image {
            let imgData = image.jpegData(compressionQuality: 0.8)
            company.setValue(imgData, forKey: "image")
        }

        appDelegate?.saveContext()

        createCompanyVCDelegate?.addedCompany(operationType: operationType, company: company)
    }
}

extension CreateCompanyVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
