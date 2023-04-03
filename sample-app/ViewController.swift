//
//  ViewController.swift
//  sample-app
//
//  Created by Andri nova riswanto on 27/03/23.
//

import UIKit
import ios_trusted_device

class ViewController: UIViewController {
    @IBOutlet weak var edtEmail: UITextField!
    @IBOutlet weak var edtPhone: UITextField!
    @IBOutlet weak var edtPin: UITextField!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var btnEnroll: UIButton!
    @IBOutlet weak var btnValidate: UIButton!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var lblResult: UILabel!
    let f = Fazpass()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        f.initialize("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZGVudGlmaWVyIjo0fQ.WEV3bCizw9U_hxRC6DxHOzZthuJXRE8ziI3b6bHUpEI", TD_MODE.DEV)

    }
    @IBAction func checkAction(_ sender: UIButton){
        let _email = edtEmail.text! //?? "koala@gmail.com"
        let _phone = edtPhone.text!// ?? "085195310101"
        if(_email == "" || _phone == ""){
            // create the alert
            let alert = UIAlertController(title: "Alert", message: "Field email & phone is required", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
        }else{
            f.check(_email, _phone) { [self] TD_STATUS, CD_STATUS in
                lblResult.text = "\n Trusted Device Status: \(TD_STATUS) \n Cross Device Status: \(CD_STATUS)"
            }
        }

    }
    
    @IBAction func enrollAction(_ sender: UIButton){
        let _email = edtEmail.text!
        let _phone = edtPhone.text!
        let _pin = edtPin.text!
        if(_email=="" || _phone=="" || _pin==""){
            
        }else{
            f.enrollDeviceByPin(_email, _phone, _pin) { status, message in
                self.lblResult.text = message.lowercased()
            }
        }

    }
    
    @IBAction func validateAction(_ sender: UIButton){
        let _pin = edtPin.text!
        f.validateDevice(pin: _pin) { result, status, message in
            self.lblResult.text = "Confidence rate : \(result)"
        }
    }
    
    @IBAction func removeAction(_ sender: UIButton){
        let _pin = edtPin.text!
        f.removeDevice(pin: _pin) { status, message in
            self.lblResult.text = "Device removed"
        }
    }


}

