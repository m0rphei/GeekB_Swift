import Cocoa

//1. Решить квадратное уравнение.

var a: Double = 1 //первый коэффициент
var b: Double = 2 //второй коэффициент
var c: Double = 1 //свободный член
var x1: Double
var x2: Double

var d: Double = b*b-4*a*c //дискриминант
//print(d)
if d > 0 {
    x1 = ((-b) + sqrt(d)) / (2 * a)
    x2 = ((-b) - sqrt(d)) / (2 * a)
    print("x1 = ",x1)
    print("x2 = ",x2)
}
if d == 0 {
    x1 = -(b / (2 * a))
    print("x1 = x2 = ",x1)
}
if d < 0 {
    print("d < 0, Действительных корней уравнения не существует")
}

//2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.

var triangle_a: Double = 12 //катет a
var triangle_b: Double = 9 //катет b
var triangle_c: Double //гипотенуза
var triangle_S: Double //площадь
var triangle_P: Double //периметр

triangle_c = sqrt(pow(triangle_a,2) + pow(triangle_b,2))
print("Гипотенуза: ",triangle_c)

triangle_S = (triangle_a * triangle_b) / 2
print("Площадь: ",triangle_S)

triangle_P = triangle_a + triangle_b + sqrt(pow(triangle_a,2) + pow(triangle_b,2))
print("Периметр: ",triangle_P)

//3. * Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.

var deposit_amount: Double = 12000 //депозит
var deposit_term: Int = 5 //срок вклада - лет.
var annual_percentage: Double = 10 //годовой процент

repeat {
    deposit_term -= 1
    deposit_amount *= (1 + (annual_percentage / 100));
} while deposit_term > 0
print("Сумма: ",deposit_amount)
