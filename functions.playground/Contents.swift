import UIKit

// ---------------------------------------------------------------------------------------
//func checkPersonAge(age: Int) -> Bool {
//  age >= 18 ? true : false
//}
 
//func cigaretteVendingMachine(personAge: Int, closure: (Int) -> Bool) {
//  if closure(personAge) {
//    print("Thank you for purchasing our products, do not forget that smoking is harmful to your health! Have a nice day.")
//  }else {
//    print("I apologize! But cigarettes are not sold to people under 18!")
//  }
//}
//
//cigaretteVendingMachine(personAge: 19) { $0 >= 18 }

// ---------------------------------------------------------------------------------------
// 13 модуль. Задание на каррирование
//func sumWords (_ w1:String) -> (String) -> (String) -> String {
//    return { w2 in
//        let w3 = w1 + w2
//        return { w3 + $0 }
//}
//}
//
//sumWords("Hi, ")(" now I am knowing ")(" currying")

// ---------------------------------------------------------------------------------------
// 13 модуль. Итоговое задание.
//У нас есть некий пользователь, у которого есть некое приложение, в котором есть всего одна кнопка, и при нажатии на эту кнопку приложение получает данные из сети и выводит их на консоль. Это могут быть любые данные: от текста до фоток и файлов.
//
//В нашем случае мы получим данные в JSON-формате, а затем распарсим их и присвоим в наши переменные, которые затем выведем на консоль.
//
//У вас есть URL . По этому адресу лежат данные в виде JSON-формата. Вам необходимо получить эти данные и вывести на консоль.
//
//В целом, это задание не сложное, но когда вы что-то делаете в первый раз, то это идёт с трудом.
//
//Здесь вы применяете на практике все свои знания, касаемо функций и замыканий.

