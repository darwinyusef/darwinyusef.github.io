import SwiftUI

struct HeroView: View {
    @StateObject private var viewModel = PortfolioViewModel()
    var body: some View {
        Group {
            if let portfolio = viewModel.portfolio {
                VStack(spacing: 20) {
                    AsyncImage(url: URL(string: portfolio.image)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 160, height: 160)
                    .clipShape(Circle())
                    
                    VStack(spacing: 8) {
                        Text(portfolio.allname)
                            .font(.system(size: 28, weight: .black))
                            .multilineTextAlignment(.center)
                        
                        Text(portfolio.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    Spacer().frame(height: 5)
                    
                    Button(action: {
                        if let url = URL(string: "https://raw.githubusercontent.com/darwinyusef/darwinyusef/5ff0146128ab47cb7518396f2dffe4f04442ee9b/Curriculum%20Vitae%202025.pdf") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Label("Download CV", systemImage: "square.and.arrow.down")
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: 300)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                Spacer().frame(height: 10)
            } else {
                ProgressView("Cargando información...")
            }
        }.task {
            await viewModel.loadPortfolio()
        }
    }
}

struct HeroView_Previews: PreviewProvider {
    static var previews: some View {
        HeroView()
            .previewLayout(.sizeThatFits)
    }
}
