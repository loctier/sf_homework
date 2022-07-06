import Foundation

// Абстракция данных пользователя
protocol UserData {
    var userName: String { get }    //Имя пользователя
    var userCardId: String { get }   //Номер карты
    var userCardPin: Int { get }       //Пин-код
    var userPhone: String { get }       //Номер телефона
    var userCash: Float { get set }   //Наличные пользователя
    var userBankDeposit: Float { get set }   //Банковский депозит
    var userPhoneBalance: Float { get set }    //Баланс телефона
    var userCardBalance: Float { get set }    //Баланс карты
}

// Действия, которые пользователь может выбирать в банкомате (имитация кнопок)
enum UserActions {
    //    запрос баланса по карте и на банковском депозите;
    case showUserCardBalance
    case showUserDepositBalance
    
    //    снятие наличных с карты или банковского депозита;
    case getCash (from: PaymentMethod)
    
    //    пополнение карты и банковского депозита наличными;
    case putCash (to: PaymentMethod)
    
    //    пополнение баланса телефона наличными или с карты.
    case topUpPhoneBalance (number: String, with: PaymentMethod)
    
}

// Виды операций, выбранных пользователем (подтверждение выбора)
enum DescriptionTypesAvailableOperations: String {
    
    //    запрос баланса
    //      по карте
    case showUserCardBalance = "Ваш баланс по карте:"
    //      и на банковском депозите
    case showUserDepositBalance = "Ваш баланс на банковском депозите:"
    
    case showUserPhoneBalance = "У вас на телефоне:"
    case showUserCash = "Ваши располагаемые наличные:"
    
    //    снятие наличных
    //      с карты
    case getCashFromCard = "Снятие наличных с карты:"
    //      или банковского депозита
    case getCashFromDeposit = "Снятие наличных с банковского депозита:"
    
    //    пополнение наличными
    //      карты
    case putCashCard = "Пополнение карты наличными:"
    //      и банковского депозита
    case putCashDeposit = "Пополнение банковского депозита наличными:"
    
    //    пополнение баланса телефона
    //      наличными
    case topUpPhoneBalanceCash = "Пополнение баланса телефона наличными:"
    //      или с карты
    case topUpPhoneBalanceCard = "Пополнение баланса телефона с карты:"
}

// Способ оплаты/пополнения наличными, картой или через депозит
enum PaymentMethod {
    case cash (sum:Float)
    case card (sum:Float)
    case deposit (sum:Float)
}

// Тексты ошибок
enum TextErrors: String {
    case errorCheckCurrentUser = "Неверный номер карты или ПИН-код"
    case errorUserPhone = "Неверный номер телефона"
    case insufficientCash = "Внесено недостаточно наличных"
    case insufficientBankDeposit = "Недостаточный остаток на банковском депозите"
    case insufficientCardBalance = "Недостаточно средств на карте"
    case errorFrom = "Неверный источник транзакции"
    case errorTo = "Неверный адресат транзакции"
    case negativeAmount = "Отрицательная сумма транзакции"
}

// Протокол по работе с банком предоставляет доступ к данным пользователя зарегистрированного в банке
protocol BankApi {
    func showUserCardBalance()
    func showUserDepositBalance()
    func showUserPhoneBalance()
    func showUserCash()
    func showUserToppedUpMobilePhoneCash(cash: Float)
    func showUserToppedUpMobilePhoneCard(card: Float)
    func showWithdrawalCard(cash: Float)
    func showWithdrawalDeposit(cash: Float)
    func showTopUpCard(cash: Float)
    func showTopUpDeposit(cash: Float)
    func showError(error: TextErrors)
    
    func checkUserPhone(phone: String) -> Bool
    func checkMaxUserCash(cash: Float) -> Bool
    func checkMaxUserCard(withdraw: Float) -> Bool
    func checkCurrentUser(userCardId: String, userCardPin: Int) -> Bool
    
    mutating func topUpPhoneBalanceCash(pay: Float)
    mutating func topUpPhoneBalanceCard(pay: Float)
    mutating func getCashFromDeposit(cash: Float)
    mutating func getCashFromCard(cash: Float)
    mutating func putCashDeposit(topUp: Float)
    mutating func putCashCard(topUp: Float)
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
        
