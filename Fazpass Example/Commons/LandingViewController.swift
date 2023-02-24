//
//  LandingViewController.swift
//  Fazpass Example
//
//  Created by Akbar Putera on 06/02/23.
//

import UIKit

enum ActionType {
    case byDevice
    case he
    case sms
    case miscall
    case wa
    case waLong
    case check
    case crossDevice
    case remove
    case validate
    case enrollDeviceBiometry
}

class LandingViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    // Main Buttons
    @IBOutlet weak var otpButton: UIButton!
    @IBOutlet weak var trustedButton: UIButton!
    // OTP Buttons
    @IBOutlet weak var verifyByDeviceButton: UIButton!
    @IBOutlet weak var headerEnrichmentButton: UIButton!
    @IBOutlet weak var smsVerificationButton: UIButton!
    @IBOutlet weak var misscallVerificationButton: UIButton!
    @IBOutlet weak var waVerificationButton: UIButton!
    @IBOutlet weak var waLongVerificationButton: UIButton!
    // Trusted Device Buttons
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var enrollBiometryButton: UIButton!
    // Button Container Stack View
    @IBOutlet weak var mainContainerBtnStackView: UIStackView!
    @IBOutlet weak var otpContainerBtnStackView: UIStackView!
    @IBOutlet weak var trustedContainerBtnStackView: UIStackView!
    
    var isBackStack: Bool = false
    
    var numberPhone: String?
    var onActionTapped: ((ActionType)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nibSetup()
        initStackViewVisibility()
        titleLabel.text = "Welcome, \(numberPhone ?? "")!\nHow would you like to confirm your identity ?"
    }
    
    private func nibSetup() {
        let otpButtons: [UIButton] = [otpButton, verifyByDeviceButton, headerEnrichmentButton, smsVerificationButton, misscallVerificationButton, waVerificationButton, waLongVerificationButton]
        otpButtons.forEach({
            $0.layer.cornerRadius = 8
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        })
        
        let trustedButtons: [UIButton] = [trustedButton, checkButton, removeButton, crossButton, enrollBiometryButton, validateButton]
        trustedButtons.forEach({
            $0.layer.cornerRadius = 8
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = #colorLiteral(red: 0.9540299773, green: 0.1715227365, blue: 0.2805242538, alpha: 1)
        })
    }
    
    private func manageStackViewVisibility(isTrusted: Bool) {
        isBackStack = true
        mainContainerBtnStackView.isHidden = true
        otpContainerBtnStackView.isHidden = isTrusted
        trustedContainerBtnStackView.isHidden = !isTrusted
    }
    
    func initStackViewVisibility() {
        isBackStack = false
        mainContainerBtnStackView.isHidden = false
        otpContainerBtnStackView.isHidden = true
        trustedContainerBtnStackView.isHidden = true
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        if isBackStack == false {
            self.navigationController?.popViewController(animated: false)
        }
        initStackViewVisibility()
    }
    
    @IBAction func otpButtonTapped(_ sender: UIButton) {
        manageStackViewVisibility(isTrusted: false)
    }
    
    @IBAction func trustedButtonTapped(_ sender: UIButton) {
        manageStackViewVisibility(isTrusted: true)
    }
    
    @IBAction func verifyByDeviceButtonTapped(_ sender: UIButton) {
        onActionTapped?(.byDevice)
    }
    
    @IBAction func headerEnrichmentButtonTapped(_ sender: UIButton) {
        onActionTapped?(.he)
    }
    
    @IBAction func smsVerificationTapped(_ sender: UIButton) {
        onActionTapped?(.sms)
    }
    
    @IBAction func misscallVerificationButtonTapped(_ sender: UIButton) {
        onActionTapped?(.miscall)
    }
    
    @IBAction func waVerificationTapped(_ sender: UIButton) {
        onActionTapped?(.wa)
    }
    
    @IBAction func waLongVerificationuttonTapped(_ sender: UIButton) {
        onActionTapped?(.waLong)
    }
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        onActionTapped?(.check)
    }
    
    @IBAction func removeButtonTapped(_ sender: UIButton) {
        onActionTapped?(.remove)
    }
    
    @IBAction func crossButtonTapped(_ sender: UIButton) {
        onActionTapped?(.crossDevice)
    }
    
    @IBAction func validateButtonTapped(_ sender: UIButton) {
        onActionTapped?(.validate)
    }
    
    @IBAction func enrollBiometryButtonTapped(_ sender: UIButton) {
        onActionTapped?(.enrollDeviceBiometry)
    }
}
