//
//  CustomTextFieldPicker.swift
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
        // Set up picker view
        self.inputView = pickerView
        self.tintColor = UIColor.clear
        self.inputView?.backgroundColor = UIColor.white
        self.inputView?.layer.borderWidth = 0
        pickerItems.bind(to: self.pickerView.rx.itemTitles) { (row, element) in
            return element
        }.disposed(by: disposeBag)
        let _ = pickerView.rx.itemSelected
            .subscribe(onNext: { (row, value) in
                self.text = self.pickerItems.value[row]
            })
        // Set up input accessory view
        let accessoryView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        accessoryView.backgroundColor = .lightGray
        //
        let doneButton = UIButton(type: .system)
        doneButton.setTitle("Select", for: .normal)
        accessoryView.backgroundColor = .white
        doneButton.setTitleColor(.black, for: .normal)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        doneButton.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        accessoryView.addSubview(doneButton)
        //
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.centerXAnchor.constraint(equalTo: accessoryView.centerXAnchor).isActive = true
        doneButton.centerYAnchor.constraint(equalTo: accessoryView.centerYAnchor).isActive = true
        self.inputAccessoryView = accessoryView
    }
    @objc func didTapDoneButton() {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
            self.text = pickerItems.value[selectedRow]
        
        resignFirstResponder()
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
