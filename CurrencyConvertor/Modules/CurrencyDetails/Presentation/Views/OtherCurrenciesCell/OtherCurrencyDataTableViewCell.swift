//
//  OtherCurrencyDataTableViewCell.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import UIKit
class OtherCurrencyDataTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    // MARK: - Methods
    /// prepare the date for the tableView
    /// - Parameter model: enter here the parameter from the data subject
    func setData(model: FamousCurrenciesDataModel) {
        titleLabel.text = model.currencySymbol + Constants.epsilonString + model.currencyValue
    }
}
