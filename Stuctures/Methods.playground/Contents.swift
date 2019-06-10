import UIKit

enum Weekday: CaseIterable {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    
    mutating func advance(by dayCount: UInt) {
        let indexOfToday = Weekday.allCases.firstIndex(of: self)!
        let indexOfAdvancedDay = indexOfToday + Int(dayCount)
        
        self = Weekday.allCases[indexOfAdvancedDay % Weekday.allCases.count]
    }
}

Weekday.allCases

var weekday: Weekday = .tuesday
weekday.advance(by: 5)

struct Time {
    var day: Weekday
    var hour: UInt
    
    init(day: Weekday, hour: UInt = 0) {
        self.day = day
        self.hour = hour
    }
    
    mutating func advance(byHours hourCount: UInt) {
        
    }
}

var time = Time(day: .monday)



