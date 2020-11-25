import UIKit

protocol FeedDeliveryDelegate: AnyObject {
    func feedDeliveryByAddres (address: String)
    func feedDeliveryTime (chosenTime: String)
    func ordered (feed: DogFeed?, toys: DogToys?)
}

enum DogFeed: String {
    case bones = "tasty chewing bones"
    case dogFood = "dog food -- eat and poop"
}

enum DogToys: String {
    case rubberToys = "rubber duck -- squize and play"
    case plasticToys = "plastic toy -- lick it all"
    case eatingToys = "eating toy -- you can play with food"
}

class FeedShopHappyDog {
    weak var addressLink: FeedDeliveryDelegate?
    weak var timeLink: FeedDeliveryDelegate?
    weak var orderListLink: FeedDeliveryDelegate?

    func order (yourAddress: String, deliveryTime: String, foodList: DogFeed?, toysList: DogToys?) {
        addressLink?.feedDeliveryByAddres(address: yourAddress)
        timeLink?.feedDeliveryTime(chosenTime: deliveryTime)
        orderListLink?.ordered(feed: foodList, toys: toysList)
    }
}

class WebsiteForOrderingFeedShopHappyDog: FeedDeliveryDelegate {
    func feedDeliveryByAddres(address: String) {
        print ("Your delivery address is \(address)")
    }
    
    func feedDeliveryTime(chosenTime: String) {
        print ("Your delivery date is \(chosenTime)")
    }

    func ordered(feed: DogFeed?, toys: DogToys?) {
            print ("Your shopping list: \n")
        if feed != nil {
            switch feed {
            case .bones :
                print(DogFeed.bones.rawValue)
            case .dogFood :
                print(DogFeed.dogFood.rawValue)
            case .none :
                return
            }
        }
        if toys != nil {
            switch toys {
            case .eatingToys :
                print(DogToys.eatingToys.rawValue)
            case .plasticToys :
                print(DogToys.plasticToys.rawValue)
            case .rubberToys :
                print(DogToys.rubberToys.rawValue)
            case .none :
                return
            }
        }
        else {
            print ("Your shopping bag is empty")
        }
    }
}

let implemented = WebsiteForOrderingFeedShopHappyDog()
let iOrdered = FeedShopHappyDog()
iOrdered.addressLink = implemented
iOrdered.timeLink = implemented
iOrdered.orderListLink = implemented
iOrdered.order(yourAddress: "Moscow center", deliveryTime: "today", foodList: DogFeed.bones, toysList: .eatingToys)
