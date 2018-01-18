//
//  PaymentTypeDataSource.swift
//  ShopClient
//
//  Created by Evgeniy Antonov on 12/29/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import UIKit
import PassKit

enum PaymentTypeSection: Int {
    case creditCard
    case applePay
    
    static let allValues = PKPaymentAuthorizationController.canMakePayments() ? [creditCard, applePay] : [creditCard]
}

protocol PaymentTypeDataSourceProtocol: class {
    func isSelected(type: PaymentTypeSection) -> Bool
}

class PaymentTypeDataSource: NSObject, UITableViewDataSource {
    weak var delegate: (PaymentTypeDataSourceProtocol & PaymentTypeTableCellProtocol)?
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PaymentTypeSection.allValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PaymentTypeTableViewCell.self), for: indexPath) as! PaymentTypeTableViewCell
        cell.delegate = delegate
        let type = PaymentTypeSection(rawValue: indexPath.row)!
        cell.typeSelected = delegate?.isSelected(type: type) ?? false
        cell.type = type
        return cell
    }
}