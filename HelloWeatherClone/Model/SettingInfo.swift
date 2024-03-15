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
let exclusive = [SettingInfo(imageName: "heart.fill", imageColor: Color("violet"), text: "Join the Hello Weather Fan Club"),
                 SettingInfo(imageName: "chart.bar.fill", imageColor: Color("violet"), text: "Forecast Data", subtext: "Apple Weather+Auto"),
                 SettingInfo(imageName: "mappin.and.ellipse", imageColor: Color("violet"), text: "Radar Options", subtext: "Precipitation"),
                 SettingInfo(imageName: "paintpalette.fill", imageColor: Color("violet"), text: "Theme Color", subtext: "Auto"),
                 SettingInfo(imageName: "bell.fill", imageColor: Color("violet"), text: "Notifications")]
let question = [SettingInfo(imageName: "questionmark.circle.fill", imageColor: Color("blues"), text: "FAQs"),
                SettingInfo(imageName: "paperplane.fill", imageColor: Color("blues"), text: "Email Support"),
                SettingInfo(imageName: "bird.fill", imageColor: Color("blues"), text: "Tweet @helloweaterapp"),
                SettingInfo(imageName: "star.fill", imageColor: Color("blues"), text: "Rate This App")]
let tidbits = [SettingInfo(imageName: "newspaper.fill", imageColor: .green, text: "What's New? (3.10.1)"),
               SettingInfo(imageName: "lock.fill", imageColor: .green, text: "Protecting Your Privacy"),
               SettingInfo(imageName: "figure.2", imageColor: .green, text: "About the Team")]
