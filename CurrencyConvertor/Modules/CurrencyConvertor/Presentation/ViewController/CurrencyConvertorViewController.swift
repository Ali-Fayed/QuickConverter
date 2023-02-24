//
//  CurrencyConvertorViewController.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 23/02/2023.
//
import UIKit
import RxSwift
import RxCocoa
class CurrencyConvertorViewController: BaseViewController<CurrencyConvertorViewModel> {
    // MARK: - Properties
    weak var coordinator: AppCoordinator?
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        configureView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    // MARK: - Main Methods
    private func configureView() {
        testForGettingData()
        subscribeOnError()
        subscribeOnLoading()
    }
    private func configureViewModel() {
        guard let viewModel = viewModel else {return}
        viewModel.fetchCurrencySympols()
    }
    // MARK: - Error Handling
    private func subscribeOnError() {
        guard let viewModel = viewModel else {return}
        viewModel.currencySympolsSubject.subscribe(onError: { [weak self] error in
            guard let self = self else {return}
            guard let error = error as? APIError else {return}
            if error.error?.info != nil {
                self.presentErrorAlert(error: error, message: error.error?.info ?? "")
            } else {
                self.presentErrorAlert(error: error, message: error.customError?.errorDescription ?? "")
            }
        }).disposed(by: disposeBag)
    }
    private func presentErrorAlert(error: APIError, message: String) {
        showAlert(title: "Error", message: message, buttonTitle: "OK")
            .subscribe(onNext: {
                print("OK button tapped")
            }, onCompleted: {
                print("Alert dismissed")
            }).disposed(by: disposeBag)
    }
    // MARK: - Loading Indicator
    func subscribeOnLoading() {
        guard let viewModel = viewModel else {return}
        viewModel.loadingIndicatorRelay
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    // MARK: - Test
    func testForGettingData() {
        viewModel!.currencySympolsSubject.subscribe { model in
            print(model.sympol.keys)
        }.disposed(by: disposeBag)
    }
}
