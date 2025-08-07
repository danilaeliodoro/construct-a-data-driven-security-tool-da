import SwiftUI
import CoreGraphics

struct SecurityData: Identifiable, Hashable {
    let id = UUID()
    var threatLevel: String
    var incidentType: String
    var location: String
    var timestamp: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class SecurityDashboardViewModel {
    @Published var securityData: [SecurityData] = [
        SecurityData(threatLevel: "High", incidentType: "Unauthorized Access", location: "Server Room", timestamp: Date()),
        SecurityData(threatLevel: "Medium", incidentType: "Malware Detection", location: "User's PC", timestamp: Date()),
        SecurityData(threatLevel: "Low", incidentType: "Suspicious Activity", location: "Network", timestamp: Date())
    ]
    
    func fetchSecurityData() {
        // Simulate API call to fetch security data
        // Replace with actual API call
        securityData.append(SecurityData(threatLevel: "Critical", incidentType: "Data Breach", location: "Database", timestamp: Date()))
    }
}

struct SecurityDashboardView: View {
    @StateObject var viewModel = SecurityDashboardViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.securityData) { data in
                VStack(alignment: .leading) {
                    Text("Threat Level: \(data.threatLevel)")
                    Text("Incident Type: \(data.incidentType)")
                    Text("Location: \(data.location)")
                    Text("Timestamp: \(data.timestamp, format: .relative(precision: .minute))")
                }
            }
            .navigationTitle("Security Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Fetch Data") {
                        viewModel.fetchSecurityData()
                    }
                }
            }
        }
    }
}

@main
struct SecurityDashboardApp: App {
    var body: some Scene {
        WindowGroup {
            SecurityDashboardView()
        }
    }
}