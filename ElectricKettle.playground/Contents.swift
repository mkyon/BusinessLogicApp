//-仕様
//　- 水を入れる量は0.3L,0.5L,0.8L,1.0Lの目盛りがある
//　- それぞれ、お湯が沸くまでにカウンターで1回、3回、4回、5回かかるとする
//　- お湯が沸くと自動でボタンがオフになる
//　-
//- 例外パターン
//　- コンセントに刺さってない場合は、何も反応なし
//　- 空焚き防止のため、水がない時は自動でスイッチがオフになる
//　-


import Foundation // Timerクラスを使用するために必要なモジュール
import PlaygroundSupport // Playground上でTimerクラスを機能させるために必要なモジュール
import UIKit

// デフォルトだとTimerクラスを継続的に処理させることが出来ないため、フラグを変更
PlaygroundPage.current.needsIndefiniteExecution = true


class Alarm {
    var timer: Timer?
    var count: Int = 0
    var limit: Int = 5
    
    func start() {
        // 任意の箇所でTimerクラスを使用して1秒毎にcountup()メソッドを実行させるタイマーをセット
        timer = Timer.scheduledTimer(
            timeInterval: 1, // タイマーの実行間隔を指定(単位はn秒)
            target: self, // ここは「self」でOK
            selector: #selector(countup), // timeInterval毎に実行するメソッドを指定
            userInfo: nil, // ここは「nil」でOK
            repeats: true // 繰り返し処理を実行したいので「true」を指定
        )
    }

    // Timerクラスに設定するメソッドは「@objc」キワードを忘れずに付与する
    @objc func countup() {
        // countの値をインクリメントする
        count += 1
        print("カウントは\(count)です")
        // countの値がlimitの値以上になったif文を実行
        if limit <= count {
            print("スイッチOFF(カウントをストップします)")
            // タイマーを止める
            timer?.invalidate()
        }
    }
}

let alarm = Alarm()
//alarm.start()



class ElectricKettle {
    
    var switchOnOff: Bool = false   // ONがtrue,OFFがfalse
    
    
    func boilWater(liter: Int, concent: Bool) -> Bool{
        
        // コンセントさしてないとき
        if !concent {
            print("コンセントさしてないよ")
            return false
        }
        
        // 水が入ってない時、空焚き防止でスイッチOFF
        if liter == 0 {
            print("スイッチOFF")
            return false
        }

        // 水の量に合わせてタイマーセット
        let scaleWater300 = 300
        let scaleWater500 = 500
        let scaleWater800 = 800
        let scaleWater1000 = 1000
        
        if liter > 800 && liter <= 1000 {
            alarm.limit = 5
        }else if liter > 500 && liter <= 800 {
            alarm.limit = 4
        }else if liter > 300 && liter <= 500 {
            alarm.limit = 3
        }else{
            alarm.limit = 1
        }
        
        alarm.start()
        
        // 🌟ここ🌟　アラームが止まった後に出力したいが、処理が先に進んでいる
        print("スイッチOFF")
        print("お湯が沸きました")
                    
        return true
    }
    
}

let electricKettle = ElectricKettle()
let isSuccess = electricKettle.boilWater(liter: 900, concent: true)

print(isSuccess)
