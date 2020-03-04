import UIKit

enum Action: String {
    case start = "Двигатель запущен"
    case stop = "Двигатель остановлен"
    case open = "Двери открыты"
    case close = "Двери закрыты"
    case w_open = "Окна открыты"
    case w_close = "Окна закрыты"
}

enum SportCarAction: String {
    case nitroOn = "Нитро включен"
    case nitroOff = "Нитро выключен"
    case espOn = "ESP включен"
    case espOff = "ESP выключен"
}

enum Brand: String {
    case bmw = "BMW"
    case mercedes = "Mercedes-Benz"
    case audi = "Audi"
    case VW = "VolksWagen"
    case kamaz = "Kamaz"
}

protocol Car {
    var brand: Brand { get set }
    var odometer: Int { get set }
    var engineState: Action {get set}
    var windowState: Action {get set}
    var doorState: Action {get set}
    
}
extension Car {
    mutating func startEngine(){
        engineState =  .start
    }
    mutating func stopEngine(){
        engineState =  .stop
    }
    
    mutating func openWindow(){
        windowState =  .w_open
    }
    
    mutating func closeWindow(){
        windowState =  .w_close
    }
    
    mutating func openDoor(){
        windowState =  .open
    }
    
    mutating func closeDoor(){
        windowState =  .close
    }
    func carState() -> Void {
        print(engineState.rawValue)
        print(doorState.rawValue)
        print(windowState.rawValue)
    }
}

class TrunkCar:Car {
    var brand: Brand
    var odometer: Int
    var engineState: Action
    var windowState: Action
    var doorState: Action
    var trailerSize: UInt = 0
    private(set) var trailerUsedSpace: UInt = 0
    private(set) var printableState: String = ""
    
    init(brand: Brand, odometer: Int, trailerSize: UInt) {
        self.brand = brand
        self.odometer = odometer
        self.trailerSize = trailerSize
        engineState = .stop
        windowState = .w_close
        doorState = .close
    }
    func trailerLoad(Load: UInt) -> String {
        if trailerSize >= Load {
            self.trailerUsedSpace = Load
            return "Загружено \(Load) осталось \(trailerSize - trailerUsedSpace)"
        }else{
            return "Перегрузка!"
        }
    }
    func trailerUnLoadAll(){
        trailerUsedSpace = 0
    }
    func trailerFreeSpace() {
        print(trailerSize - trailerUsedSpace)
    }
}
extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "Бренд: \(brand)\r\nПробег: \(odometer)\r\n\(engineState.rawValue)\r\n\(doorState.rawValue)\r\nЗагружено: \(trailerUsedSpace)\r\nОсталось места: \(trailerSize - trailerUsedSpace)\r------------------\r"
    }
}

class SportCar: Car {
    var brand: Brand
    var odometer: Int
    var engineState: Action
    var windowState: Action
    var doorState: Action
    private(set) var nitroStat: SportCarAction
    private(set) var espStat: SportCarAction
    private(set) var printableState: String = ""
    
    init(brand: Brand, odometer: Int) {
        self.brand = brand
        self.odometer = odometer
        engineState = .stop
        windowState = .w_close
        doorState = .close
        nitroStat = .nitroOff
        espStat = .espOn
    }
    func espOn() {
        espStat = .espOn
    }
    func espOff() {
        espStat = .espOff
    }
    func nitroChangeState() {
        switch nitroStat {
        case .nitroOff:
            nitroStat = .nitroOn
        default:
            nitroStat = .nitroOff
        }
    }
}
extension SportCar: CustomStringConvertible {
    var description: String {
        return "Бренд: \(brand)\r\nПробег: \(odometer)\r\n\(engineState.rawValue)\r\n\(doorState.rawValue)\r\n\(nitroStat.rawValue)\r\n\(espStat.rawValue)\r------------------\r"
    }
}


var trunkCar = TrunkCar(brand: .kamaz, odometer: 0, trailerSize: 30000)
trunkCar.trailerLoad(Load: 9000)
print(trunkCar)

var sportCar = SportCar(brand: .audi, odometer: 0)
sportCar.espOff()
sportCar.nitroChangeState()
print(sportCar)
