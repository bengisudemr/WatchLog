# WatchLog – Dizi/Film Günlüğü

SwiftUI ve MVVM mimarisi kullanılarak geliştirilmiş bir iOS uygulaması.

## Özellikler

- ✅ Film ve dizi ekleme
- ✅ İçerik listesi görüntüleme
- ✅ Detay ekranı
- ✅ İçerik silme
- ✅ UserDefaults ile veri saklama
- ✅ MVVM mimarisi
- ✅ SwiftUI bileşenleri

## Proje Yapısı

```
WatchLog/
├── WatchLogApp.swift      # Ana uygulama dosyası
├── Movie.swift            # Model (Movie ve MovieType)
├── MovieViewModel.swift   # ViewModel (Veri yönetimi)
├── MovieListView.swift    # Ana liste ekranı
├── AddMovieView.swift     # Yeni içerik ekleme formu
└── MovieDetailView.swift  # Detay ekranı
```

## Xcode'da Proje Oluşturma

### 1. Yeni Proje Oluştur
1. Xcode'u açın
2. **File > New > Project** seçin
3. **iOS > App** şablonunu seçin
4. Proje bilgilerini doldurun:
   - **Product Name**: `WatchLog`
   - **Interface**: `SwiftUI`
   - **Language**: `Swift`
   - **Use Core Data**: Hayır (seçmeyin)
   - **Include Tests**: İsteğe bağlı

### 2. Dosyaları Projeye Ekle
1. Proje oluşturulduktan sonra, oluşturulan `WatchLog` klasörüne gidin
2. Bu dosyaları Xcode projesine sürükleyip bırakın:
   - `Movie.swift`
   - `MovieViewModel.swift`
   - `MovieListView.swift`
   - `AddMovieView.swift`
   - `MovieDetailView.swift`

3. **WatchLogApp.swift** dosyasını oluşturulan `WatchLogApp.swift` dosyası ile değiştirin

### 3. Proje Yapılandırması
1. Xcode'da proje ayarlarını kontrol edin
2. **Deployment Target**: iOS 16.0 veya üzeri (SwiftUI NavigationStack için)
3. Eğer iOS 16.0'dan düşük bir sürüm kullanıyorsanız, `NavigationStack` yerine `NavigationView` kullanabilirsiniz

## Kullanım

### Ana Ekran
- Tüm eklenen film ve diziler listelenir
- Her satırda başlık, tür ve puan gösterilir
- Sağ üst köşedeki **+** butonu ile yeni içerik eklenebilir
- Kaydırma hareketi ile içerik silinebilir

### Yeni İçerik Ekleme
1. Ana ekranda **+** butonuna tıklayın
2. Form alanlarını doldurun:
   - **Başlık**: Film veya dizi adı
   - **Tür**: Film veya Dizi seçimi
   - **Puan**: 0-10 arası slider ile seçim
   - **Not**: İsteğe bağlı not alanı
3. **Kaydet** butonuna tıklayın

### Detay Ekranı
- Liste satırına tıklayarak detay ekranına gidin
- Tüm bilgiler (başlık, tür, puan, not, tarih) görüntülenir
- **Sil** butonu ile içerik silinebilir

## MVVM Mimarisi

### Model (Movie.swift)
- `Movie`: Film/dizi bilgilerini tutan struct
- `MovieType`: İçerik türünü belirten enum
- Codable protokolü ile UserDefaults'a kaydedilebilir

### ViewModel (MovieViewModel.swift)
- `MovieViewModel`: Veri yönetimini sağlayan class
- `@Published` ile SwiftUI'a veri değişikliklerini bildirir
- UserDefaults ile veri kalıcılığı sağlar
- CRUD işlemleri (Create, Read, Update, Delete)

### Views
- **MovieListView**: Ana liste ekranı
- **AddMovieView**: Yeni içerik ekleme formu
- **MovieDetailView**: Detay ekranı
- Her view, ViewModel'i `@ObservedObject` veya `@StateObject` ile kullanır

## SwiftUI Bileşenleri

- **NavigationStack**: Navigasyon yönetimi
- **List**: Liste görünümü
- **Form**: Form görünümü
- **TextField**: Metin girişi
- **Picker**: Seçim yapma (segmented style)
- **Slider**: Puan seçimi
- **TextEditor**: Çok satırlı metin girişi
- **Button**: Buton işlevleri

## Veri Saklama

- UserDefaults kullanılarak veriler kalıcı olarak saklanır
- JSONEncoder/JSONDecoder ile Movie array'i encode/decode edilir
- Veriler uygulama kapatıldığında bile korunur

## Öğrenme Notları

### @StateObject vs @ObservedObject
- `@StateObject`: View'ın sahibi olduğu ve yaşam döngüsünü yönettiği ViewModel için
- `@ObservedObject`: Başka bir view'dan geçirilen ViewModel için

### NavigationStack
- iOS 16+ için kullanılır
- Daha modern navigasyon yönetimi sağlar
- iOS 15 ve öncesi için `NavigationView` kullanılabilir

### UserDefaults
- Küçük veri setleri için uygun
- Key-value store
- JSON encoding/decoding ile kompleks veri yapıları saklanabilir

## Geliştirme Notları

- Kodlar yorumlarla açıklanmıştır
- MVVM mimarisi doğru şekilde uygulanmıştır
- SwiftUI best practices kullanılmıştır
- Türkçe karakter desteği mevcuttur

## Sonraki Adımlar

İsterseniz şu özellikleri ekleyebilirsiniz:
- İçerik düzenleme (edit) özelliği
- Filtreleme (türe göre, puana göre)
- Sıralama (tarihe göre, puana göre)
- Arama özelliği
- Görsel ekleme (poster)
- Daha gelişmiş veri saklama (Core Data veya SwiftData)

## Lisans

Bu proje eğitim amaçlıdır.

