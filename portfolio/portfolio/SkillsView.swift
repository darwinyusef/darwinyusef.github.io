import SwiftUI


struct SkillsView: View {
    
    @State private var path = NavigationPath()
    
    @State private var showingContact = false
    
    private var skills: [Skill] = [
        Skill(category: "Back-end", title: "Python", subtitle: "Expert", description: "Extensive experience in building scalable backend services and data pipelines.", iconName: "terminal.fill", progress: 0.75),
        Skill(category: "Back-end", title: "Node", subtitle: "Proficient", description: "Creating REST APIs and realtime apps with Express.js.", iconName: "network", progress: 0.6),
        Skill(category: "Back-end", title: "Java", subtitle: "Solid", description: "Enterprise apps with Spring Framework.", iconName: "cup.and.saucer.fill", progress: nil),
        Skill(category: "Front-end", title: "Angular", subtitle: "Highly skilled", description: "SPAs with robust state management.", iconName: "shield.lefthalf.fill", progress: nil),
        Skill(category: "Front-end", title: "React + TS", subtitle: "Experienced", description: "Performant and type-safe UIs.", iconName: "r.square.fill", progress: nil),
        Skill(category: "Specialization", title: "Artificial Intelligence", subtitle: "Passionate", description: "Projects in NLP and computer vision.", iconName: "brain.head.profile", progress: nil),
    ]
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                // Background colors similar to the HTML (light/dark)
                Color(UIColor { traits in
                    traits.userInterfaceStyle == .dark ? UIColor(red: 0.07, green: 0.07, blue: 0.13, alpha: 1) : UIColor(red: 0.96, green: 0.96, blue: 0.97, alpha: 1)
                }).ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        // Back button (manual behavior: pop last)
                        Button {
                            // ejemplo de pop programático: si hay algo en la pila, hacemos pop
                            if !path.isEmpty {
                                path.removeLast()
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .semibold))
                                .padding(8)
                        }
                        .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Text("Skills & Expertise")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        // Contact modal
                        Button {
                            showingContact.toggle()
                        } label: {
                            Image(systemName: "envelope")
                                .padding(8)
                        }
                        .foregroundColor(.primary)
                        .sheet(isPresented: $showingContact) {
                            SkillsView()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    .padding(.bottom, 6)
                    
                    // Main scroll content
                    ScrollView {
                        VStack(spacing: 20) {
                            // Professional Experience Timeline (simplified)
                            TimelineSection()
                                .padding(.horizontal)
                            
                            // Sections generated from model
                            ForEach(groupedByCategory(skills: skills), id: \.key) { category, items in
                                VStack(alignment: .leading, spacing: 12) {
                                    Text(category)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("PrimaryColor", bundle: nil) /* fallback handled below */)
                                        .foregroundColor(.blue) // primary color fallback
                                        .padding(.horizontal)
                                    
                                    VStack(spacing: 12) {
                                        ForEach(items) { skill in
                                            // NavigationLink (push) to detail
                                            NavigationLink(value: skill) {
                                                SkillCardView(skill: skill)
                                                    .padding(.horizontal)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                }
                            }
                            
                            Spacer(minLength: 12)
                        }
                        .padding(.top, 8)
                        .padding(.bottom, 40)
                    } // ScrollView
                } // VStack
            } // ZStack
            // Navigation destinations for programmatic & link-based navigation
            .navigationDestination(for: Skill.self) { skill in
                SkillDetailView(skill: skill, onOpenAnother: { anotherSkill in
                    // ejemplo: navegar programáticamente a otro skill
                    path.append(anotherSkill)
                })
            }
            .navigationBarHidden(true)
        } // NavigationStack
    }
    
    // Helper: agrupa por categoría
    private func groupedByCategory(skills: [Skill]) -> [(key: String, value: [Skill])] {
        let dict = Dictionary(grouping: skills) { $0.category }
        // mantengo el orden deseado
        let order = ["Professional Experience", "Back-end", "Front-end", "Specialization"]
        return order.compactMap { key -> (String, [Skill])? in
            if let v = dict[key], !v.isEmpty { return (key, v) }
            return nil
        } + dict.filter { !order.contains($0.key) }.map { ($0.key, $0.value) }
    }
}

