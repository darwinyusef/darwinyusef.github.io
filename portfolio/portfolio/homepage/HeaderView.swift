import SwiftUI

struct HeaderView: View {
    var body: some View {
        Spacer().frame(height: 10)
        HStack {
            Text("@darwinyusef")
            
                .font(.system(size: 14))
                .fontWeight(.bold)
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "line.horizontal.3")
                    .font(.title2)
                    .padding(10)
                    .background(
                        Circle()
                            .fill(Color.primary.opacity(0.1))
                    )
            }
        }
        .padding(.horizontal)
        .padding(.top, 16)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
            .previewLayout(.sizeThatFits)
    }
}
