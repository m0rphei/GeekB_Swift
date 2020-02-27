import Foundation

//enum Action {
//    case start, stop
//    case open, close
//}
//enum Brand: String {
//    case bmw = "BMW"
//    case mercedes = "Mercedes-Benz"
//    case audi = "Audi"
//    case VW = "VolksWagen"
//}
//
//
//class Car {
//    static var count = 0
//
//    static func printCount() {
//        print("Выпущено \(Car.count) автомобилей")
//    }
//
//    var brand: Brand = .audi
//    var model: String = "A7"
//    var color: String = "Purple"
//    private(set) var doorState: Action = .close
//    private(set) var engineState: Action = .start
//
//    init(brand: Brand, model: String, color: String){
//        self.brand = brand
//        self.model = model
//        self.color = color
//
//        Car.count += 1
//    }
//
//    func doSomething(_ action: Action){
//        switch action {
//        case .close,.open:
//            self.doorState = action
//        case .start,.stop:
//            self.engineState = action
//        }
//    }
//    deinit {
//        Car.count -= 1
//    }
//}
//
//class LearningCar: Car {
//    var maxSpeed: Int
//    var seetCount: Int
//
//    init(brand: Brand, model: String, color: String, maxSpeed: Int, seetCount: Int){
//        self.maxSpeed = maxSpeed
//        self.seetCount = seetCount
//        super.init(brand: brand, model: model, color: color)
//    }
//    override func doSomething(_ action: Action) {
//        super.doSomething(action)
//    }
//}
//
//final class CustomLeagrningCar: LearningCar {
//    override func doSomething(_ action: Action) {
//        print("Кастомизированный учебный автомобиль")
//    }
//}
//
//
//
//print(Car.count)
//
//var car = Car(brand: .bmw, model: "M4", color: "White")
//var car2 = Car(brand: .mercedes, model: "G63", color: "Black")
//var car3 = Car(brand: .audi, model: "A6", color: "Gray")
//var car4 = Car(brand: .VW, model: "Amarok", color: "Blue")

//print(Car.count)
//
//var car5 = CustomLeagrningCar(brand: .mercedes, model: "S500", color: "Gray", maxSpeed: 100, seetCount: 5)
//var car6 = CustomLeagrningCar(brand: .VW, model: "Polo", color: "Yellow", maxSpeed: 60, seetCount: 2)
//car5.doSomething(.open)
//car6.doSomething(.stop)
//print(car6.engineState)
//car2 = car
//car3 = car
//Car.printCount()
//print(Car.count)

//class NewCar {
//    var driver: Man?
//    deinit {
//        print("Car destroed")
//    }
//}
//class Man {
//    var myCar: NewCar?
//    deinit {
//        print("Man deleted")
//    }
//}
//var newCar = NewCar? = NewCar()
//var man: Man? = Man()
//
//newCar?.driver = man
//man?.myCar = newCar
//
//newCar = nil
//man = nil

/////////////////////////////////////////////
enum truckAction{
    case unloadAll
}
enum Action {
    case start
    case stop
    case open
    case close
    case unloadAll, printFreeSpace
    case nitroOn, nitroOff
    case espOn, espOff
    case systemStat
}
enum Brand: String {
    case bmw = "BMW"
    case mercedes = "Mercedes-Benz"
    case audi = "Audi"
    case VW = "VolksWagen"
    case kamaz = "Kamaz"
}
enum FuelType: String {
    case diesel = "Diesel"
    case ai92 = "АИ-92"
    case ai95 = "АИ-95"
    case ai98 = "АИ-98"
    case ai100 = "АИ-100"
}

class Car {
    static var count = 0
    var fuelType: FuelType = .ai92
    private(set) var doorState: Action = .close
    private(set) var engineState: Action = .start

    init(fuelType: FuelType) {
        Car.count += 1
        self.fuelType = fuelType
    }

    func doSomething(_ action: Action){
        switch action {
        case .close,.open:
            self.doorState = action
        case .start,.stop:
            self.engineState = action
        case .unloadAll:
            self.engineState = action
        default: break
        }
    }
    deinit {
        Car.count -= 1
    }
}

class TruckCar: Car {
    var brand: Brand
    var color: String
    var trailerSize: UInt = 0
    private(set) var trailerUsedSpace: UInt = 0

    init(brand: Brand, color: String, trailerSize: UInt, fuelType: FuelType){
        self.brand = brand
        self.color = color
        //self.fuelType = fuelType
        self.trailerSize = trailerSize
        super.init(fuelType: fuelType)
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
    override func doSomething(_ action: Action){
        switch action {
        case .unloadAll:
            self.trailerUsedSpace = 0
        case .printFreeSpace:
            print("Free space: \(trailerSize - trailerUsedSpace)")
        case .espOn,.espOff,.nitroOn,.nitroOff, .systemStat:
            print("Это не спорткар!")
            break
        default:
            super.doSomething(action)
        }
    }
}

class SportCar: Car {
    private(set) var nitroStat: Bool = false
    private(set) var espStat: Bool = true
    override func doSomething(_ action: Action){
        switch action {
        case .nitroOn:
            self.nitroStat = true
        case .nitroOff:
            self.nitroStat = true
        case .espOn:
            self.espStat = true
        case .espOff:
            self.espStat = false
        case .systemStat:
            var esp: String
            var nitro: String
            if self.espStat { esp = "On" } else { esp = "Off" }
            if self.nitroStat { nitro = "On" } else { nitro = "Off" }
            print("Esp: \(esp)\r\nNitro: \(nitro)")
        case .unloadAll,.printFreeSpace:
            print("Это не грузовик!")
            break
        default:
            super.doSomething(action)
        }
    }
}

var truck2 = TruckCar(brand: .kamaz, color: "White", trailerSize: 30000, fuelType: .diesel)
truck2.trailerLoad(Load: 600)
truck2.doSomething(.printFreeSpace)
truck2.doSomething(.unloadAll)
truck2.doSomething(.printFreeSpace)
truck2.doSomething(.nitroOn)
print(Car.count)

var sportCar1 = SportCar(fuelType: .ai100)
sportCar1.doSomething(.printFreeSpace)
sportCar1.doSomething(.espOff)
sportCar1.doSomething(.nitroOn)
sportCar1.doSomething(.systemStat)

