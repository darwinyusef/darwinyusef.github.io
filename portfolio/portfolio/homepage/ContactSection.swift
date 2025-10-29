import SwiftUI

struct ContactSection: View {
    @State private var name = ""
    @State private var email = ""
    @State private var message = ""
    
    var body: some View {
        VStack(spacing: 16) {
            Divider()
            Text("Contactame")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Usa este espacio para conectarnos")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            Link("wsgestor@gmail.com", destination: URL(string: "mailto:wsgestor@gmail.com")!)
                .foregroundColor(.blue)
            
            HStack(spacing: 20) {
                SocialIcon(systemName: "link")
                SocialIcon(systemName: "network")
            }
            .padding(.vertical, 4)
            
            VStack(spacing: 12) {
                TextField("Nombre completo", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                
                TextEditor(text: $message)
                    .frame(height: 120)
                    .padding(8)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                
                Button("Envía tu mensaje") {
                    // Acción de envío
                }
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .padding()
            .frame(maxWidth: 400)
        }
        .padding(.horizontal)
    }
}

struct ContactSection_Previews: PreviewProvider {
    static var previews: some View {
        ContactSection()
            .previewLayout(.sizeThatFits)
    }
}
