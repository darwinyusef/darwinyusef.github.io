import Foundation

@MainActor
class PortfolioViewModel: ObservableObject {
    @Published var portfolio: Portfolio?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let urlString = "https://gist.githubusercontent.com/darwinyusef/e147082bb71ce92c5e4b0de219ab1ae8/raw/b21d21db809f42359792647122434f2cae08d190/portfolio.json"

    func loadPortfolio() async {
        guard let url = URL(string: urlString) else {
            errorMessage = "URL inválida"
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            let decoded = try JSONDecoder().decode(Portfolio.self, from: data)
            self.portfolio = decoded
        } catch {
            errorMessage = error.localizedDescription
            print("❌ Error al cargar JSON:", error)
        }
    }
}
