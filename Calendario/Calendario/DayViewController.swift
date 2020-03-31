//
//  DayViewController.swift
//  Calendario
//
//  Created by Lia Kassardjian on 15/07/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

class DayViewController: UIViewController {

    @IBOutlet weak var dayLabel: UILabel!
    
    let months = ["janeiro","fevereiro","março","abril","maio","junho","julho","agosto","setembro","outubro","novembro","dezembro"]
    
    let weekdays = ["Domingo","Segunda-feira","Terça-feira","Quarta-feira","Quinta-feira","Sexta-feira","Sábado"]
    
    var daysInMonths = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    var currentMonth = String()
    
    var currentDay = Int()
    
    var currentWeekDay = String()
    
    var currentYear = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentMonth = months[month - 1]
        currentDay = day
        currentWeekDay = weekdays[weekDay - 1]
        currentYear = year
        
        dayLabel.text = "\(currentWeekDay), \(currentDay) de \(currentMonth) de \(year)"
        
    }
    
    @IBAction func next(_ sender: Any) {
        if currentDay == daysInMonths[month - 1] {
            switch currentMonth {
            case "dezembro":
                month = 1
                year += 1
            default:
                month += 1
            }
            currentMonth = months[month - 1]
            currentDay = 1
        }
        else {
            currentDay += 1
        }
        
        switch currentWeekDay {
        case "Sábado":
            weekDay = 1
        default:
            weekDay += 1
        }
        currentWeekDay = weekdays[weekDay - 1]
        
        dayLabel.text = "\(currentWeekDay), \(currentDay) de \(currentMonth) de \(year)"
    }
    
    @IBAction func back(_ sender: Any) {
        if currentDay == 1 {
            switch currentMonth {
            case "janeiro":
                month = 12
                year -= 1
            default:
                month -= 1
            }
            currentMonth = months[month - 1]
            currentDay = daysInMonths[month - 1]
        }
        else {
            currentDay -= 1
        }
        
        switch currentWeekDay {
        case "Domingo":
            weekDay = 7
        default:
            weekDay -= 1
        }
        currentWeekDay = weekdays[weekDay - 1]
        
        dayLabel.text = "\(currentWeekDay), \(currentDay) de \(currentMonth) de \(year)"
    }
    
}
