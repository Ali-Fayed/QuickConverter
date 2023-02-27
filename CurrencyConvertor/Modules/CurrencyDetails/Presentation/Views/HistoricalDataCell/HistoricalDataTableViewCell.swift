//
//  HistoricalDataTableViewCell.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 25/02/2023.
//
import UIKit
class HistoricalDataTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    // MARK: - Methods
    /// prepare the date for the tableView
    /// - Parameter model: enter here the parameter from the data subject
    func setData(model: HistoricalConvertsDataModel) {
        dateLabel.numberOfLines = 1
        dateLabel.lineBreakMode = .byClipping
        dateLabel.text = model.dateString
        valueLabel.text = model.fromCurrencyValue + Constants.emptySpaceString + model.fromCurrencySymbol + Constants.epsilonString + model.toCurrencyValue + Constants.emptySpaceString + model.toCurrencySymobl
    }
}
