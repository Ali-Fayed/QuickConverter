//
//  OtherCurrencyDataTableViewCell.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import UIKit
class OtherCurrencyDataTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setData(model: FamousCurrenciesDataModel) {
        titleLabel.text = model.currencySymbol + Constants.epsilonString + model.currencyValue
    }
}
