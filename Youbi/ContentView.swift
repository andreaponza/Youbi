//
//  ContentView.swift
//  Youbi
//
//  Created by Andrea De Martino on 17/10/24.
//

import SwiftUI
import Foundation
import AVFoundation

func readDate(_ testo: String) {
    let synthesizer = AVSpeechSynthesizer()
    let utterance = AVSpeechUtterance(string: testo)
    
    // Imposta la lingua giapponese
    utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
    
    // Configura la velocità e il tono della voce
    utterance.rate = AVSpeechUtteranceDefaultSpeechRate
    utterance.pitchMultiplier = 1.0
    
    // Avvia la sintesi vocale
    synthesizer.speak(utterance)
}

// japanis number map (kanji, hiragana, romaji)
let kanjiNumbers = ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "二十一", "二十二", "二十三", "二十四", "二十五", "二十六", "二十七", "二十八", "二十九", "三十", "三十一"]

let hiraganaDays = ["いちにち", "ふつか", "みっか", "よっか", "いつか", "むいか", "なのか", "ようか", "ここのか", "とおか", "じゅういちにち", "じゅうににち", "じゅうさんにち", "じゅうよっか", "じゅうごにち", "じゅうろくにち", "じゅうしちにち", "じゅうはちにち", "じゅうくにち", "はつか", "にじゅういちにち", "にじゅうににち", "にじゅうさんにち", "にじゅうよっか", "にじゅうごにち", "にじゅうろくにち", "にじゅうしちにち", "にじゅうはちにち", "にじゅうくにち", "さんじゅうにち", "さんじゅういちにち"]

let romajiDays = ["ichinichi", "futsuka", "mikka", "yokka", "itsuka", "muika", "nanoka", "youka", "kokonoka", "tooka", "juuichinichi", "juuninichi", "juusannichi", "juuyokka", "juugonichi", "juurokunichi", "juushichinichi", "juuhachinichi", "juukunichi", "hatsuka", "nijuuichinichi", "nijuuninichi", "nijuusannichi", "nijuuyokka", "nijuugonichi", "nijuurokunichi", "nijuushichinichi", "nijuuhachinichi", "nijuukunichi", "sanjuunichi", "sanjuuichinichi"]

let kanjiMonths = ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"]

let hiraganaMonths = ["いちがつ", "にがつ", "さんがつ", "しがつ", "ごがつ", "ろくがつ", "しちがつ", "はちがつ", "くがつ", "じゅうがつ", "じゅういちがつ", "じゅうにがつ"]

let romajiMonths = ["ichigatsu", "nigatsu", "sangatsu", "shigatsu", "gogatsu", "rokugatsu", "shichigatsu", "hachigatsu", "kugatsu", "juugatsu", "juuichigatsu", "juunigatsu"]

let kanjiDaysOfWeek = ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"]
let hiraganaDaysOfWeek = ["にちようび", "げつようび", "かようび", "すいようび", "もくようび", "きんようび", "どようび"]
let romajiDaysOfWeek = ["nichiyoubi", "getsuyoubi", "kayoubi", "suiyoubi", "mokuyoubi", "kinyoubi", "doyoubi"]

// Day metod
func japaneseDay(for day: Int) -> (kanji: String, hiragana: String, romaji: String) {
    return (kanjiNumbers[day - 1], hiraganaDays[day - 1], romajiDays[day - 1])
}

// Month metod
func japaneseMonth(for month: Int) -> (kanji: String, hiragana: String, romaji: String) {
    return (kanjiMonths[month - 1], hiraganaMonths[month - 1], romajiMonths[month - 1])
}

// Japanise format date metod
func japaneseDayOfWeek(for weekday: Int) -> (kanji: String, hiragana: String, romaji: String) {
    return (kanjiDaysOfWeek[weekday - 1], hiraganaDaysOfWeek[weekday - 1], romajiDaysOfWeek[weekday - 1])
}


struct ContentView: View {
    var body: some View {
        VStack {
            
            // Create a date istance
            let currentDate = Date()

            // Create a DateFormatter istance
            let dateFormatter = DateFormatter()

            // Set date format
            var _: () = dateFormatter.dateFormat = "EEEE,  MMMM dd "

            // Convert date in string
            let dateString = dateFormatter.string(from: currentDate)
            //Show current date
            Text("\(dateString)")
                .font(.headline)
                .font(.system(size: 30))
                .foregroundColor(.black)
                .padding(.bottom, 5)

            //Show date in different version
            let weekday = japaneseDayOfWeek(for: Calendar.current.component(.weekday, from: Date()))
            let day = japaneseDay(for: Calendar.current.component(.day, from: Date()))
            let month = japaneseMonth(for: Calendar.current.component(.month, from: Date()))
            Text("\(weekday.kanji) \(month.kanji) \(day.kanji)")
                .font(.system(size: 100))
            Text("\(weekday.hiragana) \(month.hiragana) \(day.hiragana)")
                .font(.system(size: 30))
            Text("\(weekday.romaji) \(month.romaji) \(day.romaji)".uppercased())
                .font(.system(size: 30))
            Button("🗣️"){
                readDate("\(weekday.hiragana) \(month.hiragana) \(day.hiragana)")
            }
                
        }
        .containerBackground(
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 0.8, green: 0.7, blue: 0.5), Color(red: 0.9, green: 0.85, blue: 0.75)]), // Background
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ), for: .window
            )
        .padding()
        .textSelection(.enabled)
    }
}

#Preview {
    ContentView()
}
