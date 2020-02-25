import Foundation
//
//enum EngineState {
//    case start
//    case stop
//}
//
//enum Brand: String {
//    case bmw = "BMW"
//    case mercedes = "Mercedes-Benz"
//    case audi = "Audi"
//    case VW = "VolksWagen"
//
//    var name: String {
//        return "Имя бренда: \(rawValue)"
//    }
//
//    func calculatePriority() -> String {
//        return "Priority of brand"
//    }
//}
//
//enum CarState {
//    case new
//    case secondHand(odd: Double)
//}
//
//struct Car {
//    var brand: Brand
//    var model: String
//    var color: String
//    var mileage: CarState = .new //var mileage = CarState.new
//
//    var price: Int = 500_000
//    private(set) var currentDiscount: Int = 0
//
//    var discount: Int {
//        get{
//            return currentDiscount
//        }
//        set{
//            if currentDiscount != 0 {
//                price = price / ( 100 - currentDiscount ) * 100
//            }
//            guard currentDiscount != 0 else { return }
//            currentDiscount = newValue
//            price -= ( price / newValue )
//        }
//    }
//    private(set) var engineState: EngineState = .stop {
//        willSet {
//            print("Значение будет изменено с \(engineState) на \(newValue)")
//        }
//        didSet {
//            print("Состояние двигателя поменялось с \(oldValue) на \(engineState)")
//        }
//    }
//
//    init(brand: Brand, model: String,  color: String,  mileage: CarState = .new, price: Int ) {
//        self.brand = brand
//        self.model = model
//        self.color = color
//        self.mileage = mileage
//        self.price = price
//    }
//    init?(brand: Brand) {
//        guard brand == .bmw else { return nil }
//        self.brand = .bmw
//        self.model = "X7"
//        self.color = "White"
//        self.mileage = .new
//        self.price = 7_900_000
//    }
//
//    mutating func changeEngineState() {
//        if engineState == .stop {
//            self.engineState = .start
//        }else{
//            self.engineState = .stop
//        }
//    }
//}
//
//var brand1 = Brand.mercedes
//brand1.name
//brand1.calculatePriority()
//
//var state = CarState.secondHand(odd: 15_000)
//
//switch state {
//case .new:
//    print("Новый автомобиль из салона")
//case .secondHand(let odd):
//    print("Автомобиль с пробегом \(odd) км")
//}
//
//var car = Car(brand: .bmw, model: "X5", color: "Gray", mileage: .secondHand(odd: 100_000), price: 1_000_000)
//var newCar = Car(brand: .mercedes, model: "G63", color: "Black", price: 10_000_000)
//var newBmwX7 = Car(brand: .bmw)
//
//if let car = newBmwX7 {
//    print(car)
//}
//car.discount = 10
//print(car.price)
//car.discount = 0
//print(car.price)
//car.changeEngineState()


//1. Описать несколько структур – любой легковой автомобиль и любой грузовик.
//2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
//3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
//4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
//5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.

enum EngineState {
    case start
    case stop
}

enum WindowsState {
    case open
    case closed
}

enum DoSome {
    case engineStart
    case engineStop
    case wondowsOpen
    case wondowsClose
    case cargoLoad
    case cargoUnLoad
    case cargoUnLoadAll
}

enum CarBrand: String {
    case bmw = "BMW"
    case mercedes = "Mercedes-Benz"
    case audi = "Audi"
    case VW = "VolksWagen"
}

enum TruckBrand: String {
    case mercedes = "Mercedes-Benz"
    case VW = "VolksWagen"
    case kamaz = "Kamaz"
    case maz = "Maz"
}

struct Car {
    var brand: CarBrand
    var manufacturingYear: UInt16
    var trunkSize: Int
    private(set) var engineState: EngineState = .stop
    private(set) var windowsState: WindowsState = .closed
    private(set) var trunkUsedSpace: Int = 0
    
