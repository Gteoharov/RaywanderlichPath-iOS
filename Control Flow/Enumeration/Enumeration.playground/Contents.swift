import UIKit

enum Month: Int {
    case january = 1, february, march, april, may, june, july, august,
    september, october, november, december
}

Month.january.rawValue
Month(rawValue: 5)

enum Semester {
    /// 🍁
    case fall
    
    /// 🌸
    case spring
    
    /// ☀️
    case summer
}

let month: Month = .october

let semester: Semester
switch month {
    case .august, .september, .october, .november, .december:
        semester = .fall
    case .january, .february, .march, .april, .may:
        semester = .spring
    case .june, .july:
        semester = .summer
}

let monthUntilWinterBreak = Month.december.rawValue - month.rawValue

enum TwoDimensionalPoint {
    case origin
    case onXAxis(Double)
    case onYAxis(Double)
    case noZeroCoordinate(Double, Double)
}

let coordinates = (1.0, 3.0)
let twoDimensionalPoint: TwoDimensionalPoint

switch coordinates {
case (0, 0):
    twoDimensionalPoint = .origin
case (_, 0):
    twoDimensionalPoint = .onXAxis(coordinates.0)
case (0, _):
    twoDimensionalPoint = .onYAxis(coordinates.1)
default:
    twoDimensionalPoint = .noZeroCoordinate(coordinates.0, coordinates.1)
}

let pointValue: (Double, Double)

switch twoDimensionalPoint {
case .origin:
    pointValue = (0, 0)
case let .onXAxis(x):
    pointValue = (x, 0)
case .onYAxis(let y):
    pointValue = (0, y)
case .noZeroCoordinate(let x, let y):
    pointValue = (x, y)
}
