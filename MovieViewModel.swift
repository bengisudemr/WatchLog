import Foundation
import SwiftUI

// MARK: - MovieViewModel
/// Film ve dizilerin listesini yöneten ViewModel sınıfı
/// ObservableObject protokolü ile SwiftUI'a veri değişikliklerini bildirir
/// UserDefaults kullanarak verileri kalıcı olarak saklar
class MovieViewModel: ObservableObject {
    /// Tüm film ve dizilerin listesi
    /// @Published ile değişiklikler SwiftUI'a otomatik bildirilir
    @Published var movies: [Movie] = []
    
    /// UserDefaults için anahtar
    private let moviesKey = "savedMovies"
    
    /// ViewModel başlatıldığında kaydedilmiş verileri yükler
    init() {
        loadMovies()
    }
    
    // MARK: - Veri Yükleme
    /// UserDefaults'tan kaydedilmiş filmleri yükler
    func loadMovies() {
        if let data = UserDefaults.standard.data(forKey: moviesKey) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Movie].self, from: data) {
                movies = decoded
                return
            }
        }
        // Eğer kayıtlı veri yoksa boş liste ile başla
        movies = []
    }
    
    // MARK: - Veri Kaydetme
    /// Mevcut film listesini UserDefaults'a kaydeder
    private func saveMovies() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(movies) {
            UserDefaults.standard.set(encoded, forKey: moviesKey)
        }
    }
    
    // MARK: - Film Ekleme
    /// Yeni bir film veya dizi ekler
    /// - Parameter movie: Eklenecek film/dizi
    func addMovie(_ movie: Movie) {
        movies.append(movie)
        saveMovies()
    }
    
    // MARK: - Film Silme
    /// Belirtilen index'teki filmi siler
    /// - Parameter indexSet: Silinecek filmlerin index'leri
    func deleteMovie(at indexSet: IndexSet) {
        movies.remove(atOffsets: indexSet)
        saveMovies()
    }
    
    // MARK: - Film Silme (ID ile)
    /// Belirtilen ID'ye sahip filmi siler
    /// - Parameter movie: Silinecek film
    func deleteMovie(_ movie: Movie) {
        movies.removeAll { $0.id == movie.id }
        saveMovies()
    }
    
    // MARK: - Film Güncelleme
    /// Mevcut bir filmi günceller
    /// - Parameter movie: Güncellenecek film
    func updateMovie(_ movie: Movie) {
        if let index = movies.firstIndex(where: { $0.id == movie.id }) {
            movies[index] = movie
            saveMovies()
        }
    }
}

