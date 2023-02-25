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
    @IBOutlet weak var header: UIView!
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
        addChartHeader()
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
    func addChartHeader() {
        viewModel?.convertsLastThreeDaysSubject.subscribe(onNext: { model in
            var measurment = [Measurement]()
            for mode in model {
                measurment.append(Measurement(date: mode.dateString, rate: Double(mode.toCurrencyValue)!))
            }
            let headerView = MyTableViewHeaderView(frame: CGRect(x: 0, y: 0, width: self.header.bounds.width, height: self.header.bounds.height), measurements: measurment)
            self.header.addSubview(headerView)
        }).disposed(by: disposeBag)
    }
}
