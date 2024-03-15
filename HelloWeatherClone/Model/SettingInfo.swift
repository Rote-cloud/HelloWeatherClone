import Foundation
import SwiftUI

struct SettingInfo: Identifiable {
    var id = UUID()
    var imageName: String
    var imageColor: Color
    var text: String
    var subtext: String?
}

let display = [SettingInfo(imageName: "globe", imageColor: .orange, text: "Units", subtext: "USA"),
               SettingInfo(imageName: "moon.fill", imageColor: .orange, text: "Appearance", subtext: "Location")]
let exclusive = [SettingInfo(imageName: "heart.fill", imageColor: .purple, text: "Join the Hello Weather Fan Club"),
                 SettingInfo(imageName: "chart.bar.fill", imageColor: .purple, text: "Forecast Data", subtext: "Apple Weather+Auto"),
                 SettingInfo(imageName: "mappin.and.ellipse", imageColor: .purple, text: "Radar Options", subtext: "Precipitation"),
                 SettingInfo(imageName: "paintpalette.fill", imageColor: .purple, text: "Theme Color", subtext: "Auto"),
                 SettingInfo(imageName: "bell.fill", imageColor: .purple, text: "Notifications")]
let question = [SettingInfo(imageName: "questionmark.circle.fill", imageColor: .blue, text: "FAQs"),
                SettingInfo(imageName: "paperplane.fill", imageColor: .blue, text: "Email Support"),
                SettingInfo(imageName: "bird.fill", imageColor: .blue, text: "Tweet @helloweaterapp"),
                SettingInfo(imageName: "star.fill", imageColor: .blue, text: "Rate This App")]
let tidbits = [SettingInfo(imageName: "newspaper.fill", imageColor: .green, text: "What's New? (3.10.1)"),
               SettingInfo(imageName: "lock.fill", imageColor: .green, text: "Protecting Your Privacy"),
               SettingInfo(imageName: "figure.2", imageColor: .green, text: "About the Team")]
