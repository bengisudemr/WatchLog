import SwiftUI

// MARK: - MovieListView
/// Ana ekran: Tüm film ve dizilerin listesini gösterir
struct MovieListView: View {
    /// ViewModel'i @StateObject ile oluşturuyoruz
    /// @StateObject, view'ın sahibi olduğu ve yaşam döngüsünü yönettiği anlamına gelir
    @StateObject private var viewModel = MovieViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Arka plan gradient
                LinearGradient(
                    colors: [
                        Color.purple.opacity(0.15),
                        Color.blue.opacity(0.15),
                        Color.pink.opacity(0.15)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // MARK: - Liste Görünümü
                List {
                    // Eğer film yoksa bilgilendirme mesajı göster
                    if viewModel.movies.isEmpty {
                        VStack(spacing: 20) {
                            Image(systemName: "film.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.purple.opacity(0.5))
                            Text("Henüz film veya dizi eklenmemiş")
                                .foregroundColor(.secondary)
                                .font(.headline)
                            Text("Sağ üstteki + butonuna tıklayarak başlayın")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 60)
                        .listRowBackground(Color.clear)
                    } else {
                        // Film listesini göster
                        ForEach(viewModel.movies) { movie in
                            // Her film için NavigationLink ile detay ekranına yönlendirme
                            NavigationLink(destination: MovieDetailView(movie: movie, viewModel: viewModel)) {
                                MovieRowView(movie: movie)
                            }
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white.opacity(0.8))
                                    .padding(.vertical, 4)
                            )
                        }
                        // Silme işlemi için onDelete modifier'ı
                        .onDelete(perform: viewModel.deleteMovie)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("WatchLog")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // Yeni film ekleme butonu
                    NavigationLink(destination: AddMovieView(viewModel: viewModel)) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.purple)
                    }
                }
            }
        }
    }
}

// MARK: - MovieRowView
/// Liste satırında gösterilecek film bilgileri
struct MovieRowView: View {
    let movie: Movie
    
    var body: some View {
        HStack(spacing: 12) {
            // Poster görseli
            if let imageData = movie.posterImageData,
               let image = UIImage(data: imageData) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 90)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.white.opacity(0.8), lineWidth: 1)
                    )
                    .shadow(radius: 3)
            } else {
                // Varsayılan placeholder
                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        LinearGradient(
                            colors: [Color.purple.opacity(0.3), Color.blue.opacity(0.3)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 60, height: 90)
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.white.opacity(0.6))
                            .font(.title3)
                    )
            }
            
            VStack(alignment: .leading, spacing: 6) {
                // Başlık
                Text(movie.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                // Tür bilgisi
                HStack {
                    Image(systemName: movie.type == .movie ? "film.fill" : "tv.fill")
                        .font(.caption)
                        .foregroundColor(.purple)
                    Text(movie.type.displayName)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            // Puan gösterimi
            VStack(alignment: .trailing, spacing: 4) {
                Text(String(format: "%.1f", movie.rating))
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(ratingColor)
                
                Text("/ 10")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.leading, 8)
        }
        .padding(.vertical, 8)
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
    MovieListView()
}

