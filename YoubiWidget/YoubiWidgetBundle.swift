//
//  YoubiWidgetBundle.swift
//  YoubiWidget
//
//  Created by Andrea De Martino on 17/10/24.
//

import SwiftUI
import WidgetKit


// Configurazione principale del widget
@main
struct YoubiWidget: Widget {
    let kind: String = "YoubiWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: YoubiProvider()) { entry in
            YoubiWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("YoubiWidget")
        .description("Mostra la data di oggi in lettere in italiano.")
    }
}

