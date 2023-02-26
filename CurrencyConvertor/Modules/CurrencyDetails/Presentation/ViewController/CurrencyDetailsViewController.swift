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
    @IBOutlet weak var historicalConvertsTableView: UITableView!
    @IBOutlet weak var famousCurrenciesTableView: UITableView!
    @IBOutlet weak var topChartHeader: UIView!
    // MARK: - Properties
    weak var coordinator: AppCoordinator?
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    // MARK: - Main Methods
    private func initView() {
        tableViewConfigure()
        initCurrencyChartHeader()
    }
    private func initViewModel() {
        guard let viewModel = viewModel else{return}
        viewModel.fetchLastThreeDaysHistoricalConverts()
        viewModel.fetchFamousTenCurrencyConverts()
    }
    // MARK: - TableView
    private func tableViewConfigure() {
        historicalConvertsTableView.registerCellNib(cellClass: HistoricalDataTableViewCell.self)
        famousCurrenciesTableView.registerCellNib(cellClass: OtherCurrencyDataTableViewCell.self)
        //
        famousCurrenciesTableView.tableFooterView = UIView()
        historicalConvertsTableView.tableFooterView = UIView()
        //
        bindHistoryTableView()
        bindFamousCurrenciesTableView()
        famousCurrenciesTableViewDidSelectRow()
        historicalCurrenciesTableViewDidSelectRow()
    }
    // MARK: - Historical Currencies TableView
    private func bindHistoryTableView() {
        guard let viewModel = viewModel else{return}
        viewModel.historicalConvertsSubject
            .observe(on: MainScheduler.instance)
            .bind(to: historicalConvertsTableView.rx.items(cellIdentifier: Constants.historicalDataCell, cellType: HistoricalDataTableViewCell.self)) { (row, model , cell) in
                cell.setData(model: model)
            }.disposed(by: disposeBag)
    }
    private func historicalCurrenciesTableViewDidSelectRow() {
        historicalConvertsTableView.rx.itemSelected.subscribe { [weak self] indexPath in
            guard let self = self else {return}
            self.historicalConvertsTableView.deselectRow(at: indexPath, animated: true)
        }.disposed(by: disposeBag)
    }
    // MARK: - Famous Currencies TableView
    private func bindFamousCurrenciesTableView() {
        guard let viewModel = viewModel else{return}
        viewModel.famousConvertsSubject
            .observe(on: MainScheduler.instance)
            .bind(to: famousCurrenciesTableView.rx.items(cellIdentifier: Constants.otherCurrencyDataCell, cellType: OtherCurrencyDataTableViewCell.self)) {  (row, model, cell) in
                cell.setData(model: model)
            }.disposed(by: disposeBag)
    }
    private func famousCurrenciesTableViewDidSelectRow() {
        famousCurrenciesTableView.rx.itemSelected.subscribe { [weak self] indexPath in
            guard let self = self else {return}
            self.famousCurrenciesTableView.deselectRow(at: indexPath, animated: true)
        }.disposed(by: disposeBag)
    }
    // MARK: - Chart Header
    private func initCurrencyChartHeader() {
        guard let viewModel = viewModel else{return}
        viewModel.historicalConvertsSubject.subscribe(onNext: { models in
            var measurment = [ChartMeasurmentDataModel]()
            for model in models {
                measurment.append(ChartMeasurmentDataModel(date: model.dateString, rate: Double(model.toCurrencyValue) ?? 1.0))
            }
            let headerView = CurrencyChatHeaderView(frame: CGRect(x: 0, y: 0, width: self.topChartHeader.bounds.width, height: 150), measurements: measurment)
            self.topChartHeader.addSubview(headerView)
        }).disposed(by: disposeBag)
    }
}
