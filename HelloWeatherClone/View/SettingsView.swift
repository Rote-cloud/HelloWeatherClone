import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Settings")
                .font(Fonts.titleText)
                .foregroundColor(.primary)
                .padding(.horizontal)
                .padding(.bottom, Sizes.paddingSmall)
            Divider()
            
            ScrollView {

                Section(header:
                            HStack {
                    Text("DISPLAY OPTIONS")
                        .font(Fonts.subtitleText)
                        .foregroundColor(.primary)
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
                        .font(Fonts.subtitleText)
                        .foregroundColor(.primary)
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
                        .font(Fonts.subtitleText)
                        .foregroundColor(.primary)
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
                        .font(Fonts.subtitleText)
                        .foregroundColor(.primary)
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
                    .font(Fonts.sizeMediumText)
                    .padding(.bottom, Sizes.paddingBigBottom)
                
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
                    .font(Fonts.sizeImageLocation)
                    .frame(width: Sizes.sizeIconSettings)
                Text(text)
                    .foregroundColor(.primary)
                
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
