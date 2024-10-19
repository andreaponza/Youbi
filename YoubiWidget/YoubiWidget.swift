//
//  YoubiWidget.swift
//  YoubiWidget
//
//  Created by Andrea De Martino on 17/10/24.
//

import WidgetKit
import SwiftUI
import Foundation

// Map japanise number (kanji, hiragana, romaji)
let kanjiNumbers = ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "二十一", "二十二", "二十三", "二十四", "二十五", "二十六", "二十七", "二十八", "二十九", "三十", "三十一"]

let hiraganaDays = ["いちにち", "ふつか", "みっか", "よっか", "いつか", "むいか", "なのか", "ようか", "ここのか", "とおか", "じゅういちにち", "じゅうににち", "じゅうさんにち", "じゅうよっか", "じゅうごにち", "じゅうろくにち", "じゅうしちにち", "じゅうはちにち", "じゅうくにち", "はつか", "にじゅういちにち", "にじゅうににち", "にじゅうさんにち", "にじゅうよっか", "にじゅうごにち", "にじゅうろくにち", "にじゅうしちにち", "にじゅうはちにち", "にじゅうくにち", "さんじゅうにち", "さんじゅういちにち"]

let romajiDays = ["ichinichi", "futsuka", "mikka", "yokka", "itsuka", "muika", "nanoka", "youka", "kokonoka", "tooka", "juuichinichi", "juuninichi", "juusannichi", "juuyokka", "juugonichi", "juurokunichi", "juushichinichi", "juuhachinichi", "juukunichi", "hatsuka", "nijuuichinichi", "nijuuninichi", "nijuusannichi", "nijuuyokka", "nijuugonichi", "nijuurokunichi", "nijuushichinichi", "nijuuhachinichi", "nijuukunichi", "sanjuunichi", "sanjuuichinichi"]

let kanjiMonths = ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"]

let hiraganaMonths = ["いちがつ", "にがつ", "さんがつ", "しがつ", "ごがつ", "ろくがつ", "しちがつ", "はちがつ", "くがつ", "じゅうがつ", "じゅういちがつ", "じゅうにがつ"]

let romajiMonths = ["ichigatsu", "nigatsu", "sangatsu", "shigatsu", "gogatsu", "rokugatsu", "shichigatsu", "hachigatsu", "kugatsu", "juugatsu", "juuichigatsu", "juunigatsu"]

let kanjiDaysOfWeek = ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"]
let hiraganaDaysOfWeek = ["にちようび", "げつようび", "かようび", "すいようび", "もくようび", "きんようび", "どようび"]
let romajiDaysOfWeek = ["nichiyoubi", "getsuyoubi", "kayoubi", "suiyoubi", "mokuyoubi", "kinyoubi", "doyoubi"]

// Day format metod
func japaneseDay(for day: Int) -> (kanji: String, hiragana: String, romaji: String) {
    return (kanjiNumbers[day - 1], hiraganaDays[day - 1], romajiDays[day - 1])
}

// Month format metod
func japaneseMonth(for month: Int) -> (kanji: String, hiragana: String, romaji: String) {
    return (kanjiMonths[month - 1], hiraganaMonths[month - 1], romajiMonths[month - 1])
}

// Weekday format metod
func japaneseDayOfWeek(for weekday: Int) -> (kanji: String, hiragana: String, romaji: String) {
    return (kanjiDaysOfWeek[weekday - 1], hiraganaDaysOfWeek[weekday - 1], romajiDaysOfWeek[weekday - 1])
}

// widget entry  to track date and japanise data
struct YoubiEntry: TimelineEntry {
    let date: Date
    let dayKanji: String
    let dayHiragana: String
    let dayRomaji: String
    let monthKanji: String
    let monthHiragana: String
    let monthRomaji: String
    let dayOfWeekKanji: String
    let dayOfWeekHiragana: String
    let dayOfWeekRomaji: String
}

// Provider to manage temporal
struct YoubiProvider: TimelineProvider {
    
    // Widget placeholder
    func placeholder(in context: Context) -> YoubiEntry {
        YoubiEntry(date: Date(),
                   dayKanji: "一",
                   dayHiragana: "いちにち",
                   dayRomaji: "ichinichi",
                   monthKanji: "一月",
                   monthHiragana: "いちがつ",
                   monthRomaji: "ichigatsu",
                   dayOfWeekKanji: "月曜日",
                   dayOfWeekHiragana: "げつようび",
                   dayOfWeekRomaji: "getsuyoubi")
    }

    // Snapshot
    func getSnapshot(in context: Context, completion: @escaping (YoubiEntry) -> ()) {
        let entry = createYoubiEntry()
        completion(entry)
    }

    // Update timeline
    func getTimeline(in context: Context, completion: @escaping (Timeline<YoubiEntry>) -> ()) {
        let entry = createYoubiEntry()
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

// Create date with japanise format metod
func createYoubiEntry() -> YoubiEntry {
    let currentDate = Date()
    let calendar = Calendar.current
    let day = calendar.component(.day, from: currentDate)
    let month = calendar.component(.month, from: currentDate)
    let weekday = calendar.component(.weekday, from: currentDate)

    let dayJapanese = japaneseDay(for: day)
    let monthJapanese = japaneseMonth(for: month)
    let dayOfWeekJapanese = japaneseDayOfWeek(for: weekday)

    return YoubiEntry(date: currentDate,
                      dayKanji: dayJapanese.kanji,
                      dayHiragana: dayJapanese.hiragana,
                      dayRomaji: dayJapanese.romaji,
                      monthKanji: monthJapanese.kanji,
                      monthHiragana: monthJapanese.hiragana,
                      monthRomaji: monthJapanese.romaji,
                      dayOfWeekKanji: dayOfWeekJapanese.kanji,
                      dayOfWeekHiragana: dayOfWeekJapanese.hiragana,
                      dayOfWeekRomaji: dayOfWeekJapanese.romaji)
}

// Show data in kanji, hiragana e romaji
struct YoubiWidgetEntryView: View {
    var entry: YoubiEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            // Create Date istance
            let currentDate = Date()

            // Create DateFormatter istance
            let dateFormatter = DateFormatter()

            // Set date format
            var _: () = dateFormatter.dateFormat = "EEEE\n MMMM\n dd"

            // Covert date in string
            let dateString = dateFormatter.string(from: currentDate)
            
            Text("\(dateString)")
                .font(.headline)
                .font(.system(size: 100))
                .foregroundColor(.black)
                .padding(.bottom, 5)

            HStack {
                VStack(alignment: .leading) {
                    Text("Kanji:")
                        .font(.caption)
                    Text("\(entry.dayOfWeekKanji)\n \(entry.monthKanji)\n \(entry.dayKanji)")
                        .font(.title)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Hiragana:")
                        .font(.caption)
                    Text("\(entry.dayOfWeekHiragana)\n \(entry.monthHiragana)\n \(entry.dayHiragana)")
                        .font(.title)
                }
                Spacer()
                
            }
            VStack(alignment: .leading) {
                Text("Romaji:")
                    .font(.caption)
                Text("\(entry.dayOfWeekRomaji)\n \(entry.monthRomaji)\n \(entry.dayRomaji)".uppercased())
                    .font(.title)
            }
            .padding(.vertical)
        }
        .containerBackground(
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 0.8, green: 0.7, blue: 0.5), Color(red: 0.9, green: 0.85, blue: 0.75)]), // Backround gradient
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ), for: .widget
            )
        .cornerRadius(10)  // Round corner
    }
}
