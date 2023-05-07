// 機能要件
//・3コイン入れると起動する
//・マシーン内のコイン在庫を加算する
//・左・真ん中・右のスロット絵柄が全て7の場合、当たりとなる
//・当たった場合、300枚払い出しされる
//・当たった場合、マシーン内のコイン在庫を減らす


// 機能要件(例外パターン)
//・２コイン以下は起動しない
//・当たりでマシーン内のコインが不足した場合、300枚補充を行う

class SlotMachine {
    //　スタート時のコインの必要枚数
    var inputedCoin = 0//枚
    let neededStartingCoin = 3//枚
    
    //　コインのストック
    var coinStock = 0//枚
    
    // 左・真ん中・右の絵柄を定義
    var leftView = 0// 1~7番
    var middleView = 0// 1~7番
    var rightView = 0// 1~7番
    
    //　inputedCoinが3枚の場合にスタートできる・それ以外はスタートしない
    //　スタートした場合はコインの在庫を３増やす
    //　スタートできなかった場合はコインの在庫は変化しない
    func startSlotMachine() {
        //3枚以外はスタートしない内容を定義する（if文）
        if inputedCoin == 3 {
            print("スタート！")
            //コインの在庫を増やす
            func increaseStock(coinStock :Int) -> Int {
                return coinStock + 3
            }
            print("コインの在庫数は\(coinStock)枚です")
        }else {
            print("コインが足りません")
            func increaseStock(coinStock :Int) -> Int {
                return coinStock + 0
            }
            print("コインの在庫数は\(coinStock)枚です")
        }
        
    }
    
    //当たりとハズレの場合の処理を定義
    //　当たり→当たりと表示される＋マシーンのコイン在庫を300減らす
    //　ハズレ→ハズレと表示される＋マシーンのコイン在庫は変化しない
    func bonusGame() {
        if leftView == rightView && rightView == middleView {
            print("BigBonus！300枚払出しされます")
            func reduceStock(coinStock :Int) -> Int {
                return coinStock - 300
            }
            print("コインの在庫数は\(coinStock)枚です")
        }else {
            print("ハズレです")
            func reduceStock(coinStock :Int) -> Int {
                return coinStock - 0
            }
            print("コインの在庫数は\(coinStock)枚です")
        }
    }


    //初期化子
    init(inputedCoin: Int, leftView: Int, middleView: Int, rightView: Int, coinStock: Int) {
        self.inputedCoin = inputedCoin
        self.leftView = leftView
        self.middleView = middleView
        self.rightView = rightView
        self.coinStock = coinStock
    }
}

let slotmachine = SlotMachine(inputedCoin: 3, leftView: 7, middleView: 7, rightView: 7, coinStock: 300)

slotmachine.startSlotMachine()
slotmachine.bonusGame()

