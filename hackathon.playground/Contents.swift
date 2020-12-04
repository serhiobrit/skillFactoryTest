import UIKit

/*
Операции банкомата
1 запрос баланса на банковском депозите,
2 снятие наличных с банковского депозита,
3 пополнение банковского депозита наличными,
4 пополнение баланса телефона наличными или с банковского депозита.
 */

// Абстракция данных пользователя
protocol UserData {
  var userName: String { get }    //Имя пользователя
  var userCardId: String { get }   //Номер карты
  var userCardPin: Int { get }       //Пин-код
  var userCash: Float { get set}   //Наличные пользователя
  var userBankDeposit: Float { get set}   //Банковский депозит
  var userPhone: String { get }       //Номер телефона
  var userPhoneBalance: Float { get set}    //Баланс телефона
}

// Тексты ошибок
enum TextErrors: String {
    case badCredentials = "Неверно введены номер карты или ПИН-код. Проверьте данные и повторите ввод."
    case notEnoughCash = "Недостаточно наличных для этой операции."
    case lowBalance = "Недостаточно денег на депозите. Введите сумму в рамках баланса вашего счета."
    case wrongPhone = "Введен неверный номер телефона. Проверьте данные и повторите операцию."
    case choosePayingMethod = "Для совершения операции вам необходимо выбрать источник списания."

}

// Виды операций, выбранных пользователем (подтверждение выбора)
enum DescriptionTypesAvailableOperations: String {
    case showUserBalance = "Вот ваш баланс"
    case getCashFromCard = "Вы выбрали снятие наличных со счета"
    case putCashToCard = "Вы пополнили свой счет"
    case phoneBalanceToppedUp = "Вы пополнили баланс мобильного телефона"
}
 
// Действия, которые пользователь может выбирать в банкомате (имитация кнопок)
enum UserActions {
    case checkBalance//Просмотреть баланс
    case getCash (cashAmount: Float) // Снять наличные
    case putCash (depositAddAmount: Float) // Положить наличные
    case topUpPhoneBalance (phone: String) // Пополнить баланс мобильного телефона
}
 
// Способ оплаты/пополнения наличными или через депозит
enum PaymentMethod {
    case cash (cash: Float) // наличные
    case deposite (deposit: Float) // депозит
}

// Банкомат, с которым мы работаем, имеет общедоступный интерфейс sendUserDataToBank
class ATM {

  private let userCardId: String
  private let userCardPin: Int
  private var someBank: BankApi
  private let action: UserActions
  private let paymentMethod: PaymentMethod?
 
  init(userCardId: String, userCardPin: Int, someBank: BankApi, action: UserActions, paymentMethod: PaymentMethod? = nil) {
    
    self.userCardPin = userCardPin
    self.userCardId = userCardId
    self.someBank = someBank
    self.action = action
    self.paymentMethod = paymentMethod
    
    sendUserDataToBank(userCardId: userCardId, userCardPin: userCardPin, actions: action, payment: paymentMethod )
  }
 
  public final func sendUserDataToBank(userCardId: String, userCardPin: Int, actions: UserActions, payment: PaymentMethod?) {
    let isUserExist = someBank.checkCurrentUser(userCardId: userCardId, userCardPin: userCardPin)
    if isUserExist {
        switch actions {
        case .checkBalance:
            someBank.showUserBalance()
        case let .getCash(cashAmount: payment):
            if someBank.checkMaxUserCash(cash: payment) {
                someBank.getCashFromDeposit(cash: payment)
                someBank.showTopUpAccount(cash: payment)
            } else {
                someBank.showError(error: .notEnoughCash)
            }
        case let .putCash(depositAddAmount: payment):
            if someBank.checkMaxUserCash(cash: payment) {
                someBank.putCashDeposit(topUp: payment)
                someBank.showTopUpAccount(cash: payment)
            } else {
                someBank.showError(error: .notEnoughCash)
            }
        case let .topUpPhoneBalance(phone):
            if someBank.checkUserPhone(phone: phone) {
                if let payment = payment {
                    switch payment {
                    case let .cash(cash: payment):
                        if someBank.checkMaxUserCash(cash: payment) {
                            someBank.showUserToppedUpMobilePhoneCash(cash: payment)
                            someBank.showUserToppedUpMobilePhoneDeposite(deposit: payment)
                        } else {
                            someBank.showError(error: .notEnoughCash)
                        }
                    case let .deposite(deposit: payment):
                        if someBank.checkMaxAccountDeposit(withdraw: payment) {
                            someBank.showUserToppedUpMobilePhoneDeposite(deposit: payment)
                            someBank.showUserBalance()
                        } else {
                            someBank.showError(error: .lowBalance)
                        }
                    }
                }
            }
//        default:
//            someBank.showError(error: .choosePayingMethod)
        }
    }
  }
}

// Протокол по работе с банком предоставляет доступ к данным пользователя зарегистрированного в банке
protocol BankApi {
  func showUserBalance() // показать баланс пользователя
  func showUserToppedUpMobilePhoneCash(cash: Float) // показать результат пополнения баланса телефона наличными
  func showUserToppedUpMobilePhoneDeposite(deposit: Float) // показать результат пополнения баланса телефона с депозита
  func showWithdrawalDeposit(cash: Float) // показать результат списания со счета
  func showTopUpAccount(cash: Float) // показать результат пополнения счета
  func showError(error: TextErrors) // показать ошибку обработки
 
