import SwiftUI

struct SectionView: View {
    let title: String
    let content: String
    let content2: String
    let content3: String
    let final: String
    let content4: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Divider()
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            Text(content)
                .foregroundColor(.secondary)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
            Spacer().frame(height: 5)
            Text(content2)
                .foregroundColor(.secondary)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
            Spacer().frame(height: 5)
            Text(content3)
                .foregroundColor(.secondary)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
            Text(final)
                .font(.title2)
                .fontWeight(.bold)
            Text(content4)
                .foregroundColor(.secondary)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal)
        Spacer().frame(height: 10)
    }
}

struct AboutSection: View {
    @StateObject private var viewModel = PortfolioViewModel()
    
    var body: some View {
        Group {
            if let portfolio = viewModel.portfolio {
                SectionView(
                        title: "About Me",
                        content: portfolio.about1,
                        content2: portfolio.about2,
                        content3: portfolio.about3,
                        final: "Finalmente",
                        content4: portfolio.about4
                    )
                Spacer().frame(height: 10)
            } else {
                ProgressView("Cargando información...")
            }
        }.task {
            await viewModel.loadPortfolio()
        }
    }
}

struct AboutSection_Previews: PreviewProvider {
    static var previews: some View {
        AboutSection()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
