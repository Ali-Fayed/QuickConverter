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
    // MARK: - Properties
    weak var coordinator: AppCoordinator?
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getLastThreeDaysConverts()
        viewModel?.fetchFamousConverts(date: "", to: "EUR", from: "USD")
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    // MARK: - Main Methods
    func configureView() {
        
    }
    func configureViewModel() {
        
    }
    // MARK: - Other
}
