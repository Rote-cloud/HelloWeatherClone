import SwiftUI

struct SettingInfo: Identifiable {
    var id = UUID()
    var imageName: String
    var imageColor: Color
    var text: String
    var subtext: String?
}

struct SettingsView: View {
    
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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Settings")
                .bold()
                .font(.system(size: 20))
                .padding(.bottom, 5)
                .padding(.horizontal)
            Divider()
            
            ScrollView {

                Section(header:
                            HStack {
                    Text("DISPLAY OPTIONS")
                        .bold()
                        .font(.system(size: 14))
                    Spacer()
                }
                ){
                    ForEach(display) { display in
                        SettingChapter(imageName: display.imageName, imageColor: display.imageColor, text: display.text, subtext: display.subtext)
                    }
                }
                .padding(.bottom)
                
                Section(header:
                            HStack {
                    Text("EXCLUSIVE EXTRAS")
                        .bold()
                        .font(.system(size: 14))
                    Spacer()
                }
                ){
                    ForEach(exclusive) { display in
                        SettingChapter(imageName: display.imageName, imageColor: display.imageColor, text: display.text, subtext: display.subtext)
                    }
                }
                .padding(.bottom)
                
                Section(header:
                            HStack {
                    Text("HAVE A QUESTION OR NEED HELP?")
                        .bold()
                        .font(.system(size: 14))
                    Spacer()
                }
                ){
                    ForEach(question) { display in
                        SettingChapter(imageName: display.imageName, imageColor: display.imageColor, text: display.text, subtext: display.subtext)
                    }
                }
                .padding(.bottom)
                
                Section(header:
                            HStack {
                    Text("A FEW OTHER TIDBITS")
                        .bold()
                        .font(.system(size: 14))
                    Spacer()
                }
                ){
                    ForEach(tidbits) { display in
                        SettingChapter(imageName: display.imageName, imageColor: display.imageColor, text: display.text, subtext: display.subtext)
                    }
                }
                .padding(.bottom)
                
                Text("Thanks for using Hello Weather!")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                    .padding(.bottom, 50)
                
            }
            .padding([.bottom, .horizontal])
        }
    }
}

struct SettingChapter: View {
    
    let imageName: String
    let imageColor: Color
    let text: String
    let subtext: String?
    
    var body: some View {
        Button {
        } label: {
            HStack {
                Image(systemName: imageName)
                    .foregroundColor(imageColor)
                    .font(.system(size: 20))
                Text(text)
                    .foregroundColor(.black)
                
                Spacer()
                
                if let sub = subtext {
                    Text(sub)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
