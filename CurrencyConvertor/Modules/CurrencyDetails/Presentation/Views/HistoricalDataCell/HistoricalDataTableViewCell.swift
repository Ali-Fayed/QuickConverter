//
//  HistoricalDataTableViewCell.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import UIKit
class HistoricalDataTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    func setData(model: HistoricalConvertsDataModel) {
        dateLabel.numberOfLines = 1
        dateLabel.lineBreakMode = .byClipping // o
        dateLabel.text = model.dateString
        valueLabel.text = model.fromCurrencyValue + Constants.emptySpaceString + model.fromCurrencySymbol + Constants.epsilonString + model.toCurrencyValue + Constants.emptySpaceString + model.toCurrencySymobl
    }
}