    mutating func changeEngineState() {
        if engineState == .stop {
            self.engineState = .start
        }else{
            self.engineState = .stop
        }
    }
    mutating func changeWindowsState() {
        if windowsState == .closed {
            self.windowsState = .open
        }else{
            self.windowsState = .closed
        }
    }
    mutating func trunkLoad(Load: Int) -> String {
        if trunkSize >= Load {
            self.trunkUsedSpace = Load
            return "Загружено \(Load) осталось \(trunkSize - Load)"
        }else{
            return "Перегрузка!"
        }
    }
    mutating func engineStart() -> Bool { if engineState == .stop { self.engineState = .start; return true }else{return false} }
    mutating func engineStop() -> Bool { if engineState == .start { self.engineState = .stop; return true }else{return false} }
    mutating func windowsOpen() -> Bool { if windowsState == .closed { self.windowsState = .open; return true }else{return false} }
    mutating func windowsClose() -> Bool { if windowsState == .open { self.windowsState = .closed; return true }else{return false} }
    mutating func whatICan(doIt: DoSome, Load: Int = 0) -> Bool {
        if doIt == .engineStart && engineState == .stop { self.engineState = .start; return true }
        if doIt == .engineStop && engineState == .start { self.engineState = .stop; return true }
        if doIt == .wondowsOpen && windowsState == .closed { self.windowsState = .open; return true }
        if doIt == .wondowsClose && windowsState == .open { self.windowsState = .closed; return true }
        if doIt == .cargoUnLoadAll { self.trunkUsedSpace = 0; return true }
        if doIt == .cargoLoad && Load > 0 && trunkSize >= Load { self.trunkUsedSpace = Load; return true }
        if doIt == .cargoUnLoad && Load > 0 && self.trunkUsedSpace >= Load { self.trunkUsedSpace -= Load; return true }
        return false
    }
    func printState(){
        print("Brand: \(brand)")
        print("Year: \(manufacturingYear)")
        print("Trunk size: \(trunkSize)")
        print("Trunk free space: \(trunkSize - trunkUsedSpace)")
        print("Engine state: \(engineState)")
        print("Windows state: \(windowsState)")
    }
}

struct Truck {
    var brand: TruckBrand
    var manufacturingYear: UInt16
    var trailerSize: Int
    private(set) var engineState: EngineState = .stop
    private(set) var windowsState: WindowsState = .closed
    private(set) var trailerUsedSpace: Int = 0
    
    init(brand: TruckBrand, manufacturingYear: UInt16, trailerSize: Int){
        self.brand = brand
        self.manufacturingYear = manufacturingYear
        self.trailerSize = trailerSize
    }
    mutating func changeEngineState() {
        if engineState == .stop {
            self.engineState = .start
        }else{
            self.engineState = .stop
        }
    }
    mutating func changeWindowsState() {
        if windowsState == .closed {
            self.windowsState = .open
        }else{
            self.windowsState = .closed
        }
    }
    mutating func trailerLoad(Load: Int) -> String {
        if trailerSize >= Load {
            self.trailerUsedSpace = Load
            return "Загружено \(Load) осталось \(trailerSize - Load)"
        }else{
            return "Перегрузка!"
        }
    }
    mutating func engineStart() -> Bool { if engineState == .stop { self.engineState = .start; return true }else{return false} }
    mutating func engineStop() -> Bool { if engineState == .start { self.engineState = .stop; return true }else{return false} }
    mutating func windowsOpen() -> Bool { if windowsState == .closed { self.windowsState = .open; return true }else{return false} }
    mutating func windowsClose() -> Bool { if windowsState == .open { self.windowsState = .closed; return true }else{return false} }
    mutating func whatICan(doIt: DoSome, Load: Int = 0) -> Bool {
        if doIt == .engineStart && engineState == .stop { self.engineState = .start; return true }
        if doIt == .engineStop && engineState == .start { self.engineState = .stop; return true }
        if doIt == .wondowsOpen && windowsState == .closed { self.windowsState = .open; return true }
        if doIt == .wondowsClose && windowsState == .open { self.windowsState = .closed; return true }
        if doIt == .cargoUnLoadAll { self.trailerUsedSpace = 0; return true }
        if doIt == .cargoLoad && Load > 0 && trailerSize >= Load { self.trailerUsedSpace = Load; return true }
        if doIt == .cargoUnLoad && Load > 0 && self.trailerUsedSpace >= Load { self.trailerUsedSpace -= Load; return true }
        return false
    }
    func printState(){
        print("Brand: \(brand)")
        print("Year: \(manufacturingYear)")
        print("Trailer size: \(trailerSize)")
        print("Trailer free space: \(trailerSize - trailerUsedSpace)")
        print("Engine state: \(engineState)")
        print("Windows state: \(windowsState)")
    }
}

var car1 = Car(brand: .audi, manufacturingYear: 2009, trunkSize: 508)
car1.changeEngineState()
car1.changeWindowsState()
var car1Load: String = car1.trunkLoad(Load: 300)
car1.windowsOpen()
car1.windowsClose()
car1.engineStop()
car1.whatICan(doIt: .engineStart)
car1.whatICan(doIt: .cargoUnLoad, Load: 200)
car1.whatICan(doIt: .cargoUnLoadAll)
car1.printState()


var truck1 = Truck(brand: .kamaz, manufacturingYear: 2012, trailerSize: 59000)
truck1.changeEngineState()
truck1.changeWindowsState()
var truck1Load: String = truck1.trailerLoad(Load: 3500)
truck1.engineStart()
truck1.engineStop()
truck1.whatICan(doIt: .engineStart)
truck1.whatICan(doIt: .cargoUnLoad, Load: 3000)
truck1
//truck1.whatICan(doIt: .cargoUnLoadAll)
truck1.printState()
