//
//  ViewController.swift
//  Calendario
//
//  Created by Lia Kassardjian on 15/07/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var calendarCV: UICollectionView!
    
    @IBOutlet weak var monthLabel: UILabel!

    let months = ["Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"]
    
    let weekdays = ["Segunda-feira","Terça-feira","Quarta-feira","Quinta-feira","Sexta-feira","Sábado","Domingo"]
    
    var daysInMonths = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    var currentMonth = String()
    
    var numberOfEmptyBox = Int()
    
    var nextNumberOfEmptyBox = Int()
    
    var previousNumberOfEmptyBox = 0
    
    var direction = 0
    
    var positionIndex = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarCV.delegate = self
        calendarCV.dataSource = self
        
        currentMonth = months[month - 1]
        
        monthLabel.text = "\(currentMonth) \(year)"
    }

    
    
    @IBAction func next(_ sender: Any) {
        switch currentMonth {
        case "Dezembro":
            month = 1
            year += 1
            direction = 1
            getStartDateDayPosition()
            currentMonth = months[month - 1]
            monthLabel.text = "\(currentMonth) \(year)"
            calendarCV.reloadData()
            
        default:
            month += 1
            direction = 1
            getStartDateDayPosition()
            currentMonth = months[month - 1]
            monthLabel.text = "\(currentMonth) \(year)"
            calendarCV.reloadData()
        }
    }
    
    @IBAction func back(_ sender: Any) {
        switch currentMonth {
        case "Janeiro":
            month = 12
            year -= 1
            direction = -1
            getStartDateDayPosition()
            currentMonth = months[month - 1]
            monthLabel.text = "\(currentMonth) \(year)"
            calendarCV.reloadData()
            
        default:
            month -= 1
            direction = -1
            getStartDateDayPosition()
            currentMonth = months[month - 1]
            monthLabel.text = "\(currentMonth) \(year)"
            calendarCV.reloadData()
        }
        
    }
    
    func getStartDateDayPosition() {
        switch direction {
        case 0:
            switch day {
            case 1...7:
                numberOfEmptyBox = weekDay - day
            case 8...14:
                numberOfEmptyBox = weekDay - day - 7
            case 15...21:
                numberOfEmptyBox = weekDay - day - 14
            case 22...28:
                numberOfEmptyBox = weekDay - day - 21
            case 29...31:
                numberOfEmptyBox = weekDay - day - 28
            default:
                break
            }
            positionIndex = numberOfEmptyBox
        
        case 1...:
            nextNumberOfEmptyBox = (positionIndex + daysInMonths[month - 1])%7
            positionIndex = nextNumberOfEmptyBox
            
        case -1:
            previousNumberOfEmptyBox = (7 - (daysInMonths[month - 1] - positionIndex)%7)
            if previousNumberOfEmptyBox == 7 {
                previousNumberOfEmptyBox = 0
            }
            positionIndex = previousNumberOfEmptyBox
            
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if year%4 == 0 {
            daysInMonths[1] = 29
        } else {
            daysInMonths[1] = 28
        }
        
        switch direction {
        case 0:
            return daysInMonths[month - 1] + numberOfEmptyBox
        case 1...:
            return daysInMonths[month - 1] + nextNumberOfEmptyBox
        case -1:
            return daysInMonths[month - 1] + previousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = UIColor.clear
        cell.dateLabel.textColor = UIColor.black
        
        if cell.isHidden {
            cell.isHidden = false
        }
        
        switch direction {
        case 0:
            cell.dateLabel.text = "\(indexPath.row + 1 - numberOfEmptyBox)"
        case 1...:
            cell.dateLabel.text = "\(indexPath.row + 1 - nextNumberOfEmptyBox)"
        case -1:
            cell.dateLabel.text = "\(indexPath.row + 1 - previousNumberOfEmptyBox)"
        default:
            fatalError()
        }
        
        if Int(cell.dateLabel.text!)! < 1 {
            cell.isHidden = true
        }
        
        switch indexPath.row {
        case 5,6,12,13,19,20,26,27,33,34:
            if Int(cell.dateLabel.text!)! > 0 {
                cell.dateLabel.textColor = UIColor.lightGray
            }
        default:
            break
        }
        
        if currentMonth == months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 == day {
            cell.backgroundColor = UIColor.red
        }
        
        return cell
    }

}
