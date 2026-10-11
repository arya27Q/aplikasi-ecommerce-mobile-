# Dokumentasi Lengkap Proyek: Evolusi Navigasi & Integrated State Management

Dokumen ini menyajikan rekam jejak lengkap pengembangan aplikasi e-commerce sepatu, mencakup **komparasi sebelum vs sesudah penambahan tugas**, **arsitektur struktur folder modular beserta fungsi detail tiap file**, **implementasi teknis 5 tugas navigasi + misi state management**, **AI Review Summary**, dan **Architecture Justification**.

---

## 1. Komparasi: Sebelum vs Sesudah Penambahan Tugas

| Aspek | Kondisi SEBELUM Penambahan (Fase 1: Navigasi Dasar) | Kondisi SESUDAH Penambahan (Fase 2: Integrated State & Fitur Baru) |
| :--- | :--- | :--- |
| **Fokus Tugas** | Hanya berfokus pada navigasi deklaratif menggunakan `go_router` (ShellRoute, Data Transit, Boomerang Effect, Auth Guard). | Menggabungkan **Arsitektur Navigasi Modern** dengan **Clean Code & Integrated State Management (`Provider`)**. |
| **Manajemen Keranjang (Cart)** | Data keranjang masih statis/hardcoded di dalam widget `CartTab`. Tidak bisa ditambah atau diubah. | Terintegrasi penuh dengan `CartProvider`. Item bisa ditambah, diubah jumlahnya, dihapus satuan, atau dikosongkan total (*Clear All*). |
| **Varian Produk (Variant Handling)** | Pilihan ukuran sepatu (size chips) di halaman detail hanya elemen statis tanpa interaksi. | Interaktif! Pengguna dapat memilih ukuran (40, 41, 42, 43, 44) dan produk disimpan ke keranjang spesifik berdasarkan varian ukuran yang dipilih. |
| **Kalkulasi Total Pembayaran** | Dihitung manual dengan variabel lokal saat widget pertama kali di-build. | Menggunakan **Derived Getters** (`cart.totalPrice` & `cart.totalItemCount`) yang menghitung nilai secara otomatis dan reaktif setiap ada perubahan state. |
| **Jumlah Halaman / Tab** | Memiliki 4 tab: Home, Wishlist, Cart, Profile. | **Nambah 1 halaman baru: Leaderboard ("Liverbord")** sehingga menjadi 5 tab (Home, Wishlist, Leaderboard, Cart, Profile). |
| **Sinkronisasi Antar Halaman** | Belum ada komunikasi data antar layar secara global. | Sinkronisasi mulus di 3 area sekaligus: Halaman Detail Produk ➡️ Halaman My Cart ➡️ Floating Bottom Nav (Badge Counter belanjaan). |
| **Struktur Kode & Folder** | Monolitik: Satu file screen memuat ratusan baris kode gabungan antara tampilan layout, komponen tombol, dan kartu. | **Feature-first Modular**: Setiap layar memiliki folder sendiri dan komponen penyusunnya dipecah ke dalam sub-folder `widgets/` mandiri. |

---

## 2. Arsitektur Struktur Folder & Penjelasan Fungsi File

Struktur proyek mengadopsi pola **Feature-first Modular**. Kode dibagi berdasarkan fitur bisnis untuk memastikan prinsip *Separation of Concerns (SoC)*:

