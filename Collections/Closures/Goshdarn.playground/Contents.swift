import UIKit

// As a variable:

var closureName: () -> ()

// As an optional variable:

var closureNameOptional: ((String) -> String)?

// As a type alias:

typealias ClosureType = (String) -> String


let closureNameConstant: ClosureType = { $0.uppercased() }


