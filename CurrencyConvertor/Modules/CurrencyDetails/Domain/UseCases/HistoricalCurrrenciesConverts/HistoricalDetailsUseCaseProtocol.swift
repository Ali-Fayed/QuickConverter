//
//  HistoricalDetailsUseCaseProtocol.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 26/02/2023.
//
import RxSwift
import Foundation
protocol HistoricalDetailsUseCaseProtocol {
    typealias returnType = Observable<[HistoricalConvertsDataModel]>
    func excute(startDate: String, endDate: String, base: String, symbols: String) -> returnType
}
