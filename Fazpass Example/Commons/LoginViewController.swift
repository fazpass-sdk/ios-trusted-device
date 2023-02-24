//
//  LoginViewController.swift
//  Fazpass Example
//
//  Created by Akbar Putera on 06/02/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var illustrationImage: UIImageView!
    @IBOutlet weak var titlelLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var phoneEmailTextfield: UITextField!
    
    var onClickNextButton: ((String?)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        nextButton.layer.cornerRadius = 10
        nextButton.backgroundColor = #colorLiteral(red: 0.9540299773, green: 0.1715227365, blue: 0.2805242538, alpha: 1)
        nextButton.setTitleColor(.white, for: .normal)
        phoneEmailTextfield.delegate = self
    }
    
    func setupData(title: String, subTitle: String, image: String) {
        DispatchQueue.main.async {
            self.titlelLabel.text = title
            self.descLabel.text = subTitle
            self.illustrationImage.image = UIImage(named: image)
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let phoneEmail = phoneEmailTextfield.text, phoneEmail.count > 3 else {
            self.showAlert(title: "Warning", message: "Please insert valid phone or email!", in: self)
            return
        }
        onClickNextButton?(phoneEmail)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