// MARK: - TimelineSection (Experience)
struct TimelineSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Professional Experience")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 20) {
                TimelineRow(icon: "briefcase.fill", title: "Senior Software Engineer", subtitle: "Innovate Corp | 2020 - Present", text: "Leading the development of a scalable microservices architecture.")
                TimelineRow(icon: "briefcase.fill", title: "Software Engineer", subtitle: "Tech Solutions | 2018 - 2020", text: "Developed and maintained features for a large-scale e-commerce platform.")
                TimelineRow(icon: "graduationcap.fill", title: "B.Sc. in Computer Science", subtitle: "University of Technology | 2014 - 2018", text: "Graduated with honors, focus on software & AI.")
            }
            .padding(.leading, 18)
        }
    }
}

struct TimelineRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 44, height: 44)
                Image(systemName: icon)
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title).fontWeight(.semibold)
                Text(subtitle).font(.caption).foregroundColor(.secondary)
                Text(text).font(.subheadline).foregroundColor(.secondary)
            }
        }
    }
}

// MARK: - Skill Card
struct SkillCardView: View {
    let skill: Skill
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .top) {
                ZStack {
                    Circle().fill(Color.blue.opacity(0.12)).frame(width: 44, height: 44)
                    Image(systemName: skill.iconName)
                        .foregroundColor(.blue)
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(skill.title).fontWeight(.semibold)
                    Text(skill.subtitle).font(.caption).foregroundColor(.secondary)
                    Text(skill.description).font(.caption).foregroundColor(.secondary).lineLimit(2)
                }
                
                Spacer()
                
                // Example control (play/pause icons like HTML)
                Button {} label: {
                    Image(systemName: skill.progress == nil ? "play.circle.fill" : "pause.circle.fill")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
            }
            
            if let p = skill.progress {
                HStack(spacing: 8) {
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule().fill(Color(UIColor.systemGray5)).frame(height: 6)
                            Capsule().fill(Color.blue).frame(width: geo.size.width * CGFloat(p), height: 6)
                        }
                    }
                    .frame(height: 6)
                    
                    Text(progressText(p)).font(.caption).monospacedDigit().foregroundColor(.gray)
                }
                .padding(.top, 6)
            }
        }
        .padding()
        .background(Color(UIColor { traits in
            traits.userInterfaceStyle == .dark ? UIColor(red: 0.10, green: 0.10, blue: 0.18, alpha: 1) : UIColor.white
        }))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.03), radius: 6, x: 0, y: 2)
    }
    
    private func progressText(_ p: Double) -> String {
        let total = 90 // ejemplo 1:30 -> 90 segundos
        let current = Int(Double(total) * p)
        return "\(current):\(String(format: "%02d", 0)) / 1:30"
    }
}

// MARK: - Skill Detail
struct SkillDetailView: View {
    let skill: Skill
    var onOpenAnother: ((Skill) -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text(skill.title)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            
            Text(skill.description)
                .padding(.horizontal)
            
            Spacer()
            
            // Example: abrir otro skill programáticamente (si se pasa callback)
            if let onOpenAnother = onOpenAnother {
                Button("Abrir otro skill programáticamente") {
                    let new = Skill(category: skill.category, title: "\(skill.title) Deep Dive", subtitle: "Deep", description: "Deep explanation...", iconName: skill.iconName, progress: nil)
                    onOpenAnother(new)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.bottom, 30)
            }
        }
        .navigationTitle(skill.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SkillsFormView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var email = ""
    @State private var message = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Contact")) {
                    TextField("Name", text: $name)
                    TextField("Email", text: $email).keyboardType(.emailAddress)
                    TextEditor(text: $message).frame(height: 120)
                }
                
                Section {
                    Button("Send") {
                        // acción de envío
                        dismiss()
                    }
                }
            }
            .navigationTitle("Contact")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }
}

// MARK: - Preview (compatible Xcode <15 & 15)
struct SkillsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SkillsView()
                .preferredColorScheme(.light)
            SkillsFormView()
                .preferredColorScheme(.dark)
        }
    }
}
