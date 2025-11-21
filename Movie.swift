import Foundation

// MARK: - Movie Model
/// Dizi veya film bilgilerini tutan model sınıfı
/// Codable protokolü ile UserDefaults'a kaydedilebilir hale getirildi
struct Movie: Identifiable, Codable {
    /// Benzersiz kimlik (UUID)
    let id: UUID
    
    /// Film veya dizi başlığı
    var title: String
    
    /// İçerik türü (Film veya Dizi)
    var type: MovieType
    
    /// Puan (0.0 - 10.0 arası)
    var rating: Double
    
    /// Kullanıcı notu
    var note: String
    
    /// Oluşturma tarihi
    var createdAt: Date
    
    /// Poster görseli (Data formatında)
    var posterImageData: Data?
    
    /// Varsayılan başlangıç değerleri ile yeni Movie oluşturur
    init(id: UUID = UUID(), title: String = "", type: MovieType = .movie, rating: Double = 5.0, note: String = "", createdAt: Date = Date(), posterImageData: Data? = nil) {
        self.id = id
        self.title = title
        self.type = type
        self.rating = rating
        self.note = note
        self.createdAt = createdAt
        self.posterImageData = posterImageData
    }
}

// MARK: - MovieType Enum
/// İçerik türünü belirten enum
enum MovieType: String, Codable, CaseIterable {
    case movie = "Film"
    case series = "Dizi"
    
    /// Türkçe görünen isim
    var displayName: String {
        return self.rawValue
    }
}

