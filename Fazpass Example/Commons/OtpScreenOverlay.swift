//
//  OtpScreenOverlay.swift
//  Finance App
//
//  Created by Akbar Putera on 06/02/23.
//

import UIKit

class OtpScreenOverlay: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var otpView: DPOTPView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var forgotLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var illustrationImage: UIImageView!
    private var otpText: String?
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
        let bundle = Bundle(for: OtpScreenOverlay.self)
        guard let tempView = bundle.loadNibNamed(String(describing: OtpScreenOverlay.self), owner: self)?.first as? UIView else { return }
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
        
        otpView.dpOTPViewDelegate = self
        
        descLabel.text = ""
    }
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        onNextButtonTapped?(otpText)
    }
}

extension OtpScreenOverlay: DPOTPViewDelegate {
    func dpOTPViewAddText(_ text: String, at position: Int) {
        otpText = text
    }
    
    func dpOTPViewRemoveText(_ text: String, at position: Int) {
        otpText = text
    }
    
    func dpOTPViewChangePositionAt(_ position: Int) {
//        print(position)
    }
    
    func dpOTPViewBecomeFirstResponder() {
        
    }
    
    func dpOTPViewResignFirstResponder() {
        
    }
}
