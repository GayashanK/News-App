//
//  SearchViewController.swift
//  PracticleTest
//
//  Created by Kasun Gayashan on 2/13/19.
//  Copyright © 2019 plenty. All rights reserved.
//

import UIKit
import DropDown
import DatePickerDialog
import TTGSnackbar

protocol SearchVCDelegate {
    func searchAd(keyword: String?, start:String?, end: String?, sortOption:String?)
}

class SearchViewController: BaseViewController {
    
    @IBOutlet weak var conView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var startDateButton: UIButton!
    @IBOutlet weak var endDateButton: UIButton!
    @IBOutlet weak var sortOptionLbl: UILabel!
    @IBOutlet weak var sortOptionDropLbl: UILabel!
    @IBOutlet weak var searchView: UIView!
    
    private var isFirstRun: Bool = true
    private let shouldDismissOnBackgroundTap: Bool = true
    
    var searchVCDelegate : SearchVCDelegate!
    
    var keyWord:String?
    var startDate: String?
    var endDate: String?
    var sortOption: String?
    var sortOptions = ["Relevancy", "popularity", "publishedAt"]
    
    let sortOptionDown = DropDown()
    
    //MARK: - View Lifecycle
    override func viewDidLoad(){
        super.viewDidLoad()
        
        searchTextField.delegate = self
        
        self.prepareBGFadeAnim()
        FadeInOutAnimHelper.prepareForInAnimation(containerView: self.conView, sizeRelationship: .ShrinkedAndOrdinary)
        configureSortOptionDropDown()
        startDateButton.addTarget(self, action: #selector(startDateTapped), for: .touchUpInside)
        endDateButton.addTarget(self, action: #selector(endDateTapped), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.setUpLooks()
        
        // Animation stuff
        if isFirstRun
        {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            self.isFirstRun = false
            self.doBGFadeAnim()
            FadeInOutAnimHelper.doInAnimation(forContainerView: self.conView)
        }
    }
    
    //MARK: - Other
    // Logic to handle
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if shouldDismissOnBackgroundTap{
            if let touch = touches.first{
                let pot = touch.location(in: self.view)
                if (!self.conView.frame.contains(pot)){
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    // Overridden to allow the smooth fade out
    // animation to take place while dismissing
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        FadeInOutAnimHelper.doOutAnimation(
            forContainerView: self.conView,
            sizeRelationship: .ShrinkedAndOrdinary) {
                super.dismiss(animated: false, completion: completion)
        }
    }
    
    //MARK: - Animation
    private func prepareBGFadeAnim(){
        self.view.alpha = 0.0
    }
    
    private func doBGFadeAnim(){
        UIView.animate(
            withDuration: 0.23,
            delay: 0.0,
            options: .curveEaseInOut,
            animations: {
                self.view.alpha = 1.0
        }, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Look
    private func setUpLooks(){
        self.view.tag = 0
        sortOptionLbl.tag = 1
        searchView.tag = 2
        
        searchView.addGestureRecognizer(setGestureRecognizer())
        sortOptionLbl.addGestureRecognizer(setGestureRecognizer())
        conView.layer.cornerRadius = 5
        conView.clipsToBounds = true
        searchView.layer.cornerRadius = 2
        searchView.clipsToBounds = true
    }
    
    @objc func startDateTapped(){
        datePickerTapped(start: true)
    }
    
    @objc func endDateTapped(){
        datePickerTapped(start: false)
    }
    
    @objc override func handleTapGesture(_ tapGesture : UITapGestureRecognizer){
        if tapGesture.view?.tag == 0 {
            self.dismiss(animated: false)
        } else if tapGesture.view?.tag == 1 {
            sortOptionDown.show()
        } else if tapGesture.view?.tag == 2 {
            //search
            self.keyWord = searchTextField.text
            
            if(validateSearch()){
                searchVCDelegate.searchAd(keyword: self.keyWord, start: self.startDate, end: self.endDate, sortOption: self.sortOption)
                self.dismiss(animated: false)
            }
        }
    }
    
    private func validateSearch() -> Bool{
        if keyWord == nil || keyWord == "" {
//            Utils.instance.showAlert(title: nil, message: "Enter Keyword..", viewController: self, handler: nil)
            let snackbar = TTGSnackbar(message: "Enter Keyword..", duration: .middle)
            snackbar.show()
            return false
        }
        guard startDate != nil else {
//            Utils.instance.showAlert(title: nil, message: "Select start date..", viewController: self, handler: nil)
            let snackbar = TTGSnackbar(message: "Select start date..", duration: .middle)
            snackbar.show()
            return false
        }
        guard endDate != nil else {
//            Utils.instance.showAlert(title: nil, message: "Select end date..", viewController: self, handler: nil)
            let snackbar = TTGSnackbar(message: "Select end date..", duration: .middle)
            snackbar.show()
            return false
        }
        guard sortOption != nil else {
//            Utils.instance.showAlert(title: nil, message: "Select sort option..", viewController: self, handler: nil)
            let snackbar = TTGSnackbar(message: "Select sort option..", duration: .middle)
            snackbar.show()
            return false
        }
        return true
    }
    
    private func configureSortOptionDropDown()
    {
        sortOptionDown.anchorView = self.sortOptionDropLbl
        sortOptionDown.dataSource = sortOptions
       
        sortOptionDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.sortOptionLbl.text = item
            self.sortOption = item
            self.sortOptionLbl.font = Config.setFont(size: 14, weight: FontWeight.regular)
        }
    }
    
    private func datePickerTapped(start:Bool!) {
        if start {
            DatePickerDialog().show("Start Date Picker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
                (date) -> Void in
                if let dt = date {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    self.startDate = formatter.string(from: dt)
                    self.startDateButton.setTitle(self.startDate! + " to ", for: .normal)
                }
            }
        } else {
            DatePickerDialog().show("End Date Picker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
                (date) -> Void in
                if let dt = date {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    self.endDate = formatter.string(from: dt)
                    self.endDateButton.setTitle(self.endDate, for: .normal)
                }
            }
        }
    }
}


//MARK: - Delegates and Datasources
extension SearchViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.dismissKeyboard()
        return true
    }
    
    @available(iOS 10.0, *)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.dismissKeyboard()
    }
}


