//
//  CalemdarVars.swift
//  Calendario
//
//  Created by Lia Kassardjian on 15/07/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation


let date = Date()
let calendar = Calendar.current

let day = calendar.component(.day, from: date)
var weekDay = calendar.component(.weekday, from: date)
var month = calendar.component(.month, from: date)
var year = calendar.component(.year, from: date)
