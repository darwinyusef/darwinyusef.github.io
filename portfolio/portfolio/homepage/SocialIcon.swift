import SwiftUI

struct SocialIcon: View {
    let systemName: String
    var body: some View {
        Image(systemName: systemName)
            .font(.title2)
            .foregroundColor(.secondary)
            .onTapGesture {}
    }
}

struct SocialIcon_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            SocialIcon(systemName: "link")
            SocialIcon(systemName: "network")
        }
        .previewLayout(.sizeThatFits)
    }
}