        sendUserDataToBank(userCardId: userCardId, userCardPin: userCardPin, actions: action, payment: paymentMethod)
        
    }
    
    public final func sendUserDataToBank(userCardId: String, userCardPin: Int, actions: UserActions, payment: PaymentMethod?) {
        
        // Проверяем номер карты и ПИН-код
        if !someBank.checkCurrentUser(userCardId: userCardId, userCardPin: userCardPin) {
            someBank.showError(error: .errorCheckCurrentUser)
            return
        }
        
        // Перебираем все возможные действия пользователя
        
        switch actions {
            
        case .showUserCardBalance:
            someBank.showUserCardBalance()
        case .showUserDepositBalance:
            someBank.showUserDepositBalance()
        case .getCash(let from):
            switch from {
            case .card(let sum):
                guard sum >= 0 else {
                    someBank.showError(error: .negativeAmount)
                    return
                }
                someBank.showUserCardBalance()
                if someBank.checkMaxUserCard(withdraw: sum) {
                    someBank.getCashFromCard(cash: sum)
                    someBank.showWithdrawalCard(cash: sum)
                } else {
                    someBank.showError(error: .insufficientCardBalance)
                    return
                }
                
            case .deposit(let sum):
                guard sum >= 0 else {
                    someBank.showError(error: .negativeAmount)
                    return
                }
                someBank.showUserDepositBalance()
                someBank.getCashFromDeposit(cash: sum)
                someBank.showWithdrawalDeposit(cash: sum)
                
            case .cash:
                someBank.showError(error: .errorFrom)
            }
            
        case .putCash(let to):
            switch to {
            case .card(let sum):
                guard sum >= 0 else {
                    someBank.showError(error: .negativeAmount)
                    return
                }
                someBank.showUserCardBalance()
                someBank.showUserCash()
                if someBank.checkMaxUserCash(cash: sum) {
                    someBank.putCashCard(topUp: sum)
                    someBank.showTopUpCard(cash: sum)
                } else {
                    someBank.showError(error: .insufficientCash)
                    return
                }
                
            case .deposit(let sum):
                guard sum >= 0 else {
                    someBank.showError(error: .negativeAmount)
                    return
                }
                someBank.showUserDepositBalance()
                someBank.showUserCash()
                someBank.putCashDeposit(topUp: sum)
                someBank.showTopUpDeposit(cash: sum)
                
            case .cash:
                someBank.showError(error: .errorTo)
            }
            
            
        case .topUpPhoneBalance(let number, let with):
            // Проверим номер телефона
            guard someBank.checkUserPhone(phone: number) else {
                someBank.showError(error: .errorUserPhone)
                return
            }
            
            switch with {
            case .card(let sum):
                guard sum >= 0 else {
                    someBank.showError(error: .negativeAmount)
                    return
                }
                someBank.showUserCardBalance()
                someBank.showUserPhoneBalance()
                if someBank.checkMaxUserCard(withdraw: sum) {
                    someBank.topUpPhoneBalanceCard(pay: sum)
                    someBank.showUserToppedUpMobilePhoneCard(card: sum)
                } else {
                    someBank.showError(error: .insufficientCardBalance)
                    return
                }
                
            case .cash(let sum):
                guard sum >= 0 else {
                    someBank.showError(error: .negativeAmount)
                    return
                }
                someBank.showUserCash()
                someBank.showUserPhoneBalance()
                if someBank.checkMaxUserCash(cash: sum) {
                    someBank.topUpPhoneBalanceCash(pay: sum)
                    someBank.showUserToppedUpMobilePhoneCash(cash: sum)
                } else {
                    someBank.showError(error: .insufficientCash)
                    return
                }
                
            case .deposit:
                someBank.showError(error: .errorFrom)
            }
        }
    }
}

struct User : UserData {
    var userName: String
    
    var userCardId: String
    
    var userCardPin: Int
    
    var userPhone: String
    
    var userCash: Float
    
    var userBankDeposit: Float
    
    var userPhoneBalance: Float
    
    var userCardBalance: Float
    
}


struct Bank: BankApi {
    
    var user: User
    
    //    let cash: Float = user.userCash
    //    let phone: String = user.userPhone
    
    func showUserName() {
        print("Здравствуйте, \(user.userName)!\n")
    }
    
    func showUserCardBalance() {
        print("\(DescriptionTypesAvailableOperations.showUserCardBalance.rawValue) \(user.userCardBalance)")
    }
    
    func showUserDepositBalance() {
        print("\(DescriptionTypesAvailableOperations.showUserDepositBalance.rawValue) \(user.userBankDeposit)")
    }
    
    func showUserPhoneBalance(){
        print("\(DescriptionTypesAvailableOperations.showUserPhoneBalance.rawValue) \(user.userPhoneBalance)")
    }
    
    func showUserCash(){
        print("\(DescriptionTypesAvailableOperations.showUserCash.rawValue) \(user.userCash)")
    }
    
    
    func showUserToppedUpMobilePhoneCash(cash: Float) {
        print ("\(DescriptionTypesAvailableOperations.topUpPhoneBalanceCash.rawValue.localizedUppercase) \(cash)")
        print("\(DescriptionTypesAvailableOperations.showUserCash.rawValue) \(user.userCash)")
        print("\(DescriptionTypesAvailableOperations.showUserPhoneBalance.rawValue.localizedUppercase) \(user.userPhoneBalance)")
    }
    
