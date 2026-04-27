-- =============================================
-- TUGAS 1: EKSPLORASI DATABASE PERPUSTAKAAN
-- Nama  : Surya Ardhiartha Putro Utomo
-- NIM   : 60324038
-- =============================================

-- ===== BAGIAN 1: STATISTIK BUKU =====

-- 1. Total buku seluruhnya
SELECT COUNT(*) as total_buku FROM buku;

-- 2. Total nilai inventaris (harga × stok)
SELECT SUM(harga * stok) as total_nilai_inventaris FROM buku;

-- 3. Rata-rata harga buku
SELECT AVG(harga) as rata_rata_harga FROM buku;

-- 4. Buku termahal (tampilkan judul dan harga)
SELECT judul, harga FROM buku 
ORDER BY harga DESC 
LIMIT 1;

-- 5. Buku dengan stok terbanyak
SELECT judul, stok FROM buku 
ORDER BY stok DESC 
LIMIT 1;

-- ===== BAGIAN 2: FILTER DAN PENCARIAN (5 QUERY) =====

-- 6. Buku kategori Programming harga < 100.000
SELECT * FROM buku 
WHERE kategori = 'Programming' AND harga < 100000;

-- 7. Buku judulnya mengandung "PHP" atau "MySQL"
SELECT * FROM buku 
WHERE judul LIKE '%PHP%' OR judul LIKE '%MySQL%';

-- 8. Buku terbit tahun 2024
SELECT * FROM buku WHERE tahun_terbit = 2024;

-- 9. Buku stoknya antara 5-10
SELECT * FROM buku WHERE stok BETWEEN 5 AND 10;

-- 10. Buku pengarangnya "Budi Raharjo"
SELECT * FROM buku WHERE pengarang = 'Budi Raharjo';

-- ===== BAGIAN 3: GROUPING DAN AGREGASI (3 QUERY) =====

-- 11. Jumlah buku per kategori dengan total stok
SELECT 
    kategori, 
    COUNT(*) as jumlah_buku,
    SUM(stok) as total_stok
FROM buku 
GROUP BY kategori;

-- 12. Rata-rata harga per kategori
SELECT 
    kategori,
    AVG(harga) as rata_rata_harga
FROM buku 
GROUP BY kategori;

-- 13. Kategori dengan total nilai inventaris terbesar
SELECT 
    kategori,
    SUM(harga * stok) as total_nilai_inventaris
FROM buku 
GROUP BY kategori
ORDER BY total_nilai_inventaris DESC
LIMIT 1;

-- ===== BAGIAN 4: UPDATE DATA (2 QUERY) =====

-- Cek dulu sebelum update
SELECT judul, kategori, harga FROM buku WHERE kategori = 'Programming';
SELECT judul, stok FROM buku WHERE stok < 5;

-- Jalankan jika datanya sudah benar
-- 14. Naikkan harga buku Programming sebesar 5%
UPDATE buku 
SET harga = harga * 1.05 
WHERE kategori = 'Programming';

-- Verifikasi
SELECT judul, kategori, harga FROM buku WHERE kategori = 'Programming';

-- 15. Tambah stok 10 untuk buku yang stoknya < 5
UPDATE buku 
SET stok = stok + 10 
WHERE stok < 5;

-- Verifikasi
SELECT judul, stok FROM buku WHERE stok < 15;

-- ===== BAGIAN 5: LAPORAN KHUSUS (2 QUERY) =====

-- 16. Daftar buku yang perlu restocking (stok < 5)
SELECT 
    kode_buku,
    judul,
    kategori,
    stok,
    'Perlu Restocking' as keterangan
FROM buku 
WHERE stok < 5
ORDER BY stok ASC;

-- 17. Top 5 buku termahal
SELECT 
    judul,
    pengarang,
    kategori,
    CONCAT('Rp ', FORMAT(harga, 0)) as harga
FROM buku 
ORDER BY harga DESC 
LIMIT 5;
