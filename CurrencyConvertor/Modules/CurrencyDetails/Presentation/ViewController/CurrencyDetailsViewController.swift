//
//  CurrencyDetailsViewController.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 23/02/2023.
//
import UIKit
import RxSwift
import RxCocoa
class CurrencyDetailsViewController: BaseViewController<CurrencyDetailsViewModel> {
    // MARK: - IBOutlets
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var otherCurrenciesTableView: UITableView!
    // MARK: - Properties
    weak var coordinator: AppCoordinator?
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureViewModel()
    }
    // MARK: - Main Methods
    func configureView() {
        historyTableViewConfigure()
        otherCurrenciesTableViewConfigure()
    }
    func configureViewModel() {
        guard let viewModel = viewModel else{return}
        viewModel.getLastThreeDaysConverts()
        viewModel.fetchFamousConverts()
    }
    // MARK: - TableView
    func historyTableViewConfigure() {
        historyTableView.registerCellNib(cellClass: HistoricalDataTableViewCell.self)
        viewModel?.convertsLastThreeDaysSubject
            .bind(to: historyTableView.rx.items(cellIdentifier: Constants.historicalDataCell, cellType: HistoricalDataTableViewCell.self)) {  (row,item,cell) in
                cell.setData(model: item)
            }.disposed(by: disposeBag)
        historyTableView.tableFooterView = UIView()
    }
    func otherCurrenciesTableViewConfigure() {
        otherCurrenciesTableView.registerCellNib(cellClass: OtherCurrencyDataTableViewCell.self)
        viewModel?.currencyModelSubject
            .bind(to: otherCurrenciesTableView.rx.items(cellIdentifier: Constants.otherCurrencyDataCell, cellType: OtherCurrencyDataTableViewCell.self)) {  (row,item,cell) in
                cell.setData(model: item)
            }.disposed(by: disposeBag)
        otherCurrenciesTableView.tableFooterView = UIView()
    }
}
