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
}

class LandingViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var verifyByDeviceButton: UIButton!
    @IBOutlet weak var headerEnrichmentButton: UIButton!
    @IBOutlet weak var smsVerificationButton: UIButton!
    @IBOutlet weak var misscallVerificationButton: UIButton!
    @IBOutlet weak var waVerificationButton: UIButton!
    @IBOutlet weak var waLongVerificationButton: UIButton!
    
    var numberPhone: String?
    var onActionTapped: ((ActionType)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nibSetup()
        titleLabel.text = "Welcome, \(numberPhone ?? "")!\nHow would you like to confirm your identity ?"
    }
    
    private func nibSetup() {
        let buttons: [UIButton] = [verifyByDeviceButton, headerEnrichmentButton, smsVerificationButton, misscallVerificationButton, waVerificationButton, waLongVerificationButton]
        buttons.forEach({
            $0.layer.cornerRadius = 8
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        })
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
}