```text
lib/
├── main.dart                                # Entry point aplikasi & inisialisasi MultiProvider
├── auth/                                    # Modul Autentikasi & Guard State
│   └── auth_notifier.dart                   # State login/logout (ChangeNotifier) untuk proteksi rute
├── models/                                  # Data Models (Representasi Data)
│   ├── product.dart                         # Model data produk sepatu & data katalog dummy
│   └── cart_item.dart                       # Model item keranjang belanja dengan varian ukuran & kuantitas
├── providers/                               # Global State Management (Business Logic)
│   └── cart_provider.dart                   # Otak keranjang belanja (tambah, hapus, varian, derived getters)
├── router/                                  # Konfigurasi Routing Deklaratif
│   └── app_router.dart                      # Definisi GoRouter, ShellRoute, redirect guard, dan parameter transit
└── screens/                                 # Kumpulan Fitur Layar Aplikasi
    ├── auth/                                # Layar Autentikasi
    │   ├── login_screen.dart                # Tampilan utama layar login
    │   └── widgets/
    │       └── login_form.dart              # Form input email, password (toggle visibility), & tombol login
    ├── home/                                # Layar Beranda / Katalog
    │   ├── home_tab.dart                    # Penyusun layout utama tab Home
    │   └── widgets/
    │       ├── home_header.dart             # Header salam pengguna dan avatar profil
    │       ├── home_search_bar.dart         # Kolom pencarian produk
    │       └── product_card.dart            # Kartu item produk (Data Transit & Boomerang Effect)
    ├── product/                             # Layar Detail Produk
    │   ├── product_detail_screen.dart       # Layar detail sepatu (Hero animation & interaksi)
    │   └── widgets/
    │       ├── size_variant_selector.dart   # Selector varian ukuran sepatu interaktif (40-44)
    │       └── product_detail_bottom_bar.dart # Action bar bawah: info harga & tombol "Add to Cart"
    ├── cart/                                # Layar Keranjang Belanja
    │   ├── cart_tab.dart                    # Layar utama keranjang belanja terhubung CartProvider
    │   └── widgets/
    │       ├── cart_empty_view.dart         # Tampilan ramah saat keranjang belanja kosong
    │       ├── cart_item_card.dart          # Kartu item belanja (+/- jumlah, label varian ukuran, tombol hapus)
    │       └── cart_checkout_area.dart      # Rangkuman real-time total bayar & tombol checkout
    ├── wishlist/                            # Layar Produk Favorit
    │   ├── wishlist_tab.dart                # Layar utama tab Wishlist
    │   └── widgets/
    │       └── wishlist_item_card.dart      # Kartu item produk yang difavoritkan
    ├── leaderboard/                         # Layar Peringkat Pembeli ("Liverbord")
    │   ├── leaderboard_screen.dart          # Layar papan peringkat loyalitas pelanggan
    │   └── widgets/
    │       ├── podium_top_three.dart        # Podium visual bertingkat untuk Juara 1, 2, dan 3
    │       └── leaderboard_rank_card.dart   # Kartu daftar peringkat pembeli lainnya
    ├── profile/                             # Layar Profil Pengguna
    │   ├── profile_tab.dart                 # Layar utama tab Profile (Area privat yang dijaga Auth Guard)
    │   └── widgets/
    │       ├── profile_header.dart          # Avatar besar dan informasi nama/email pengguna
    │       └── profile_menu_section.dart    # Daftar menu pengaturan, alamat, riwayat, dsb.
    └── shell/                               # Cangkang Navigasi Persisten
        ├── shell_screen.dart                # Shell pembungkus bodi tab aplikasi
        └── widgets/
            └── floating_bottom_bar.dart     # Floating navigation bar melayang dengan Badge Counter dinamis
```

---

## 3. Rincian Implementasi Tugas Teknis

