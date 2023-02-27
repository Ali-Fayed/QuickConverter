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
    /// here the main section in the view controller every method related to the UI, bindings, states called here
    private func initView() {
        initState()
        initTableViews()
        initCurrencyChartHeader()
    }
    /// here the main section in the view controller every method related to data called here
    private func initViewModel() {
        guard let viewModel = viewModel else{return}
        viewModel.fetchLastThreeDaysHistoricalConverts()
        viewModel.fetchFamousTenCurrencyConverts()
    }
    // MARK: - TableView
    /// - Description:TableView Configure here
    private func initTableViews() {
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
    // MARK: - State
    /// - Description: All view controller states called here like loading, error, etc ..
    private func initState() {
        observeOnError()
        observeOnLoading()
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
            .bind(to: famousCurrenciesTableView.rx.items(cellIdentifier: Constants.otherCurrencyDataCell, cellType: OtherCurrencyDataTableViewCell.self)) { (row, model, cell) in
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
                measurment.append(ChartMeasurmentDataModel(date: model.dateString, convertedValue: Double(model.toCurrencyValue) ?? 1.0))
            }
            let headerView = CurrencyChatHeaderView(frame: CGRect(x: 0, y: 0, width: self.topChartHeader.bounds.width, height: 150), measurements: measurment)
            self.topChartHeader.addSubview(headerView)
        }).disposed(by: disposeBag)
    }
    // MARK: - Loading State
    /// - Description: show and hide the loading indictor
    private func observeOnLoading() {
        guard let viewModel = viewModel else {return}
        viewModel.loadingIndicatorRelay
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    // MARK: - Error State
    private func observeOnError() {
        guard let viewModel = viewModel else {return}
        viewModel.errorSubject.observe(on: MainScheduler.instance)
            .subscribe(onError: { [weak self] error in
            guard let self = self else {return}
            guard let error = error as? APIError else {return}
            if error.message != nil {
                self.presentErrorAlert(error: error, message: error.message ?? "")
            } else {
                self.presentErrorAlert(error: error, message: error.customError?.errorDescription ?? "")
            }
        }).disposed(by: disposeBag)
    }
    /// - Description: present alert when there is an error
    private func presentErrorAlert(error: APIError, message: String) {
        showAlert(title: Constants.error, message: message, buttonTitle: Constants.oK)
            .subscribe(onNext: {
              //
            }, onCompleted: {
                //
            }).disposed(by: disposeBag)
    }
}
