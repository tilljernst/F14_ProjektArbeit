//: Playground - noun: a place where people can play

import UIKit

var startDate = Date()

print(startDate)

startDate = NSDate() as Date
startDate.addingTimeInterval(10000)

let calendar = Calendar.current

startDate = calendar.date(bySettingHour: 10, minute: 0, second: 0, of: startDate)!

print(startDate)

