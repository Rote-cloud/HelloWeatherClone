import SwiftUI

struct LocationsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Locations")
                    .bold()
                    .font(.system(size: 20))
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "plus")                        .foregroundColor(.black)
                }
            } 
            .padding(.horizontal)
            .padding(.bottom, 5)
            
            Divider()
            
            ScrollView {
                Location(imageName: "target", text: "Your current location", image2: nil)
                Location(imageName: "text.justify", text: "New York, New York", image2: "xmark")
            }
            .navigationTitle("Locations")
            .padding([.bottom, .horizontal])
        }
    }
}

struct Location: View {
    
    let imageName: String
    let text: String
    let image2: String?
    
    var body: some View {
        HStack {
            Button {
            } label: {
                HStack {
                    Image(systemName: imageName)
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    Text(text)
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            Button {
                
            } label: {
                if let image = image2 {
                    Image(systemName: image)
                        .foregroundColor(.black)
                }
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    LocationsView()
}
