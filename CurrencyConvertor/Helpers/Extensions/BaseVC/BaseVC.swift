//
//  BaseVC.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//

import Foundation
import Foundation
protocol BaseVC: AnyObject {
   associatedtype V
   associatedtype C
   init(viewModel: V?, coordinator: C?, nibName: String?)
}
