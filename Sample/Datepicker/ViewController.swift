//
//  ViewController.swift
//  Datepicker
//
//  Created by Sreehari M Nambiar on 04/05/20.
//  Copyright © 2020 Sreehari M Nambiar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SMDatePickerDelegate {
    
    

    var datepicker = SMDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var minDateComp = DateComponents()
        minDateComp.day = 10
        minDateComp.month = 6
        minDateComp.year = 2019
        let minDate = Calendar.current.date(from: minDateComp)!
        
        var maxDateComp = DateComponents()
        maxDateComp.day = 10
        maxDateComp.month = 9
        maxDateComp.year = 2019
        let maxDate = Calendar.current.date(from: maxDateComp)!
        
        datepicker.minimumDate = minDate
        datepicker.maximumDate = maxDate
        datepicker.delegate = self
        datepicker.title = "Date of Birth"
        datepicker.confirmationTitle = "Done"
        
    }

    @IBAction func dateOfBirthTapped(_ sender: Any) {
        datepicker.present(from: self)
        
    }
    
    func didCancelDateSelection() {
        print("Cancelled")
    }
    
    func didSelect(date: Date) {
        print("Selected: \(date)")
    }
}