    func showUserToppedUpMobilePhoneCard(card: Float) {
        print ("\(DescriptionTypesAvailableOperations.topUpPhoneBalanceCard.rawValue.localizedUppercase) \(card)")
        print("\(DescriptionTypesAvailableOperations.showUserCardBalance.rawValue) \(user.userCardBalance)")
        print("\(DescriptionTypesAvailableOperations.showUserPhoneBalance.rawValue.localizedUppercase) \(user.userPhoneBalance)")
    }
    
    func showWithdrawalCard(cash: Float) {
        print ("\(DescriptionTypesAvailableOperations.getCashFromCard.rawValue) \(cash)")
        print("\(DescriptionTypesAvailableOperations.showUserCardBalance.rawValue) \(user.userCardBalance)")
        
    }
    
    func showWithdrawalDeposit(cash: Float) {
        print ("\(DescriptionTypesAvailableOperations.getCashFromDeposit.rawValue) \(cash)")
        print("\(DescriptionTypesAvailableOperations.showUserDepositBalance.rawValue) \(user.userBankDeposit)")
    }
    
    func showTopUpCard(cash: Float) {
        print ("\(DescriptionTypesAvailableOperations.putCashCard.rawValue.localizedUppercase) \(cash)")
        print("\(DescriptionTypesAvailableOperations.showUserCardBalance.rawValue.localizedUppercase) \(user.userCardBalance)")
        print("\(DescriptionTypesAvailableOperations.showUserCash.rawValue) \(user.userCash)")
    }
    
    func showTopUpDeposit(cash: Float) {
        print ("\(DescriptionTypesAvailableOperations.putCashDeposit.rawValue.localizedUppercase) \(cash)")
        print("\(DescriptionTypesAvailableOperations.showUserDepositBalance.rawValue.localizedUppercase) \(user.userBankDeposit)")
        print("\(DescriptionTypesAvailableOperations.showUserCash.rawValue) \(user.userCash)")
    }
    
    func showError(error: TextErrors) {
        print("ОШИБКА: \(error.rawValue.localizedUppercase)")
    }
    
    func checkUserPhone(phone: String) -> Bool {
        return phone == user.userPhone ? true : false
    }
    
    func checkMaxUserCash(cash: Float) -> Bool {
        return cash <= user.userCash ? true : false
    }
    
    func checkMaxUserCard(withdraw: Float) -> Bool {
        return withdraw <= user.userCardBalance ? true : false
    }
    
    func checkCurrentUser(userCardId: String, userCardPin: Int) -> Bool {
        if userCardId == user.userCardId && userCardPin == user.userCardPin {
            showUserName()
            return true
        } else {
            return false}
    }
    
    mutating func topUpPhoneBalanceCash(pay: Float) {
        user.userCash -= pay
        user.userPhoneBalance += pay
    }
    
    mutating func topUpPhoneBalanceCard(pay: Float) {
        user.userCardBalance -= pay
        user.userPhoneBalance += pay
    }
    
    mutating func getCashFromDeposit(cash: Float) {
        user.userCash += cash
        user.userBankDeposit -= cash
    }
    
    mutating func getCashFromCard(cash: Float) {
        user.userCash += cash
        user.userCardBalance -= cash
    }
    
    mutating func putCashDeposit(topUp: Float) {
        user.userCash -= topUp
        user.userBankDeposit += topUp
    }
    
    mutating func putCashCard(topUp: Float) {
        user.userCardBalance += topUp
        user.userCash -= topUp
    }
    
}

let testUser = User(userName: "Michael Scott", userCardId: "1234 5678 9012 3456", userCardPin: 1234, userPhone: "+1 234 567-89-01", userCash: 123.45, userBankDeposit: 567.89, userPhoneBalance: 12.34, userCardBalance: 56.78)

let testBank = Bank(user: testUser)

let testATM = ATM(
    userCardId: "1234 5678 9012 3456",
    userCardPin: 1234,
    someBank: testBank,
    
    //    запрос баланса по карте и на банковском депозите:
    //    action: .showUserCardBalance
    //    action: .showUserDepositBalance
    
    //    снятие наличных с карты или банковского депозита:
    //    action: .getCash (from: .card(sum: 10))
    //    action: .getCash (from: .deposit(sum: 10))
    
    //    пополнение карты и банковского депозита наличными:
    //    action: .putCash(to: .card(sum: 10))
    //    action: .putCash(to: .deposit(sum: 10))
    
    //    пополнение баланса телефона наличными или с карты:
    //        action: .topUpPhoneBalance(number: "+1 234 567-89-01", with: .cash(sum: 10))
    action: .topUpPhoneBalance(number: "+1 234 567-89-01", with: .card(sum: 10))
)

