//
//  ViewController.swift
//  Finance App
//
//  Created by Akbar Putera on 02/02/23.
//

import UIKit
import Fazpass

class ViewController: UIViewController {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var curtainView: UIView!
    @IBOutlet weak var loadingIndicatorView: UIView!
    
    private var otpReseponse: OtpResponse?
    
    var fazpass = Fazpass.shared
    var trustedDevice = Fazpass.trusted
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.navigateToLoginView()
        })
    }
    
    private func initialSetup() {
        cardView.layer.cornerRadius = 10
        cardView.backgroundColor = #colorLiteral(red: 0.9540299773, green: 0.1715227365, blue: 0.2805242538, alpha: 1)

        tableView.dataSource = self

        let loadingIndicatorImage: UIImageView = .fromGif(frame: CGRect(x: 0.0, y: 0.0, width: loadingIndicatorView.frame.size.width, height: loadingIndicatorView.frame.size.height), resourceName: "loading-indicator") ?? UIImageView()
        loadingIndicatorView.addSubview(loadingIndicatorImage)
        loadingIndicatorImage.startAnimating()
    }
    
    private func showCurtainView(isShow: Bool) {
        self.curtainView.isHidden = !isShow
    }

    func showOtpOverlay(view: UIView) {
        let overlay = OtpScreenOverlay(frame: view.frame)
        let counter = Counter.init()
        counter.star()
        counter.onUpdate = { timer in
            overlay.descLabel.text = timer
        }
        overlay.onNextButtonTapped = { otpString in
            counter.stop()
            self.otpVerification(view: view, otp: otpString)
        }
        view.addSubview(overlay)
    }

    func navigateToLoginView() {
        let loginView = LoginViewController()
        loginView.setupData(title: "Finance App", subTitle: "It has over 40 sections and 20 pages, also good news! There is dark mode! I hope you guys like it", image: "login-illustration")
        if let numberPhone = fazpass.getNumber() {
            DispatchQueue.main.async {
                loginView.phoneEmailTextfield.text = numberPhone
            }
        }
        loginView.onClickNextButton = { phoneOrEmailString in
            self.fazpass.setNumber(number: phoneOrEmailString)
            self.navigateToLandingView()
        }
        self.navigationController?.pushViewController(loginView, animated: false)
    }


    func navigateToLandingView() {
        let landingView = LandingViewController()
        landingView.numberPhone = fazpass.getNumber() ?? ""
        landingView.onActionTapped = { actionType in
            switch actionType {
            case .byDevice:
                self.enrollByDevice(view: landingView.view)
            case .he:
                self.headerEnrichment(view: landingView.view)
            case .sms:
                self.smsVerification(view: landingView.view)
            case .miscall:
                self.miscallVerification(view: landingView.view)
            case .wa:
                print(actionType)
            case .waLong:
                print(actionType)
            }
        }
        self.navigationController?.pushViewController(landingView, animated: true)
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        self.showCurtainView(isShow: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.navigateToLoginView()
        })
    }
    
    @IBAction func moreButtonTapped(_ sender: UIButton) {
        
    }
    
}

extension ViewController {
    func headerEnrichment(view: UIView) {
        showLoadingView(in: view)
        let numberPhone = fazpass.getNumber() ?? ""
        fazpass.headerEnreachment(numberPhone, "b038aebb-718b-4845-bb20-3ca0d03f1b5a") { results in
            switch results {
            case .success(let response):
                print(response)
                self.showAlert(title: "200", message: "Auth page requested successfully", in: self)
                self.dismissLoadingVIew(in: view.subviews.last ?? UIView())
            case .failure(let error):
                self.dismissLoadingVIew(in: view.subviews.last ?? UIView())
                self.showAlert(title: "Error", message: error.message, in: self)
            }
        }
    }
    func smsVerification(view: UIView) {
        let numberPhone = fazpass.getNumber() ?? ""
        showLoadingView(in: view)
        fazpass.generateOtpByPhone(numberPhone, "8b7dcad3-8533-49aa-9347-4591c4ea98b3") { results in
            switch results {
            case .success(let response):
                self.dismissLoadingVIew(in: view.subviews.last ?? UIView())
                self.showOtpOverlay(view: view)
                self.otpReseponse = response
            case .incomingMessage(let otp):
                print(otp ?? "")
            case .failure(let error):
                self.dismissLoadingVIew(in: view.subviews.last ?? UIView())
                self.showAlert(title: "Error", message: error.message, in: self)
            }
        }
    }

    func otpVerification(view: UIView, otp: String?) {
        showLoadingView(in: view)
        fazpass.verificationOtp(otp ?? "", otpReseponse?.id ?? "") { results in
            switch results {
            case .success(let status):
                self.dismissLoadingVIew(in: view.subviews.last ?? UIView())
                if status {
                    self.navigationController?.popToRootViewController(animated: true)
                    self.showCurtainView(isShow: false)
                }
            case .failure(let error):
                self.dismissLoadingVIew(in: view.subviews.last ?? UIView())
                self.showAlert(title: "Error", message: error.message, in: self)
            }
        }
    }

    func miscallVerification(view: UIView) {
        let numberPhone = fazpass.getNumber() ?? ""
        self.showOtpOverlay(view: view)
        fazpass.generateOtpByPhone(numberPhone, "9defc750-83d8-4167-93e4-4fdab80a3eaf") { results in
            switch results {
            case .success(let response):
                self.otpReseponse = response
            case .incomingMessage(let otp):
                print(otp ?? "")
            case .failure(let error):
                self.showAlert(title: "Error", message: error.message, in: self)
            }
        }
    }
    
    func enrollByDevice(view: UIView) {
        let numberPhone = fazpass.getNumber() ?? ""
        trustedDevice.enrollDeviceByPin("", numberPhone, pin: "0000") { results in
            switch results {
            case .success():
                self.showAlert(title: "Succrss", message: "DEVICE TRUSTED", in: self)
            case .failure(let error):
                self.showAlert(title: "Error", message: error.message, in: self)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
        cell.selectionStyle = .none
        cell.logoImage.image = UIImage(named: "us-country-logo")
        return cell
    }
}
