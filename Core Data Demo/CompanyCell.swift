//
//  CompanyCell.swift
//  Core Data Demo
//
//  Created by AKIL KUMAR THOTA on 12/17/19.
//  Copyright © 2019 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.rgb(red: 48, green: 164, blue: 182, alpha: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
