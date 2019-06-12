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
weekday.advance(by: 8)

struct Time {
    var day: Weekday
    var hour: UInt
    
    init(day: Weekday, hour: UInt = 0) {
        self.day = day
        self.hour = hour
    }
    
    mutating func advance(byHours hourCount: UInt) {
        let (dayCount, hour) = (self.hour + hourCount).quotientAndRemainder(dividingBy: 24)
        day.advance(by: dayCount)
        self.hour = hour
    }
    
    func advanced(byHours hourCount: UInt) -> Time {
        var time = self
        time.advance(byHours: hourCount)
        return time
    }
}

let time = Time(day: .monday)
var advancedTime = time.advanced(byHours: 24 * 3 + 5)
time
