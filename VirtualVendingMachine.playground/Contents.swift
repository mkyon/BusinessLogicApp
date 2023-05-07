//- STEP1 : 仕様を考えてリスト化
//  - お金(日本円)が入力されたら金額を表示
//  - 入力された金額で購入できる商品のボタンを光らせる
//  - 押されたボタンの商品を1つ外に出す
//  - 入力されたお金 - 購入金額をお釣りとして表示する
//- STEP2 : Swiftで実装
//- STEP3 : 例外ケースを考えてリスト化する
//  - 商品ボタンが押される前にお釣りボタンを押される
//  - 在庫切れ商品が押される
//  - 外貨とかコインが投入された時
//  - 釣り銭が足りない場合購入できない
//- STEP4 : 例外ケースを考慮したコードに書き換える


import UIKit

class VirtualVendingMachine {
    enum DrinkType {
        case coffee
        case water
        case monster
    }

    var inputedYen: Int = 0

    var coffeePrice: Int = 120
    var waterPrice: Int = 100
    var monsterPrice: Int = 210

    var coffeeStock: Int = 10
    var waterStock: Int = 15
    var monsterStock: Int = 5
    
    // お釣り枚数
    var changeStock50: Int = 0
    var changeStock10: Int = 10
    
//    func buyDrink(type: DrinkType, inputedYen: Int) -> Bool {
    func buyDrink(type: DrinkType, inputedYen100: Int, inputedYen50: Int, inputedYen10: Int, otherCoin:Int, refund: Bool) -> Bool {

        if otherCoin > 0 {
            print("100円か50円か10円でないコインが投入されました。返金ボタンを押して確認してください")
            return false
        }
        self.inputedYen = calInputYen(inputedYen100: inputedYen100, inputedYen50:inputedYen50 , inputedYen10: inputedYen10)
        var isBuyable = false
        // 入れたお金を表示
        print("入金：\(self.inputedYen)円")
        
        // 返金ボタンが押されている場合、返金して終了
        if refund{
            print("返金：\(self.inputedYen)円")
            return true
        }
        // 購入可能な商品のボタンを光らせる
        if self.inputedYen >= coffeePrice{
            print("coffee買えます")
        }
        if self.inputedYen >= waterPrice{
            print("water買えます")
        }
        if self.inputedYen >= monsterPrice{
            print("monster買えます")
        }
                    
        var buyPrice = 0
        switch type {
        case .coffee:
            if coffeeStock == 0 {
                print("在庫切れです。他を選ぶか返金ボタンを押してください")
                return false
            }
            isBuyable = coffeePrice <= inputedYen && 0 < coffeeStock
            buyPrice = coffeePrice
        case .water:
            if waterStock == 0 {
                print("在庫切れです。他を選ぶか返金ボタンを押してください")
                return false
            }
            isBuyable = waterPrice <= inputedYen && 0 < waterStock
            buyPrice = waterPrice
        case .monster:
            if monsterStock == 0 {
                print("在庫切れです。他を選ぶか返金ボタンを押してください")
                return false
            }
            isBuyable = monsterPrice <= inputedYen && 0 < monsterStock
            buyPrice = monsterPrice
        }
        
        // 押されたボタンの商品を1つ外に出す
        if isBuyable{
            print("\(type)が購入できました")
            var change = self.inputedYen - buyPrice
            // お釣りが足りるか確認してする
            changeStock50 += inputedYen50
            changeStock10 += inputedYen10
            if calChange(change:change) {
                print("お釣りは\(change)円です ")
            }else{
                print("お釣りが足りないため、購入できません")
                return false
            }
        }else{
            print("お金が足りません。確認してください。")
        }

        // 在庫を1つ減らす
        reduceStock(type: type)

        return isBuyable
    }

    func reduceStock(type: DrinkType) {
        switch type {
        case .coffee:
            coffeeStock -= 1
        case .water:
            waterStock -= 1
        case .monster:
            monsterStock -= 1
        }
    }
    
    // 入金合計額を計算する
    func calInputYen(inputedYen100:Int, inputedYen50:Int, inputedYen10: Int) -> Int {
        var totalInputYen = inputedYen100 * 100 + inputedYen50 * 50 + inputedYen10 * 10
        return totalInputYen
    }
    
    // お釣りが足りるか確認する
    func calChange(change: Int) -> Bool{
        // 必要枚数
        var needYen50 = 0
        var needYen10 = 0
        // 50円玉
        needYen50 = change / 50
        if needYen50 > changeStock50{
            needYen10 = (needYen50 - changeStock50) * 5
            needYen50 = changeStock50
        }
        // 10円玉
        needYen10 += (change % 50) / 10
        if needYen10 > changeStock10 {
            // お釣りが足らない
            return false
        }
        
        // お釣りのストックを減らす
        changeStock50 -= needYen50
        changeStock10 -= needYen10
        
        return true
    }
}

let virtualVendingMachine = VirtualVendingMachine()
//let isSuccessToBuy = virtualVendingMachine.buyDrink(type: .coffee, inputedYen: 300)
let isSuccessToBuy = virtualVendingMachine.buyDrink(type: .coffee, inputedYen100: 2, inputedYen50: 0, inputedYen10: 0, otherCoin: 0, refund: false)


print(isSuccessToBuy)
