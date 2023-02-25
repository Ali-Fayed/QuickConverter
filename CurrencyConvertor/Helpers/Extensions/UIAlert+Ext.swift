//
//  UIAlert+Ext.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import UIKit
import RxSwift
import RxCocoa
extension UIViewController {
    func showAlert(title: String, message: String, buttonTitle: String) -> Observable<Void> {
        return Observable.create { observer in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            // Create the alert actions and bind them to an observable
            let okAction = UIAlertAction(title: buttonTitle, style: .cancel) { _ in
                observer.onNext(())
                observer.onCompleted()
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return Disposables.create {
                alertController.dismiss(animated: true, completion: nil)
            }
        }
    }
}
