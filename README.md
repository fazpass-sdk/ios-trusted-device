# ios-trusted-device

### Initialization
For using this SDK it will be start with call initialization function
```Swift
import ios_trusted_device

let f = Fazpass()
        f.initialize("MERCHANT_KEY", TD_MODE.DEV)
```
You can get merchant key from email when regeistered, and select your mode between dev or production

### OTP Feature
We have method that can be use, like ;
* Request OTP
* Generate OTP 
* Validate OTP
Usage:
```Swift
 f.requestOtpByPhone(phoneNumber: String, gateWay: String){
    callback in
    // TODO
 }
```

### Header Enrichment Feature
This feature will validate base on sim card and data connection
```Swift
        f.headerEnreachment(phone:String, gateway:String) { result in
            // TODO
        }
```
### Trusted Device
Method that can be use for this feature are 
* Check Device
* Enroll Device
* Validate Device
* Remove Device 
  
Usage:
#### Check
```Swift
f.check(_email, _phone) { TD_STATUS, CD_STATUS in
                print(TD_STATUS)
                print(CD_STATUS)
            }
```
That should you notice is never do anything when TD_STATUS is UNTRUSTED, that mean better you use OTP or validate it by other way.
#### Enroll
```Swift
            f.enrollDeviceByPin(_email, _phone, _pin) { status, message in
                // TODO
            }
```
It will register this device into trusted device
#### Verify Device
```Swift
        f.validateDevice(pin: _pin) { result, status, message in
            // TODO
        }
```
It will return confidence rate that we already calculated as a double
#### Remove Device
```Swift
        f.removeDevice(pin: _pin) { status, message in
          // TODO
        }
```
It will change status this device from trusted into untrusted