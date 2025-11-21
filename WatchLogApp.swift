import SwiftUI

// MARK: - WatchLogApp
/// Uygulamanın ana giriş noktası
/// @main attribute'u ile bu dosyanın uygulamanın başlangıç noktası olduğunu belirtiyoruz
@main
struct WatchLogApp: App {
    var body: some Scene {
        WindowGroup {
            // Ana ekran olarak MovieListView'i göster
            MovieListView()
        }
    }
}

