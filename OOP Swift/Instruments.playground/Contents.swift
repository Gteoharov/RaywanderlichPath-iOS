class Piano: Instrument {
    let hasPedals: Bool
    
    static let whiteKeys = 52
    static let blackKeys = 36
    
    init(brand: String, hasPedals: Bool = false) {
        self.hasPedals = hasPedals
        super.init(brand: brand)
    }
    
    override func tune() -> String {
        return "Piano stadard tuning for \(brand)"
    }
    
    override func play(_ music: Music) -> String {
        return play(music, usingPedals: hasPedals)
    }
    
    func play(_ music: Music, usingPedals: Bool) -> String {
        let preparedNotes = super.play(music)
        if hasPedals && usingPedals {
            return "Play piano notes \(preparedNotes) with pedals"
        } else {
            return "Play piano notes \(preparedNotes) without pedals"
        }
    }

}

let newInstrument = Instrument(brand: "Bosse")

let piano = Piano(brand: "Yamaha", hasPedals: true)
piano.tune()

let music = Music(notes: ["C", "G", "F"])
piano.play(music, usingPedals: false)
piano.play(music)
Piano.whiteKeys
Piano.blackKeys

class Guitar: Instrument {
    let stringGauge: String
    
    init(brand: String, stringGauge: String = "mediumm") {
        self.stringGauge = stringGauge
        super.init(brand: brand)
    }
}

class AcousticGuitar: Guitar {
    static let numberOfStrings = 6
    static let fretCount = 20
    
    override func tune() -> String {
        return "Tune \(brand) acoustic with E A D G B E"
    }
    
    override func play(_ music: Music) -> String {
        let preparedNotes = super.play(music)
        return "Play folk tune of frets \(preparedNotes)."
    }
}

let rolandBrandGuitar = AcousticGuitar(brand: "Roland")
rolandBrandGuitar.tune()
rolandBrandGuitar.play(music)

class Amplifier {
    
    private var _volume: Int
    
    private(set) var isOn: Bool
    
    init() {
        isOn = false
        _volume = 0
    }
    
    func plugIn() {
        isOn = true
    }
    
    func unplug() {
        isOn = false
    }
    
    var volume: Int {
        get {
            return isOn ? _volume : 0
        }
        set {
            _volume = min(max(newValue, 0), 10)
        }
    }
}

class ElectricGuitar: Guitar {
    let amplifier: Amplifier
    
    init(brand: String, stringGauge: String = "light", amplifier: Amplifier) {
        self.amplifier = amplifier
        super.init(brand: brand, stringGauge: stringGauge)
    }
    
    override func tune() -> String {
        amplifier.plugIn()
        amplifier.volume = 5
        return "Tune \(brand) electric with E A D G B E"
    }
    
    override func play(_ music: Music) -> String {
        let preparedNotes = super.play(music)
        return "Play solo \(preparedNotes) at volume \(amplifier.volume)."
    }
}

class BassGuitar: Guitar {
    let amplifier: Amplifier
    
    init(brand: String, stringGauge: String = "heavy", amplifier: Amplifier) {
        self.amplifier = amplifier
        super.init(brand: brand, stringGauge: stringGauge)
    }
    
    override func tune() -> String {
        amplifier.plugIn()
        return "Tune \(brand) bass with E A D G"
    }
    
    override func play(_ music: Music) -> String {
        let preparedNotes = super.play(music)
        return "Play bass line \(preparedNotes) at volume \(amplifier.volume)"
    }
}

let simpleAmplifier = Amplifier()

let gibsonElectricGuitar = ElectricGuitar(brand: "Gibson", amplifier: simpleAmplifier)
gibsonElectricGuitar.tune()
let fenderBassGuitar = BassGuitar(brand: "Fender", amplifier: simpleAmplifier)
fenderBassGuitar.tune()

gibsonElectricGuitar.amplifier.volume
fenderBassGuitar.amplifier.volume
fenderBassGuitar.amplifier.unplug()
gibsonElectricGuitar.amplifier.volume
fenderBassGuitar.amplifier.volume

fenderBassGuitar.amplifier.plugIn()
fenderBassGuitar.amplifier.volume
gibsonElectricGuitar.amplifier.volume

class Band {
    
    let instruments: [Instrument]
    
    init(instruments: [Instrument]) {
        self.instruments = instruments
    }
    
    func perform(_ music: Music) {
        for instrument in instruments {
            instrument.perform(music)
        }
    }
}

let instruments = [piano, rolandBrandGuitar, gibsonElectricGuitar, fenderBassGuitar]
let band = Band(instruments: instruments)
band.perform(music)
