//
//  BaseVC.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import Foundation
protocol BaseVC: AnyObject {
   associatedtype V
   init(viewModel: V?, nibName: String?)
}
