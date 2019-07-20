/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

// Specification for HTML colors http://www.w3.org/TR/css3-color/
import Foundation

extension CSSColor {
  // Nested type
  // Enum can be used to define constants
  enum ColorName: String, CaseIterable {
    case black, silver, gray, white, maroon, red, purple, fuchsia, green,
      lime, olive, yellow, navy, blue, teal, aqua
  }
}

enum CSSColor {
  // Enum can contain associated values for each case.
  case named(name: ColorName)
  case rgb(red: UInt8, green: UInt8, blue: UInt8)
}

// Enums can adopt protocols, have methods and computed properties
extension CSSColor: CustomStringConvertible {
  var description: String {
    switch self {
    case .named(let colorName):
      return colorName.rawValue
    case .rgb(let red, let green, let blue):
      return String(format: "#%02X%02X%02X", red, green, blue)
    }
  }
}

for color in CSSColor.ColorName.allCases {
  print("I love the color \(color).")
}

let color1 = CSSColor.named(name: .red)
let color2 = CSSColor.rgb(red: 0xAA, green: 0xAA, blue: 0xAA)
print("color1 = \(color1), color2 = \(color2)")

extension CSSColor {
  init(gray: UInt8) {
    self = .rgb(red: gray, green: gray, blue: gray)
  }
}

let color3 = CSSColor(gray: 0xaa)
print(color3)

// Protocols are used to define a blueprint for your model.

protocol DrawingContext {
  func draw(_ circle: Circle)
  func draw(_ rectangle: Rectangle)
  // more primitives would go here ...
}

protocol Drawable {
  func draw(with context: DrawingContext)
}

@dynamicMemberLookup
struct Circle: Drawable {
  var strokeWidth = 5
  var strokeColor = CSSColor.named(name: .red)
  var fillColor = CSSColor.named(name: .yellow)
  var center = (x: 80.0, y: 160.0)
  var radius = 60.0
  
  subscript(dynamicMember member: String) -> String {
    let properties = ["name": "Mr Circle"]
    return properties[member, default: ""]
  }
  
  // Adopting the Drawable protocol.
  
  func draw(with context: DrawingContext) {
    context.draw(self)
  }
}

// A Rectangle type

struct Rectangle: Drawable {
    var strokeWidth = 5
    var strokeColor = CSSColor.named(name: .teal)
    var fillColor = CSSColor.named(name: .aqua)
    var origin = (x: 110.0, y: 10.0)
    var size = (width: 100.0, height: 130.0)

    func draw(with context: DrawingContext) {
        context.draw(self)
    }
}


let circle = Circle()
let circleColor = circle.name

// Example of computed properties.
extension Circle {
  // Diameter setter / getter that maintains radius
  var diameter: Double {
    get {
      return radius * 2
    }
    set {
      radius = newValue / 2
    }
  }
}

// Our SVGContext is the rendering workhorse for SVGDocuments.  Since it has the
// role of a data sync, taking in commands, using a class is a good choice.

final class SVGContext: DrawingContext {
  private var commands: [String] = []
  
  var width = 250
  var height = 250
  
  func draw(_ circle: Circle) {
    let command = """
    <circle cx='\(circle.center.x)' cy='\(circle.center.y)\' r='\(circle.radius)' \
    stroke='\(circle.strokeColor)' fill='\(circle.fillColor)' \
    stroke-width='\(circle.strokeWidth)' />
    """
    commands.append(command)
  }

  func draw(_ rectangle: Rectangle) {
    let command = """
    <rect x='\(rectangle.origin.x)' y='\(rectangle.origin.y)' \
    width='\(rectangle.size.width)' height='\(rectangle.size.height)' \
    stroke='\(rectangle.strokeColor)' fill='\(rectangle.fillColor)' \
    stroke-width='\(rectangle.strokeWidth)' />
    """
    commands.append(command)
  }

  var svgString: String {
    var output = "<svg width='\(width)' height='\(height)'>"
    for command in commands {
      output += command
    }
    output += "</svg>"
    return output
  }
  
  var htmlString: String {
    return "<!DOCTYPE html><html><body>" + svgString + "</body></html>"
  }
}

// You can create an SVGDocument that renders our pure shape geometry models
// into SVG markup.  Drawable is not coupled at all with the SVG technology.
// We could just as easily create other document types based on other 
// technologies such as OpenGL, CoreGraphics, or something else.

struct SVGDocument {
  var drawables: [Drawable] = []
  
  var htmlString: String {
    let context = SVGContext()
    for drawable in drawables {
      drawable.draw(with: context)
    }
    return context.htmlString
  }
  
  // Because we are using a struct model type methods must be marked explicitly
  // mutating.
  
  mutating func append(_ drawable: Drawable) {
    drawables.append(drawable)
  }
}

// Usage example.  Example of creating a default circle and rectangle.

var document = SVGDocument()

let rectangle = Rectangle()
document.append(rectangle)
document.append(circle)

let htmlString = document.htmlString
print(htmlString)

// Bonus.  Use WebKit to render the SVGDocument.

import WebKit
import PlaygroundSupport

let view = WKWebView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
view.loadHTMLString(htmlString, baseURL: nil)
PlaygroundPage.current.liveView = view


// Define some basic geometery

extension Circle {
  // Example of getter-only computed properties
  var area: Double {
    return radius * radius * Double.pi
  }
  var perimeter: Double {
    return 2 * radius * Double.pi
  }
}

extension Rectangle {
  var area: Double {
    return size.width * size.height
  }
  var perimeter: Double {
    return 2 * (size.width + size.height)
  }
}

// ClosedShapeType is an example of retroactive modeling.
// Now you can compute the totalPerimeter of collections of ShapeGeometry types.

protocol ClosedShapeType {
  var area: Double { get }
  var perimeter: Double { get }
}

extension Circle: ClosedShapeType {}
extension Rectangle: ClosedShapeType {}

func totalPerimeter(shapes: [ClosedShapeType]) -> Double {
  return shapes.reduce(0) { $0 + $1.perimeter }
}