  func checkUserPhone(phone: String) -> Bool // проверить телефон пользователя
  func checkMaxUserCash(cash: Float) -> Bool // проверить количество денег пользователя
  func checkMaxAccountDeposit(withdraw: Float) -> Bool // проверить баланс счета пользователя
  func checkCurrentUser(userCardId: String, userCardPin: Int) -> Bool // проверить данные пользователя
 
  mutating func topUpPhoneBalanceCash(pay: Float) // пополнить баланс телефона наличными
  mutating func topUpPhoneBalanceDeposit(pay: Float) // пополнить баланс телефона с депозита
  mutating func getCashFromDeposit(cash: Float) // показать баланс депозита
  mutating func putCashDeposit(topUp: Float) // положить деньги на депозит
}

struct BankServer: BankApi {
    
    private var user: UserData
    
    init(user: UserData) {
        self.user = user
    }
    
    public func showUserBalance() {
        let message = """
        Добрый день, \(user.userName)!
        \(DescriptionTypesAvailableOperations.showUserBalance.rawValue).
        Ваш баланс составляет \(user.userBankDeposit).
        """
        print(message)
    }
    
    public func showUserToppedUpMobilePhoneCash(cash: Float) {
        let message = """
        Добрый день, \(user.userName)!
        \(DescriptionTypesAvailableOperations.phoneBalanceToppedUp.rawValue).
        Вы пополнили баланс вашего телефона \(user.userPhone) на \(cash) рублей.
        Баланс вашего телефона составляет \(user.userPhoneBalance).
        Остаток наличных денежных средств \(user.userCash).
        """
        print(message)
    }
    
    public func showUserToppedUpMobilePhoneDeposite(deposit: Float) {
        let message = """
        Добрый день, \(user.userName)!
        \(DescriptionTypesAvailableOperations.phoneBalanceToppedUp.rawValue).
        Вы пополнили баланс вашего телефона \(user.userPhone) на \(deposit) рублей.
        Баланс вашего телефона составляет \(user.userPhoneBalance).
        Баланс вашего вашего лицевого счета составляет \(user.userBankDeposit).
        """
        print(message)
    }
    
    func showWithdrawalDeposit(cash: Float) {
        let message = """
        Добрый день, \(user.userName)!
        \(DescriptionTypesAvailableOperations.getCashFromCard.rawValue).
        Ваш баланс составляет \(user.userBankDeposit).
        """
        print(message)
    }
    
    func showTopUpAccount(cash: Float){
        let message = """
        Добрый день, \(user.userName)!
        \(DescriptionTypesAvailableOperations.putCashToCard.rawValue).
        Ваш баланс составляет \(user.userBankDeposit).
        Остаток наличных денежных средств \(user.userCash).
        """
        print(message)
    }
    
    func showError(error: TextErrors) {
        let error = """
        Уважаемый \(user.userName), выполнение операции не может быть выполнено по следующей причине:
        \(error.rawValue)
        """
        print(error)
    }
    
    public mutating func topUpPhoneBalanceCash(pay: Float) { // пополнить баланс телефона наличными
        user.userPhoneBalance += pay
        user.userCash -= pay
    }
    public mutating func topUpPhoneBalanceDeposit(pay: Float) { // пополнить баланс телефона с депозита
        user.userPhoneBalance += pay
        user.userBankDeposit -= pay
    }
    public mutating func getCashFromDeposit(cash: Float) { // показать баланс депозита
        user.userCash += cash
        user.userBankDeposit -= cash
    }
    public mutating func putCashDeposit(topUp: Float) { // положить деньги на депозит
        user.userBankDeposit += topUp
        user.userCash -= topUp
    }
    
    public func checkUserPhone(phone: String) -> Bool {
        if phone == user.userPhone {
        return true
        } else {
            return false
        }
    }
    
    public func checkMaxUserCash(cash: Float) -> Bool {
        if cash <= user.userCash {
            return true
        } else {
            return false
        }
    }
    
    public func checkMaxAccountDeposit(withdraw: Float) -> Bool {
        if withdraw <= user.userBankDeposit {
            return true
        }
                return false
        }
 
    private func checkCardId(cardId: String, user: UserData) -> Bool {
        if cardId == user.userCardId {
            return true
        }
                return false
            }
        
    private func checkCardPin(cardPin: Int, user: UserData) -> Bool {
        if cardPin == user.userCardPin {
            return true
        }
                return false
            }
    
    public func checkCurrentUser(userCardId: String, userCardPin: Int) -> Bool {
        let pinCorrect = checkCardId(cardId: userCardId, user: user)
        let idCorrect = checkCardPin(cardPin: userCardPin, user: user)
        
        if pinCorrect && idCorrect {
            return true
        } else {
            return false
        }

    }
}
    
struct User: UserData {
    var userName: String
    var userCardId: String
    var userCardPin: Int
    var userCash: Float
    var userBankDeposit: Float
    var userPhone: String
    var userPhoneBalance: Float
}

// данные пользователя в банке
let currentUser: UserData = User(userName: "Vasiliy Khan", userCardId: "7594 8893 8854 2992", userCardPin: 666, userCash: 235.90, userBankDeposit: 7000.50, userPhone: "+7-902-998-43-42", userPhoneBalance: 5467.70)

// текущий сервер банка
let bankClient = BankServer (user: currentUser)

// введенные данные пользователя
let atm001 = ATM(userCardId: "7594 8893 8854 2992", userCardPin: 566, someBank: bankClient, action: .putCash(depositAddAmount: 100), paymentMethod: .cash(cash: 100))
