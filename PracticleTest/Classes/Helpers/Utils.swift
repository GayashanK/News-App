//
//  ViewController.swift
//  StaterPack-iOS-swift-4.0
//
//  Created by Kasun Gayashan on 2/7/18.
//  Copyright © 2018 Bhasha. All rights reserved.
//

import UIKit
import L10n_swift

class Utils: NSObject {
    
    static var instance = Utils()
    
    func showAlert(title: String? = nil,message: String? = nil, viewController: UIViewController, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        //to change font of title and message.
        let titleFont = [NSAttributedString.Key.font: Config.setFont(size: 12, weight: FontWeight.regular)]
        let messageFont = [NSAttributedString.Key.font: Config.setFont(size: 11, weight: FontWeight.regular)]
        
        let titleAttrString = NSMutableAttributedString(string: title ?? "", attributes: titleFont)
        let messageAttrString = NSMutableAttributedString(string: message ?? "", attributes: messageFont)
        
        alertController.setValue(titleAttrString, forKey: "attributedTitle")
        alertController.setValue(messageAttrString, forKey: "attributedMessage")
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: handler)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
 
    func dateDiff(oriDate : Date, lang: String)-> String{
        
        let convertedDate = oriDate
        let todayDate = Date().addingTimeInterval(19800)
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        
        var ti =  convertedDate.timeIntervalSince(todayDate) //convertedDate.timeIntervalSinceDate(todayDate)
        ti = ti * -1;
        if(ti < 1) {
            return "Moment Ago".l10n()
        } else     if (ti < 60) {
            return "Moment Ago".l10n()
        } else if (ti < 3600) {
            let diff = round(ti / 60)
            if(diff <= 1){
                return "Minute Ago".l10n()
            }
            if(lang == "si"){
                return  "මිනිත්තු " + formatter.string(from: NSNumber(value: diff))! + " කට පෙර"
            }else if(lang == "en"){
                return  formatter.string(from: NSNumber(value: diff))! + " Minutes Ago"
            }else{
                return  "මිනිත්තු " + formatter.string(from: NSNumber(value: diff))! + " කට පෙර"
            }
        } else if (ti < 86400) {
            let diff = round(ti / 60 / 60)
            
            if(diff <= 1){
                return  "Hour Ago".l10n() //"1 Hour Ago"
            }
            if(lang == "si"){
                return  "පැය " + formatter.string(from: NSNumber(value: diff))! + " කට පෙර"
            }else if(lang == "en"){
                return formatter.string(from: NSNumber(value: diff))! + " Hours Ago"
            }else{
                return  "පැය " + formatter.string(from: NSNumber(value: diff))! + " කට පෙර"
            }
            
        } else if (ti < 2592000) {
            let diff = round(ti / 60 / 60 / 24)
            
            if(diff <= 1){
                return  "Day Ago".l10n() //"1 Day Ago"
            }
            
            if(lang == "si"){
                return  "දින " + formatter.string(from: NSNumber(value: diff))! + " කට පෙර"
            }else if(lang == "en"){
                return formatter.string(from: NSNumber(value: diff))! + " Days Ago"
            }else{
                return  "දින " + formatter.string(from: NSNumber(value: diff))! + " කට පෙර"
            }
            
        }else if (ti < 31104000) {
            let diff = round(ti / 60 / 60 / 24 / 30 )
            
            if(diff <= 1){
                return  "Month Ago".l10n() //"1 Month Ago"
            }
            
            if(lang == "si"){
                return  "මාස " + formatter.string(from: NSNumber(value: diff))! + " කට පෙර" //formatter.string(from: NSNumber(value: diff))! + " Months Ago"
            }else if(lang == "en"){
                return formatter.string(from: NSNumber(value: diff))! + " Months Ago"
            }else{
                return  "මාස " + formatter.string(from: NSNumber(value: diff))! + " කට පෙර" //formatter.string(from: NSNumber(value: diff))! + " Months Ago"
            }
            
        }else if (ti < 11352960000) {
            let diff = round(ti / 60 / 60 / 24 / 30 / 12 )
            
            if(diff == 1){
                return "Year Ago".l10n() //"1 Year Ago"
            }
            
            if(lang == "si"){
                return "වසර " + formatter.string(from: NSNumber(value: diff))! + " කට පෙර"  //
            }else if(lang == "en"){
                return formatter.string(from: NSNumber(value: diff))! + " Years Ago"
            }else{
                return "වසර " + formatter.string(from: NSNumber(value: diff))! + " කට පෙර"  //formatter.string(from: NSNumber(value: diff))! + " Years Ago"
            }
        }else {
            return "Moment Ago".l10n()
        }
    }

}