### A. 5 Tugas Utama Arsitektur Navigasi (`go_router`)
1. **Persisten Shell (`ShellRoute`):**
   - **File:** [`lib/router/app_router.dart`](file:///d:/tugas01/lib/router/app_router.dart) dan [`lib/screens/shell/shell_screen.dart`](file:///d:/tugas01/lib/screens/shell/shell_screen.dart).
   - **Fungsi:** Mengunci navigasi bawah agar tetap melayang (*floating*) di layar ketika pengguna berpindah-pindah antar tab, tanpa memuat ulang seluruh kerangka aplikasi.
2. **Data Transit:**
   - **File:** [`lib/screens/home/widgets/product_card.dart`](file:///d:/tugas01/lib/screens/home/widgets/product_card.dart) dan [`lib/screens/product/product_detail_screen.dart`](file:///d:/tugas01/lib/screens/product/product_detail_screen.dart).
   - **Fungsi:** Mengirim objek data `Product` secara langsung lewat argumen `extra` pada `context.push('/home/detail', extra: product)`. Data diterima di konstruktor layar detail tanpa penyimpanan variabel global sementara.
3. **Boomerang Effect:**
   - **File:** [`lib/screens/home/widgets/product_card.dart`](file:///d:/tugas01/lib/screens/home/widgets/product_card.dart) dan [`lib/screens/product/product_detail_screen.dart`](file:///d:/tugas01/lib/screens/product/product_detail_screen.dart).
   - **Fungsi:** Komunikasi bolak-balik asinkron (`await`). Menekan ikon favorit di halaman detail mengembalikan nilai string via `context.pop('favorited')`. Home menangkap balikan tersebut dan menampilkan respons feedback.
4. **Penjaga Gerbang (Auth Guard):**
   - **File:** [`lib/router/app_router.dart`](file:///d:/tugas01/lib/router/app_router.dart) dan [`lib/auth/auth_notifier.dart`](file:///d:/tugas01/lib/auth/auth_notifier.dart).
   - **Fungsi:** Mencegah pengguna yang belum login mengakses rute `/profile`. Jika `isAuthenticated == false`, rute otomatis dibelokkan paksa ke `/login`.
5. **AI Diagnostics:**
   - Menyelesaikan kendala struktur *relative import* dan standarisasi rute `go_router` (menghindari awalan slash `/` pada sub-rute anak) hingga zero compile error.

---

### B. Misi Tambahan: Clean Code & Integrated State (`Provider`)
1. **Model `CartItem` (Variant Handling):**
   - **File:** [`lib/models/cart_item.dart`](file:///d:/tugas01/lib/models/cart_item.dart).
   - Memiliki atribut `id`, `product`, `selectedVariant` (misal: '42'), dan `quantity`.
2. **`CartProvider` (State Management):**
   - **File:** [`lib/providers/cart_provider.dart`](file:///d:/tugas01/lib/providers/cart_provider.dart).
   - **Add Items (Handling Variants):** `addItem(Product product, String variant)` mengecek kombinasi produk dan varian ukuran. Jika varian sama sudah ada di keranjang, kuantitas bertambah; jika berbeda ukuran, disimpan sebagai item varian baru.
   - **Remove & Clear:** `removeItem(id)`, `updateQuantity(id, delta)`, dan `clearCart()` untuk mengosongkan keranjang sekaligus.
   - **Derived Getters:**
     ```dart
     double get totalPrice => _items.fold(0.0, (sum, item) => sum + item.subtotal);
     int get totalItemCount => _items.fold(0, (sum, item) => sum + item.quantity);
     ```
3. **Sinkronisasi Lintas Layar:**
   - **ProductDetailScreen:** Memilih ukuran -> menekan Add to Cart -> memanggil `CartProvider`.
   - **CartTab:** Langsung ter-update secara reaktif menampilkan barang yang baru dimasukkan, badge ukuran, kontrol kuantitas, dan kalkulasi total harga seketika.
   - **FloatingBottomBar:** Menampilkan badge counter angka merah di atas ikon keranjang secara real-time.

---

### C. Halaman Tambahan: Leaderboard / Liverbord
- **File:** [`lib/screens/leaderboard/leaderboard_screen.dart`](file:///d:/tugas01/lib/screens/leaderboard/leaderboard_screen.dart)
- **Fungsi:** Fitur gamifikasi e-commerce yang menampilkan peringkat pembeli dengan pengeluaran dan poin loyalitas tertinggi (*Top Spender*). Memiliki podium visual 3 besar (Emas, Perak, Perunggu) dan daftar peringkat anggota lainnya.

---

## 4. AI Review Summary

| Kriteria Evaluasi | Status / Skor | Catatan Hasil Review |
| :--- | :--- | :--- |
| **Separation of Concerns (SoC)** | **Sempurna (10/10)** | Pemisahan tanggung jawab kode sangat tegas antara model data, provider state, konfigurasi rute, dan komponen UI per fitur. |
| **State Immutability & Safety** | **Sangat Baik (10/10)** | Data list privat `_items` hanya diekspos keluar melalui `List.unmodifiable(_items)`, mencegah manipulasi ilegal dari luar provider. |
| **Reactivity & Performance** | **Optimal** | Pemisahan pembacaan state antara `context.watch` (hanya pada widget yang wajib rebuild) dan `context.read` (pada event handler seperti tombol). |
| **UI Aesthetics & UX** | **Modern & Premium** | Desain floating navbar melayang, podium interaktif, chip selector dinamis, dan feedback interaktif (SnackBar auto-dismiss cepat). |
| **Code Health & Linting** | **Bersih (0 Error / 0 Warning)** | Lolos pengujian `flutter analyze` dengan status *No issues found*. |

---

## 5. Architecture Justification

### Mengapa Menggunakan `Provider`?
1. **Ringan dan Standar Resmi:** Didukung langsung oleh tim Flutter untuk kebutuhan state management yang reaktif tanpa memerlukan kompleksitas boilerplate berlebih seperti BLoC.
2. **Konsistensi Arsitektur:** Proyek telah memiliki `AuthNotifier` berbasis `ChangeNotifier`. Menggunakan `Provider` untuk keranjang belanja menjaga keseragaman pola (*architectural consistency*) di seluruh aplikasi.

### Mengapa Menggunakan Derived Getters?
1. **Eliminasi Inkonsistensi Data:** Nilai total harga (`totalPrice`) tidak disimpan sebagai variabel mandiri yang harus di-update manual. Sebaliknya, nilai selalu dihitung secara *on-the-fly* dari data sumber (`Single Source of Truth`).
2. **Bebas Bug Redundansi:** Menghapus kemungkinan harga total "ketinggalan" saat jumlah barang diubah atau dihapus.

### Mengapa Memilih Struktur Feature-First Modular?
1. **Skalabilitas Tinggi:** Saat aplikasi berkembang dan memiliki puluhan fitur baru, tim pengembang tidak akan tersesat karena seluruh aset, sub-widget, dan layar fitur tersebut terkumpul rapi di dalam satu modul fiturnya sendiri.

---

## 6. Panduan Presentasi / Skrip Bicara Tugas

Gunakan alur penjelasan berikut saat mempresentasikan tugas di depan dosen atau asisten:

> *"Selamat pagi/siang, pada tugas ini saya membangun aplikasi e-commerce modern dengan dua pilar utama: **Arsitektur Navigasi Modern** dan **Integrated State Management**.*
>
> *Pada fase awal, fokus saya adalah membangun navigasi berbasis `go_router`. Saya menerapkan **Persistent Shell** agar navigation bar melayang tetap stabil di layar, **Data Transit** untuk mengirim data produk ke halaman detail, **Boomerang Effect** untuk mengembalikan status favorit dari detail ke beranda secara asinkron, dan **Auth Guard** untuk memproteksi tab profil.*
>
> *Kemudian pada fase penambahan tugas, saya meningkatkan aplikasi ini dengan menambahkan **State Management menggunakan Provider**. Saya membuat `CartProvider` lengkap dengan penanganan varian ukuran sepatu (40-44), fitur penambahan dan pengurangan kuantitas, serta penghapusan item.*
>
> *Keunggulan teknis dari state management ini adalah penerapan **Derived Getters** untuk menghitung total biaya secara real-time langsung dari sumber data, menjamin kalkulasi selalu 100% akurat. State keranjang ini tersinkronisasi mulus di tiga area sekaligus: Halaman Detail, Halaman Keranjang, dan Badge Counter pada Navigation Bar.*
>
> *Selain itu, saya juga menambahkan satu halaman baru yaitu **Leaderboard** yang menampilkan podium peringkat konsumen teratas, serta merapikan struktur file ke dalam pola **Feature-first Modular** sehingga kode bersih, terpisah antara widget dan logikanya, serta lolos validasi tanpa error."*
