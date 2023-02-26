//
//  PickerTextField.swift
//  CurrencyConvertor
//
//  Created by AliFayed on 24/02/2023.
//
import UIKit
import RxSwift
import RxCocoa
class CustomTextFieldPicker: UITextField {
    private let pickerView = UIPickerView(frame: .zero)
    private let disposeBag = DisposeBag()
    public var pickerItems: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupBindings()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupBindings()
    }
    func setupBindings() {
        self.inputView = pickerView
        self.tintColor = UIColor.clear
        self.inputView?.backgroundColor = UIColor.white
        self.inputView?.layer.borderWidth = 0
        
        pickerItems.bind(to: self.pickerView.rx.itemTitles) { (row, element) in
            return element
        }.disposed(by: disposeBag)
        let _ = pickerView.rx.itemSelected
            .debounce(RxTimeInterval.microseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { (row, value) in
                self.text = self.pickerItems.value[row]
                self.resignFirstResponder()
            })
    }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }
}
