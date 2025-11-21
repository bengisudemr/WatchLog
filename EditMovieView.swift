import SwiftUI

// MARK: - EditMovieView
/// Mevcut film veya diziyi düzenlemek için form ekranı
struct EditMovieView: View {
    /// Düzenlenecek film
    let movie: Movie
    
    /// Ana ViewModel referansı
    @ObservedObject var viewModel: MovieViewModel
    
    /// Form'u kapatmak için environment değişkeni
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Form State Variables
    /// Kullanıcının girdiği başlık
    @State private var title: String = ""
    
    /// Seçilen içerik türü
    @State private var selectedType: MovieType = .movie
    
    /// Kullanıcının verdiği puan
    @State private var rating: Double = 5.0
    
    /// Kullanıcının yazdığı not
    @State private var note: String = ""
    
    /// Seçilen poster görseli
    @State private var selectedImage: UIImage?
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Arka plan gradient
                LinearGradient(
                    colors: [
                        Color.orange.opacity(0.1),
                        Color.pink.opacity(0.1),
                        Color.purple.opacity(0.1)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                Form {
                    // MARK: - Poster Bölümü
                    Section {
                        HStack {
                            Spacer()
                            ImagePickerView(selectedImage: $selectedImage)
                            Spacer()
                        }
                        .listRowBackground(Color.clear)
                    }
                    
                    // MARK: - Başlık Bölümü
                    Section(header: Text("Başlık")
                        .foregroundColor(.orange)
                        .fontWeight(.semibold)) {
                        TextField("Film veya dizi adı", text: $title)
                            .textInputAutocapitalization(.words)
                            .padding(.vertical, 4)
                    }
                    .listRowBackground(Color.white.opacity(0.7))
                    
                    // MARK: - Tür Bölümü
                    Section(header: Text("Tür")
                        .foregroundColor(.orange)
                        .fontWeight(.semibold)) {
                        Picker("Tür", selection: $selectedType) {
                            ForEach(MovieType.allCases, id: \.self) { type in
                                Text(type.displayName).tag(type)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.vertical, 4)
                    }
                    .listRowBackground(Color.white.opacity(0.7))
                    
                    // MARK: - Puan Bölümü
                    Section(header: HStack {
                        Text("Puan")
                            .foregroundColor(.orange)
                            .fontWeight(.semibold)
                        Spacer()
                        Text("\(String(format: "%.1f", rating)) / 10")
                            .foregroundColor(ratingColor)
                            .fontWeight(.bold)
                    }) {
                        // Slider ile puan seçimi (0-10 arası)
                        Slider(value: $rating, in: 0...10, step: 0.5)
                            .tint(ratingColor)
                        
                        // Puan gösterimi
                        HStack {
                            Text("0")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("10")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .listRowBackground(Color.white.opacity(0.7))
                    
                    // MARK: - Not Bölümü
                    Section(header: Text("Not")
                        .foregroundColor(.orange)
                        .fontWeight(.semibold)) {
                        // TextEditor ile çok satırlı not girişi
                        TextEditor(text: $note)
                            .frame(height: 100)
                            .scrollContentBackground(.hidden)
                            .background(Color.white.opacity(0.5))
                    }
                    .listRowBackground(Color.white.opacity(0.7))
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Düzenle")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                loadMovieData()
            }
            .toolbar {
            
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    // Kaydet butonu
                    Button("Kaydet") {
                        saveMovie()
                    }
                    .foregroundColor(.green)
                    .fontWeight(.semibold)
                    // Başlık boşsa butonu devre dışı bırak
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
    
    // MARK: - Helper Properties
    /// Puana göre renk döndürür
    private var ratingColor: Color {
        switch rating {
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
    
    // MARK: - Load Function
    /// Mevcut film verilerini form'a yükler
    private func loadMovieData() {
        title = movie.title
        selectedType = movie.type
        rating = movie.rating
        note = movie.note
        
        // Poster görselini yükle
        if let imageData = movie.posterImageData,
           let image = UIImage(data: imageData) {
            selectedImage = image
        }
    }
    
    // MARK: - Save Function
    /// Güncellenmiş filmi kaydeder
    private func saveMovie() {
        // Görseli Data'ya çevir (yeni görsel seçildiyse)
        var imageData = movie.posterImageData
        if let image = selectedImage {
            imageData = image.jpegData(compressionQuality: 0.8)
        }
        
        // Güncellenmiş Movie nesnesi oluştur
        var updatedMovie = movie
        updatedMovie.title = title.trimmingCharacters(in: .whitespaces)
        updatedMovie.type = selectedType
        updatedMovie.rating = rating
        updatedMovie.note = note.trimmingCharacters(in: .whitespaces)
        updatedMovie.posterImageData = imageData
        
        // ViewModel'e güncelle
        viewModel.updateMovie(updatedMovie)
        
        // Form'u kapat
        dismiss()
    }
}

// MARK: - Preview
/// Xcode'da canlı önizleme için
#Preview {
    let sampleMovie = Movie(
        title: "Örnek Film",
        type: .movie,
        rating: 8.5,
        note: "Bu bir örnek film notudur.",
        createdAt: Date()
    )
    
    EditMovieView(movie: sampleMovie, viewModel: MovieViewModel())
}


