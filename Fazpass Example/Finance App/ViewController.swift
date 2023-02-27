//
//  ViewController.swift
//  Finance App
//
//  Created by Akbar Putera on 02/02/23.
//

import UIKit
import Fazpass
import LocalAuthentication

class ViewController: UIViewController {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var curtainView: UIView!
    @IBOutlet weak var loadingIndicatorView: UIView!
    
    private var otpReseponse: OtpResponse?
    
    var context = LAContext()
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
    
    func showPinViewOverlay(view: UIView) {
        let overlay = PinView(frame: view.frame)
        overlay.onNextButtonTapped = { pinString in
            guard let pinString = pinString else { return }
            self.enrollDeviceByPin(view: view, pin: pinString)
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
    
    func showBiometry(view: UIView) {
        context.localizedCancelTitle = "Enter Username/Password"
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            print(error?.localizedDescription ?? "Can't evaluate policy")
            return
        }
        
        Task {
            do {
                try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Log in to your account")
                self.enrollDeviceByPin(view: view, pin: "7071")
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    func navigateToLandingView() {
        let landingView = LandingViewController()
        landingView.numberPhone = fazpass.getNumber() ?? ""
        landingView.onActionTapped = { actionType in
            switch actionType {
            case .byDevice:
//                self.enrollByDevice(view: landingView.view, pin: "")
                print("enroll by device")
            case .he:
                self.headerEnrichment(view: landingView.view)
            case .sms:
                self.generateOtp(view: landingView.view, gateWay: .sms)
            case .miscall:
                self.generateOtp(view: landingView.view, gateWay: .miscall)
            case .wa:
                self.generateOtp(view: landingView.view, gateWay: .wa)
            case .waLong:
                self.generateOtp(view: landingView.view, gateWay: .waLong)
            case .check:
                self.checkDevice(view: landingView.view)
            case .enrollDeviceBiometry:
                self.enrollDeviceByBiometry(view: landingView.view)
            case .remove:
                self.removeDevice(view: landingView.view)
            case .validate:
                self.verifyDevice(view: landingView.view)
            default: break
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
        fazpass.headerEnreachment(numberPhone, SecretConstant.gateWayHe) { results in
            switch results {
            case .success:
                self.showAlert(title: "200", message: "Auth page requested successfully", in: self)
                self.dismissLoadingView(in: view.subviews.last ?? UIView())
            case .failure(let error):
                self.dismissLoadingView(in: view.subviews.last ?? UIView())
                self.showAlert(title: "Error", message: error.message, in: self)
            }
        }
    }
    
    func generateOtp(view: UIView, gateWay: SecretConstant.GateWayType) {
        let numberPhone = fazpass.getNumber() ?? ""
        showLoadingView(in: view)
        fazpass.generateOtpByPhone(numberPhone, gateWay.rawValue) { results in
            switch results {
            case .success(let response):
                self.dismissLoadingView(in: view.subviews.last ?? UIView())
                self.showOtpOverlay(view: view)
                self.otpReseponse = response
            case .incomingMessage(let otp):
                print(otp ?? "")
            case .failure(let error):
                self.dismissLoadingView(in: view.subviews.last ?? UIView())
                self.showAlert(title: "Error", message: error.message, in: self)
            }
        }
    }

    func otpVerification(view: UIView, otp: String?) {
        showLoadingView(in: view)
        fazpass.verificationOtp(otp ?? "", otpReseponse?.id ?? "") { results in
            switch results {
            case .success(let status):
                self.dismissLoadingView(in: view.subviews.last ?? UIView())
                if status {
                    self.navigationController?.popToRootViewController(animated: true)
                    self.showCurtainView(isShow: false)
                }
            case .failure(let error):
                self.dismissLoadingView(in: view.subviews.last ?? UIView())
                self.showAlert(title: "Error", message: error.message, in: self)
            }
        }
    }

    func enrollDeviceByPin(view: UIView, pin: String) {
        let numberPhone = fazpass.getNumber() ?? ""
        showLoadingView(in: view)
        trustedDevice.enrollDeviceByPin("", numberPhone, pin: pin) { results in
            switch results {
            case .success:
                self.dismissLoadingView(in: view.subviews.last ?? UIView())
            case .failure(let error):
                self.dismissLoadingView(in: view.subviews.last ?? UIView())
                self.showAlert(title: "Error", message: error.message, in: self)
            }
        }
    }
    
    func enrollDeviceByBiometry(view: UIView) {
        let numberPhone = fazpass.getNumber() ?? ""
        showLoadingView(in: view)
        trustedDevice.enrollDeviceBiometry("", numberPhone) { results in
            switch results {
            case .success:
                self.dismissLoadingView(in: view.subviews.last ?? UIView())
            case .failure(let error):
                self.dismissLoadingView(in: view.subviews.last ?? UIView())
                self.showAlert(title: "Error", message: error.message, in: self)
            }
        }
    }
    
    func verifyDevice(view: UIView) {
        showLoadingView(in: view)
        trustedDevice.verifyDevice { result in
            switch result {
            case .success:
                self.dismissLoadingView(in: view.subviews.last ?? UIView())
                self.showAlert(title: "Status", message: "Verify Success", in: self)
            case .failure(let error):
                self.dismissLoadingView(in: view.subviews.last ?? UIView())
                self.showAlert(title: error.softErrorResponse.code, message: error.softErrorResponse.message, in: self)
            }
        }
    }
    
    func removeDevice(view: UIView) {
        showLoadingView(in: view)
        trustedDevice.removeDevice { result in
            switch result {
            case .success:
                self.dismissLoadingView(in: view.subviews.last ?? UIView())
                self.showAlert(title: "Status", message: "Device Removed", in: self)
            case .failure(let error):
                self.dismissLoadingView(in: view.subviews.last ?? UIView())
                self.showAlert(title: error.softErrorResponse.code, message: error.softErrorResponse.message, in: self)
            }
        }
    }
    
    func checkDevice(view: UIView) {
        let numberPhone = fazpass.getNumber() ?? ""
        showLoadingView(in: view)
        trustedDevice.checkDevice("", numberPhone) { result in
            switch result {
            case .success(let response):
                self.dismissLoadingView(in: view.subviews.last ?? UIView())
                let trustedStatus = "Trusted Device: \(response?.apps?.current?.isTrusted ?? false) \n"
                let crossStatus = "Cross Device: \(response?.apps?.crossApp ?? false)"
                self.showAlert(title: "Status", message: trustedStatus + crossStatus, in: self)
            case .failure(let error):
                self.dismissLoadingView(in: view.subviews.last ?? UIView())
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
