# 🎬 WatchLog

<div align="center">

![iOS](https://img.shields.io/badge/iOS-16.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-4.0-green.svg)
![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)

**İzlediğiniz film ve dizileri takip edin, puanlayın ve notlar alın!**

[Özellikler](#-özellikler) • [Kurulum](#-kurulum) • [Kullanım](#-kullanım) • [Ekran Görüntüleri](#-ekran-görüntüleri) • [Teknik Detaylar](#-teknik-detaylar)

</div>

---

## 📱 Hakkında

WatchLog, SwiftUI ve MVVM mimarisi kullanılarak geliştirilmiş modern bir iOS uygulamasıdır. İzlediğiniz film ve dizileri kaydedebilir, puanlayabilir, notlar ekleyebilir ve poster görselleri ekleyebilirsiniz.

## ✨ Özellikler

### 🎯 Temel Özellikler
- ✅ **Film ve Dizi Ekleme**: Başlık, tür, puan ve not ile içerik ekleyin
- ✅ **Poster Görseli**: Fotoğraf kütüphanenizden poster görseli seçin
- ✅ **Puanlama Sistemi**: 0-10 arası slider ile puan verin
- ✅ **Detaylı Görünüm**: Büyük poster, puan, notlar ve eklenme tarihi
- ✅ **Düzenleme**: Mevcut içerikleri kolayca düzenleyin
- ✅ **Silme**: Kaydırma hareketi veya detay ekranından silin
- ✅ **Kalıcı Veri**: UserDefaults ile verileriniz güvenle saklanır

### 🎨 Kullanıcı Arayüzü
- Modern ve şık gradient arka planlar
- Renkli puan gösterimi (kırmızı → mavi)
- Yıldız gösterimi ile görsel puanlama
- Responsive tasarım
- Smooth animasyonlar

## 🚀 Kurulum

### Gereksinimler
- Xcode 15.0 veya üzeri
- iOS 16.0 veya üzeri
- Swift 5.0+

### Adımlar

1. **Repository'yi klonlayın**
   ```bash
   git clone https://github.com/bengisudemr/WatchLog.git
   cd WatchLog
   ```

2. **Xcode'da açın**
   ```bash
   open WatchLog.xcodeproj
   ```

3. **Cihaz seçin**
   - Xcode'da üst kısımdan hedef cihazınızı seçin (Simulator veya fiziksel cihaz)

4. **Çalıştırın**
   - `⌘ + R` tuşlarına basın veya Run butonuna tıklayın

### Fiziksel Cihaza Yükleme

1. iPhone'unuzu Mac'inize bağlayın
2. Xcode'da cihazınızı seçin
3. **Signing & Capabilities** bölümünden Apple Developer hesabınızı seçin
4. Run butonuna basın
5. İlk yüklemede: **Ayarlar > Genel > VPN ve Cihaz Yönetimi** bölümünden geliştirici sertifikanıza güvenin

## 📖 Kullanım

### Ana Ekran (MovieListView)
- Tüm eklenen film ve dizilerinizi görüntüleyin
- Her kartta poster, başlık, tür ve puan gösterilir
- **+** butonu ile yeni içerik ekleyin
- Kartlara dokunarak detay ekranına gidin
- Sola kaydırarak içerik silin

### Yeni İçerik Ekleme (AddMovieView)
1. Ana ekranda **+** butonuna tıklayın
2. **Poster Seç**: Fotoğraf kütüphanenizden poster görseli seçin
3. **Başlık**: Film veya dizi adını girin
4. **Tür**: Film veya Dizi seçin
5. **Puan**: Slider ile 0-10 arası puan verin
6. **Not**: İsteğe bağlı notlarınızı yazın
7. **Kaydet** butonuna tıklayın

### Detay Ekranı (MovieDetailView)
- Büyük poster görseli
- Başlık ve tür bilgisi
- Büyük puan gösterimi ve yıldızlar
- Kullanıcı notları
- Eklenme tarihi
- **Düzenle** butonu ile içeriği düzenleyin
- **Sil** butonu ile içeriği silin

### Düzenleme (EditMovieView)
1. Detay ekranından **Düzenle** butonuna tıklayın
2. İstediğiniz alanları güncelleyin
3. **Kaydet** butonuna tıklayın

## 🖼️ Ekran Görüntüleri

> 📸 Ekran görüntüleri yakında eklenecek

## 🏗️ Proje Yapısı

```
WatchLog/
├── WatchLogApp.swift          # Ana uygulama giriş noktası
├── Movie.swift                 # Model: Movie ve MovieType
├── MovieViewModel.swift        # ViewModel: Veri yönetimi ve iş mantığı
├── MovieListView.swift         # Ana liste ekranı
├── AddMovieView.swift          # Yeni içerik ekleme formu
├── EditMovieView.swift         # İçerik düzenleme formu
├── MovieDetailView.swift       # Detay ekranı
├── ImagePicker.swift           # Fotoğraf seçici bileşeni
├── Info.plist                  # Uygulama yapılandırması
└── README.md                   # Bu dosya
```

## 🏛️ Mimari

### MVVM (Model-View-ViewModel)

#### Model (`Movie.swift`)
- `Movie`: Film/dizi bilgilerini tutan struct
  - `id`: Benzersiz kimlik (UUID)
  - `title`: Başlık
  - `type`: Tür (Film/Dizi)
  - `rating`: Puan (0.0-10.0)
  - `note`: Kullanıcı notu
  - `createdAt`: Oluşturma tarihi
  - `posterImageData`: Poster görseli (Data formatında)
- `MovieType`: İçerik türü enum'ı
- `Codable` protokolü ile UserDefaults'a kaydedilebilir

#### ViewModel (`MovieViewModel.swift`)
- `@Published var movies`: Film listesi
- `loadMovies()`: UserDefaults'tan veri yükleme
- `saveMovies()`: UserDefaults'a veri kaydetme
- `addMovie(_:)`: Yeni film ekleme
- `updateMovie(_:)`: Film güncelleme
- `deleteMovie(_:)`: Film silme

#### Views
- **MovieListView**: Ana liste ekranı (`@StateObject` ile ViewModel oluşturur)
- **AddMovieView**: Yeni içerik ekleme (`@ObservedObject` ile ViewModel alır)
- **EditMovieView**: İçerik düzenleme (`@ObservedObject` ile ViewModel alır)
- **MovieDetailView**: Detay ekranı (`@ObservedObject` ile ViewModel alır)

## 🔧 Teknik Detaylar

### Kullanılan Teknolojiler
- **SwiftUI**: Modern UI framework
- **MVVM**: Mimari desen
- **UserDefaults**: Veri saklama
- **UIImagePickerController**: Fotoğraf seçimi
- **NavigationStack**: Navigasyon yönetimi (iOS 16+)

### SwiftUI Bileşenleri
- `NavigationStack`: Navigasyon
- `List`: Liste görünümü
- `Form`: Form görünümü
- `TextField`: Metin girişi
- `Picker`: Seçim (segmented style)
- `Slider`: Puan seçimi
- `TextEditor`: Çok satırlı metin
- `ImagePicker`: Özel fotoğraf seçici
- `LinearGradient`: Gradient arka planlar

### Veri Saklama
- **UserDefaults**: JSONEncoder/JSONDecoder ile Movie array'i saklanır
- Veriler uygulama kapatıldığında bile korunur
- Küçük-orta ölçekli veri setleri için uygun

### Önemli Notlar
- **@StateObject vs @ObservedObject**:
  - `@StateObject`: View'ın sahibi olduğu ViewModel için
  - `@ObservedObject`: Başka bir view'dan geçirilen ViewModel için
- **NavigationStack**: iOS 16+ için kullanılır (iOS 15 için `NavigationView`)
- **ImagePicker**: UIKit'in `UIImagePickerController`'ını SwiftUI'da kullanmak için wrapper

## 🎨 Tasarım Özellikleri

- **Renk Paleti**: Mor, mavi ve pembe tonları
- **Gradient Arka Planlar**: Her ekranda farklı gradient kombinasyonları
- **Puan Renkleri**:
  - 0-3: Kırmızı 🔴
  - 3-5: Turuncu 🟠
  - 5-7: Sarı 🟡
  - 7-9: Yeşil 🟢
  - 9-10: Mavi 🔵
- **Yuvarlatılmış Köşeler**: Modern görünüm için
- **Gölgeler**: Derinlik hissi için

## 🚧 Gelecek Özellikler

- [ ] Arama özelliği
- [ ] Filtreleme (türe göre, puana göre)
- [ ] Sıralama (tarihe göre, puana göre, alfabetik)
- [ ] İstatistikler (toplam film/dizi sayısı, ortalama puan)
- [ ] Kategoriler/Etiketler
- [ ] İzleme durumu (İzlendi, İzlenecek, Yarım kaldı)
- [ ] Favoriler
- [ ] Export/Import özelliği
- [ ] Dark mode optimizasyonları
- [ ] Core Data veya SwiftData entegrasyonu

## 🤝 Katkıda Bulunma

Katkılarınızı bekliyoruz! Lütfen:
1. Fork edin
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Commit edin (`git commit -m 'Add some amazing feature'`)
4. Push edin (`git push origin feature/amazing-feature`)
5. Pull Request açın

## 📝 Lisans

Bu proje eğitim amaçlıdır ve MIT lisansı altında lisanslanmıştır.

## 👤 Geliştirici

**Bengisu Demir**
- GitHub: [@bengisudemr](https://github.com/bengisudemr)
- Email: bengisudemrr@gmail.com

## 🙏 Teşekkürler

- SwiftUI topluluğu
- Tüm katkıda bulunanlar

---

<div align="center">

⭐ Bu projeyi beğendiyseniz yıldız vermeyi unutmayın!

Made with ❤️ using SwiftUI

</div>
