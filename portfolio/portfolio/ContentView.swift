import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(spacing: 1) {
                HeaderView()
                HeroView()
                AboutSection()
                ContactSection()
            }
            .padding(.bottom, 40)
        }
        .background(
            colorScheme == .dark
            ? Color(red: 0.07, green: 0.07, blue: 0.13)
            : Color(red: 0.96, green: 0.96, blue: 0.97)
        )
        .ignoresSafeArea(edges: .top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
