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
    // MARK: - IBOutlets
    @IBOutlet weak var fromSympolTextField: CustomTextFieldPicker!
    @IBOutlet weak var toSympolTextField: CustomTextFieldPicker!
    @IBOutlet weak var inputCurrencyTextField: UITextField!
    @IBOutlet weak var convertedCurrencyTextField: UITextField!
    @IBOutlet weak var swapRatedButton: UIButton!
    @IBOutlet weak var detailsButton: UIButton!
    // MARK: - Properties
    weak var coordinator: AppCoordinator?
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        intiView()
        initViewModel()
    }
    // MARK: - Main Methods
    private func intiView() {
        initBindings()
        initState()
    }
    private func initViewModel() {
        guard let viewModel = viewModel else {return}
        viewModel.fetchCurrencySympols()
    }
    private func fetchCurrencyConverts() {
        guard let viewModel = viewModel else {return}
        viewModel.fetchConvertedCurrency(fromSympol: fromSympolTextField.text!, toSympol: toSympolTextField.text!, amount: inputCurrencyTextField.text!)
    }
    // MARK: - Bindings
    private func initBindings() {
        bindFromCurrencySympols()
        bindToCurrencySympols()
        bindDetailsButton()
        bindSwapButton()
        bindInputFromTextField()
        bindConvertedTextField()
    }
    private func bindFromCurrencySympols() {
        guard let viewModel = viewModel else {return}
        viewModel.currencySympolsSubject
        .map { $0.sympols }
        .observe(on: MainScheduler.instance)
        .bind(to: fromSympolTextField.pickerItems)
        .disposed(by: disposeBag)
        // value changed
        fromSympolTextField.rx.controlEvent([.editingDidEnd])
            .asObservable()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if !self.inputCurrencyTextField.text!.isEmpty {
                    self.fetchCurrencyConverts()
                }
            }).disposed(by: disposeBag)
    }
    private func bindToCurrencySympols() {
        guard let viewModel = viewModel else {return}
        viewModel.currencySympolsSubject
        .map { $0.sympols }
        .observe(on: MainScheduler.instance)
        .bind(to: toSympolTextField.pickerItems)
        .disposed(by: disposeBag)
        // value changed
        toSympolTextField.rx.controlEvent([.editingDidEnd])
            .asObservable()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if !self.inputCurrencyTextField.text!.isEmpty {
                    self.fetchCurrencyConverts()
                }
            }).disposed(by: disposeBag)
    }
    private func bindSwapButton() {
        swapRatedButton.rx.tap.bind { [weak self] in
            guard let self = self else {return}
            let fromSympol = self.fromSympolTextField.text
            self.fromSympolTextField.text = self.toSympolTextField.text
            self.toSympolTextField.text = fromSympol
            self.inputCurrencyTextField.text = Constants.one
            if !self.inputCurrencyTextField.text!.isEmpty {
                self.fetchCurrencyConverts()
            }
        }.disposed(by: disposeBag)
    }
    private func bindDetailsButton() {
        detailsButton.rx.tap.bind { [weak self] in
            guard let self = self else {return}
            guard let coordinator = self.coordinator else {return}
            let fromSymbol = self.fromSympolTextField.text!
            let toSymbol = self.toSympolTextField.text!
            let fromValue = self.inputCurrencyTextField.text!
            coordinator.showCurrencyDetailsViewController(fromSympol: fromSymbol, toSympol: toSymbol, fromValue: fromValue)
        }.disposed(by: disposeBag)
    }
    private func bindInputFromTextField() {
        inputCurrencyTextField.rx.text
            .orEmpty
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] text in
                guard let self = self else {return}
                if !self.inputCurrencyTextField.text!.isEmpty {
                    self.fetchCurrencyConverts()
                }
            }).disposed(by: disposeBag)
    }
    private func bindConvertedTextField() {
        convertedCurrencyTextField.isEnabled = false
        guard let viewModel = viewModel else {return}
        viewModel.convertedCurrencySubject.observe(on: MainScheduler.instance)
            .bind(to: convertedCurrencyTextField.rx.text)
            .disposed(by: disposeBag)
    }
    // MARK: - State
    private func initState() {
        observeOnError()
        observeOnLoading()
        observeOnViewInteraction()
    }
    // MARK: - Loading State
    private func observeOnLoading() {
        guard let viewModel = viewModel else {return}
        viewModel.loadingIndicatorRelay
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    private func observeOnViewInteraction() {
        viewModel?.loadingIndicatorRelay.subscribe(onNext: { [weak self] isLoading in
            guard let self = self else {return}
            if isLoading {
                self.swapRatedButton.isUserInteractionEnabled = false
                self.detailsButton.isUserInteractionEnabled = false
            } else {
                self.swapRatedButton.isUserInteractionEnabled = true
                self.detailsButton.isUserInteractionEnabled = true
            }
        }).disposed(by: disposeBag)
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
    private func presentErrorAlert(error: APIError, message: String) {
        showAlert(title: Constants.error, message: message, buttonTitle: Constants.oK)
            .subscribe(onNext: { [weak self] in
                guard let self = self else {return}
                self.view.isUserInteractionEnabled = false
            }, onCompleted: {
                //
            }).disposed(by: disposeBag)
    }
}
