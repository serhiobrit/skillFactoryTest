import UIKit
import Foundation

// ---------------------- 1 -----------------------
print ("---------------------- 1 -----------------------")
//Создайте кортеж для двух человек с одинаковыми типами данных и параметрами.
//При том одни значения доставайте по индексу, а другие — по параметру.

let firstPerson = (age: 18, name: "Ivan", surname: "Ivanov")
let secondPerson = (age: 24, name: "Petr", surname: "Petrov")
let firstPersonAge = firstPerson.0
let firstPersonName = firstPerson.1
let firstPersonLastName = firstPerson.2
let sesondPersonAge = secondPerson.age
let sesondPersonName = secondPerson.name
let sesondPersonLastName = secondPerson.surname

// ---------------------- 2 -----------------------
print ("---------------------- 2 -----------------------")
//Создайте массив «дни в месяцах» (12 элементов содержащих количество дней в соответствующем месяце). Используя цикл for и этот массив:
//выведите количество дней в каждом месяце
//используйте еще один массив с именами месяцев чтобы вывести название месяца + количество дней


let months: [String] = ["January", "Fabuary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

let daysInMonth: [Int] = [31, 28, 31, 30, 31, 30, 31, 30, 31, 30, 31, 31]

for month in 1..<months.count {
    print ("В \(months[month]) \(daysInMonth[month]) дней")
}

print ("------------------------------------------------------------------------------")

//сделайте тоже самое, но используя массив кортежей с параметрами (имя месяца, количество дней)

var january: (String, Int) = ("January", 31)
var fabuary: (String, Int) = ("Fabuary", 30)
var march: (String, Int) = ("March", 31)
var april: (String, Int) = ("April", 30)
var may: (String, Int) = ("May", 31)
var june: (String, Int) = ("June", 30)
var july: (String, Int) = ("July", 31)
var august: (String, Int) = ("August", 30)
var september: (String, Int) = ("September", 31)
var october: (String, Int) = ("October", 30)
var november: (String, Int) = ("November", 31)
var december: (String, Int) = ("December", 31)

var daysInMonth1 = [january, fabuary, march, april, may, june, july, august, september, october, november, december]

for month in 0..<daysInMonth1.count {
    print ("В \(daysInMonth1[month].0) \(daysInMonth1[month].1) дней")
}

print ("------------------------------------------------------------------------------")

//сделайте тоже самое, только выводите дни в обратном порядке (порядок в исходном массиве не меняется)

for month in (0..<daysInMonth1.count).reversed() {
    print ("В \(daysInMonth1[month].0) \(daysInMonth1[month].1) дней")
}

print ("------------------------------------------------------------------------------")


//для произвольно выбранной даты (месяц и день) посчитайте количество дней до конца года
//я придумал пока только вариант с заданием и номера месяца, но не понял, как его высчитать можно

let today: (String, Int, Int) = ("November", 16, 10)
var daysTilMonthEnd: Int

func summDays (chooseMonth: Int) -> Int {
    let leftMonths = daysInMonth1.filter{$0 > daysInMonth1[chooseMonth]}
    var leftDays: Int = 0
    for i in 0..<leftMonths.count {
        leftDays += leftMonths[i].1
    }
    return leftDays
}

for month in 0..<daysInMonth1.count {
    if today.0 == daysInMonth1[month].0 {
        daysTilMonthEnd = daysInMonth1[month].1 - today.1
        let summDaysTilYearEnd = daysTilMonthEnd + summDays(chooseMonth: today.2)
        print ("До конца года осталось \(summDaysTilYearEnd) дней")
    }
}

// ---------------------- 3 -----------------------
print ("---------------------- 3 -----------------------")
//Создайте словарь, как журнал студентов, где имя и фамилия студента это ключ, а оценка за экзамен — значение.

var students: [String: Int] = ["Иванов Иван": 5, "Петров Петр": 1, "Семенов Семен": 3]

//Повысьте студенту оценку за экзамен
//Если оценка положительная (4 или 5) или удовлетворительная (3), то выведите сообщение с поздравлением, отрицательная (1, 2) - отправьте на пересдачу

let newMark = 4
let studentName = "Семенов Семен"
students.updateValue(newMark, forKey: studentName)
if students[studentName]! > 2 {
    print("Поздравляю с успешной пересдачей")
} else {
    print("Стоит подготовиться получше и попробовать в другой раз")
}

//Добавьте еще несколько студентов — это ваши новые одногруппники!

students["Новая Галина"] = 3
students["Новая Светлана"] = 5

//Удалите одного студента — он отчислен

students["Петров Петр"] = nil

//Посчитайте средний балл всей группы по итогам экзамена.
//Не пойму, как в Double перевести -- он сначала считает в Int, а потом уже переводит в Double

let marks = [Int](students.values)
let total = marks.reduce(0, +)
let bandScrore = Double (total / marks.count)
