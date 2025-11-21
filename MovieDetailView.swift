import SwiftUI

// MARK: - MovieDetailView
/// Film veya dizinin detay bilgilerini gösteren ekran
struct MovieDetailView: View {
    let movie: Movie
    @ObservedObject var viewModel: MovieViewModel
    
    /// Form'u kapatmak için environment değişkeni
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // MARK: - Poster Bölümü
                ZStack(alignment: .bottomLeading) {
                    // Poster görseli veya placeholder
                    if let imageData = movie.posterImageData,
                       let image = UIImage(data: imageData) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 300) // Bunu 300'e düşürmüşsün, o kalsın
                            .clipped()
                    } else {
                        // Varsayılan placeholder
                        LinearGradient(
                            colors: [Color.purple.opacity(0.6), Color.blue.opacity(0.6)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(height: 400)
                        .overlay(
                            Image(systemName: "photo")
                                .font(.system(size: 80))
                                .foregroundColor(.white.opacity(0.7))
                        )
                    }
                    
                    // Gradient overlay
                    LinearGradient(
                        colors: [Color.clear, Color.black.opacity(0.7)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 400) // Bunu da 400 bırakmışsın, kalsın
                    
                    // Başlık ve tür bilgisi
                    VStack(alignment: .leading, spacing: 8) {
                        Text(movie.title)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                        
                        HStack(spacing: 8) {
                            Image(systemName: movie.type == .movie ? "film.fill" : "tv.fill")
                                .foregroundColor(.white)
                            Text(movie.type.displayName)
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .shadow(radius: 5)
                    }
                    .padding(20)
                }
                
                // MARK: - Detay Bilgileri
                VStack(alignment: .leading, spacing: 24) {
                    // Puan Bölümü
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Puan")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            HStack(alignment: .bottom, spacing: 4) {
                                Text(String(format: "%.1f", movie.rating))
                                    .font(.system(size: 48, weight: .bold))
                                    .foregroundColor(ratingColor)
                                Text("/ 10")
                                    .font(.title3)
                                    .foregroundColor(.secondary)
                                    .padding(.bottom, 8)
                            }
                        }
                        
                        Spacer()
                        
                        // Yıldız gösterimi
                        HStack(spacing: 4) {
                            ForEach(0..<5) { index in
                                Image(systemName: index < Int(movie.rating / 2) ? "star.fill" : "star")
                                    .foregroundColor(ratingColor)
                                    .font(.title2)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    Divider()
                        .padding(.horizontal, 20)
                    
                    // Not Bölümü
                    if !movie.note.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Notlarım")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text(movie.note)
                                .font(.body)
                                .foregroundColor(.secondary)
                                .lineSpacing(4)
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Tarih Bölümü
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Eklenme Tarihi")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(movie.createdAt, style: .date)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20) // Alttaki butonlar kalktığı için buradaki padding kalsın
                    
                    // DİKKAT: Düzenle ve Sil Butonları HStack'i buradan SİLİNDİ.
                    // Senin kodunda zaten silinmiş ve " " olarak boşluk bırakılmış.
                    
                }
            }
        }
        // YENİ EKLENEN KISIM BURASI
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    // 1. Düzenle Butonu
                    NavigationLink(destination: EditMovieView(movie: movie, viewModel: viewModel)) {
                        Label("Düzenle", systemImage: "pencil")
                    }
                    
                    // 2. Sil Butonu
                    Button(role: .destructive, action: {
                        viewModel.deleteMovie(movie)
                        dismiss()
                    }) {
                        Label("Sil", systemImage: "trash")
                    }
                } label: {
                    // Menüyü açan asıl ikon
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        // YENİ EKLENEN KISIM BURADA BİTİYOR
        .background(
            LinearGradient(
                colors: [
                    Color.purple.opacity(0.1),
                    Color.blue.opacity(0.1),
                    Color.pink.opacity(0.1)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Helper Properties
    /// Puana göre renk döndürür
    private var ratingColor: Color {
        switch movie.rating {
        case 0..<3:
            return .red
        case 3..<5:
            return .orange
        case 5..<7:
            return .yellow
        case 7..<9:
            return .green
        default:
            return .blue
        }
    }
}
// MARK: - Preview
/// Xcode'da canlı önizleme için
#Preview {
    // Örnek poster resmi
    let posterImage = UIImage(systemName: "film.fill")!
    let posterData = posterImage.pngData()
    
    let sampleMovie = Movie(
        id: UUID(),
        title: "Inception",
        type: .movie,
        rating: 8.8,
        note: "Muhteşem bir film. Christopher Nolan'ın en iyi işlerinden biri. Rüya içinde rüya konsepti çok etkileyici.",
        createdAt: Date(),
        posterImageData: posterData
    )
    
    NavigationStack {
        MovieDetailView(movie: sampleMovie, viewModel: MovieViewModel())
    }
}
