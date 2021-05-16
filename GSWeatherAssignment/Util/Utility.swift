//
//  Utility.swift
//  GSWeatherAssignment
//
//  Created by Rishabh on 02/04/21.
//

import UIKit
import SystemConfiguration

class Utility {
    static func showAlert(message: String, on controller: UIViewController) {
        let alert = UIAlertController.init(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        let dismissAction = UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(dismissAction)
        controller.present(alert, animated: true, completion: nil)
    }
    
    static func getDateFromDouble(doubleDate: Double) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(doubleDate))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.init(identifier: "en_GB")
        return formatter.string(from: date)
    }
    
    static func tempInCelcius(from kelvin: Double) -> String {
        let degree = kelvin - 273.15
        return String(round(degree)) + "C"
    }
}

public class ReachabilityTest {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
 
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
 
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
 
    }
    
}
