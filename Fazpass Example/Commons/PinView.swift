//
//  PinView.swift
//  Fazpass Example
//
//  Created by Akbar Putera on 20/02/23.
//

import UIKit

class PinView: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var pintTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var onNextButtonTapped: ((String?) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.nibSetup()
        self.initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.nibSetup()
        self.initialSetup()
    }
    
    func nibSetup() {
        let bundle = Bundle(for: PinView.self)
        guard let tempView = bundle.loadNibNamed(String(describing: PinView.self), owner: self)?.first as? UIView else { return }
        self.containerView = tempView
        self.containerView.frame = bounds
        self.containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.backgroundColor = .black.withAlphaComponent(0.5)
        addSubview(containerView)
    }
    
    func initialSetup() {
        contentView.layer.cornerRadius = 10
        nextButton.layer.cornerRadius = 10
        nextButton.backgroundColor = #colorLiteral(red: 0.9540299773, green: 0.1715227365, blue: 0.2805242538, alpha: 1)
        nextButton.setTitleColor(.white, for: .normal)
        pintTextField.delegate = self
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let pinString = pintTextField.text
        onNextButtonTapped?(pinString)
    }
}

extension PinView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
