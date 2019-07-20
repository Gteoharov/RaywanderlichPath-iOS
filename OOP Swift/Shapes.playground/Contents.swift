import Foundation
import WebKit
import PlaygroundSupport




enum CSSColor {
    case named(name: ColorName)
    case rgb(red: UInt8, green: UInt8, blue: UInt8)
}

extension CSSColor {
    enum ColorName: String, CaseIterable {
        case red, black, blue, yellow, white, gray, green, purple, orange, pink
    }
}

extension CSSColor: CustomStringConvertible {
    var description: String {
        switch self {
        case .named(name: let colorName):
            return colorName.rawValue
        case .rgb(red: let red, green: let green, blue: let blue):
            return String(format: "#%02X%02X%02X", red, green, blue)
        }
    }
}

let color1 = CSSColor.named(name: .green)
let color2 = CSSColor.rgb(red: 0xAA, green: 0xAA, blue: 0xAA)
print("color1 = \(color1) color2 = \(color2)")

extension CSSColor {
    init(gray: UInt8) {
        self = .rgb(red: gray, green: gray, blue: gray)
    }
}

let color3 = CSSColor(gray: 0xaa)
print(color3)



for color in CSSColor.ColorName.allCases {
    print("I love \(color)")
}

protocol Drawble {
    func draw(with context: DrawingContext)
}

protocol DrawingContext {
    func draw(_ circle: Circle)
    func draw(_ rectangle: Rectangle)
}

struct Rectangle: Drawble {
    
    var strokeWidth = 5
    var strokeColor = CSSColor.named(name: .green)
    var fillColor = CSSColor.named(name: .blue)
    var origin = (x: 110.0, y: 130.0)
    var size = (width: 100.0, height: 130.0)
    
    
    func draw(with context: DrawingContext) {
        context.draw(self)
    }
}

@dynamicMemberLookup
struct Circle: Drawble {
    
    var strokeWidth = 5
    var strokeColor = CSSColor.named(name: .red)
    var fillColor = CSSColor.named(name: .yellow)
    var center = (x: 80.0, y: 160.0)
    var radius = 60.0
    
    func draw(with context: DrawingContext) {
        context.draw(self)
    }
    
    subscript(dynamicMember member: String) -> String {
        let properties = ["name": "Mr Circle"]
        return properties[member, default: ""]
    }
}

let circle = Circle()
let circleName = circle.name


final class SVGContext: DrawingContext {
    private var commands: [String] = []
    
    var width = 250
    var height = 250
    
    // 1
    func draw(_ circle: Circle) {
        let command = """
        <circle cx='\(circle.center.x)' cy='\(circle.center.y)\' r='\(circle.radius)' \
        stroke='\(circle.strokeColor)' fill='\(circle.fillColor)' \
        stroke-width='\(circle.strokeWidth)' />
        """
        commands.append(command)
    }
    
    // 2
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

struct SVGDocument {
    var drawables: [Drawble] = []
    
    var htmlString: String {
        let context = SVGContext()
        for drawble in drawables {
            drawble.draw(with: context)
        }
        return context.htmlString
    }
    
    mutating func append(_ drawble: Drawble) {
        drawables.append(drawble)
    }
}

var document = SVGDocument()

let rectangle = Rectangle()

document.append(rectangle)
let newCircle = Circle()
document.append(newCircle)
let htmlString = document.htmlString
print(htmlString)

let view = WKWebView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
view.loadHTMLString(htmlString, baseURL: nil)
PlaygroundPage.current.liveView = view
