//
//  HistoricalDetailsUseCaseProtocol.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 26/02/2023.
//
import RxCocoa
import RxSwift
import Foundation
protocol HistoricalDetailsUseCaseProtocol {
    typealias returnType = Observable<[HistoricalConvertsDataModel]>
    func excute(date: String, symbols: String, base: String) -> returnType
}
