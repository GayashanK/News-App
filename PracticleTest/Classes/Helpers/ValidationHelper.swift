//
//  ViewController.swift
//  StaterPack-iOS-swift-4.0
//
//  Created by Kasun Gayashan on 2/7/18.
//  Copyright © 2018 Bhasha. All rights reserved.
//

import UIKit
import Foundation

class ValidationHelper: NSObject {
    
    static var instance = ValidationHelper()

    func validateEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func isValidName(name:String) -> Bool {
        let regex = try! NSRegularExpression(pattern:  "^[a-zàâçéèêëîïôûùüÿñæœ .]+$", options: [.caseInsensitive])
        return regex.firstMatch(in: name, options:[], range: NSMakeRange(0, name.count)) != nil
    }
    
    func validatePassword(password:String) -> Bool {
        return true
    }
    
    func validatePassword(password:String) -> String {
        if password == "" {
            return getErrorMessage(errorCode:respond.passwrdEmpty.rawValue)
        } else if password.count < 8 {
            return getErrorMessage(errorCode:respond.passwordMinLength.rawValue)
        } else {
            return ""
        }
    }
    
    func validatePhoneNo(phoneNo:String) -> (message:String,status:Bool) {
        if phoneNo == "" {
            return (getErrorMessage(errorCode: respond.phoneNoEmpty.rawValue),false)
        } else if phoneNo.count <= 9 {
            return (getErrorMessage(errorCode: respond.phoneNoMinLength.rawValue),false)
        }
        else {
            return (phoneNo,true)
        }
    }
    
    func getErrorMessage(errorCode: String) -> String {
        if let value = respond(rawValue: errorCode) {
            switch value {
            case .recordNotExists:
                return "No data found."
            case .noInternet:
                return "No Internet Connection"
            case .dataFetchFailed:
                return "Data Fetch Failed"
            case .requestTimedout:
                return "Looks like the server is taking too long to respond"
            case .severOperationFailed:
                return "Something is technically wrong!"
            case .couldNotConnectServer:
                return "Something is technically wrong!"
            case .connectionLost:
                return "Connection Lost"
            default:
                return "Something went wrong."
            }
        }
        return "Something went wrong"
    }
    
    func format(phoneNumber sourcePhoneNumber: String) -> String? {
        // Remove any character that is not a number
        let numbersOnly = sourcePhoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let length = numbersOnly.count
        let hasLeadingOne = numbersOnly.hasPrefix("1")
        
        // Check for supported phone number length
        guard length == 7 || length == 10 || (length == 11 && hasLeadingOne) else {
            return nil
        }
        
        let hasAreaCode = (length >= 10)
        var sourceIndex = 0
        
        // Leading 1
        var leadingOne = ""
        if hasLeadingOne {
            leadingOne = "1 "
            sourceIndex += 1
        }
        
        // Area code
        var areaCode = ""
        if hasAreaCode {
            let areaCodeLength = 3
            guard let areaCodeSubstring = numbersOnly.substring(start: sourceIndex, offsetBy: areaCodeLength) else {
                return nil
            }
            areaCode = String(format: "(%@) ", areaCodeSubstring)
            sourceIndex += areaCodeLength
        }
        
        // Prefix, 3 characters
        let prefixLength = 3
        guard let prefix = numbersOnly.substring(start: sourceIndex, offsetBy: prefixLength) else {
            return nil
        }
        sourceIndex += prefixLength
        
        // Suffix, 4 characters
        let suffixLength = 4
        guard let suffix = numbersOnly.substring(start: sourceIndex, offsetBy: suffixLength) else {
            return nil
        }
        
        return leadingOne + areaCode + prefix + "-" + suffix
    }
    
}

extension String {
    /// This method makes it easier extract a substring by character index where a character is viewed as a human-readable character (grapheme cluster).
    internal func substring(start: Int, offsetBy: Int) -> String? {
        guard let substringStartIndex = self.index(startIndex, offsetBy: start, limitedBy: endIndex) else {
            return nil
        }
        
        guard let substringEndIndex = self.index(startIndex, offsetBy: start + offsetBy, limitedBy: endIndex) else {
            return nil
        }
        
        return String(self[substringStartIndex ..< substringEndIndex])
    }
}
