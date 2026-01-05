-- =====================================================
-- DATABASE MANAJEMEN PERPUSTAKAAN - SQL SCRIPT FOR XAMPP
-- =====================================================

-- 1. CREATE DATABASE
-- =====================================================
CREATE DATABASE IF NOT EXISTS manajemen_perpustakaan
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_unicode_ci;

USE manajemen_perpustakaan;

-- =====================================================
-- 2. CREATE TABLES
-- =====================================================

-- Tabel Users (untuk Admin dan User)
-- =====================================================
CREATE TABLE IF NOT EXISTS users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    email_verified_at TIMESTAMP NULL,
    password VARCHAR(255) NOT NULL,
    remember_token VARCHAR(100) NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabel Categories (Kategori Buku)
-- =====================================================
CREATE TABLE IF NOT EXISTS categories (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabel Books (Buku)
-- =====================================================
CREATE TABLE IF NOT EXISTS books (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    publisher VARCHAR(255) NOT NULL,
    category_id BIGINT UNSIGNED NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    book_cover VARCHAR(255) NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabel Members (Anggota Perpustakaan)
-- =====================================================
CREATE TABLE IF NOT EXISTS members (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    member_id VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NULL,
    phone_number VARCHAR(255) NULL,
    address TEXT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabel Loans (Peminjaman Buku)
-- =====================================================
CREATE TABLE IF NOT EXISTS loans (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    member_id BIGINT UNSIGNED NOT NULL,
    book_id BIGINT UNSIGNED NOT NULL,
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE NULL,
    fine_amount DECIMAL(8,2) DEFAULT 0.00,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabel Personal Access Tokens (untuk Laravel Sanctum)
-- =====================================================
CREATE TABLE IF NOT EXISTS personal_access_tokens (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    tokenable_type VARCHAR(255) NOT NULL,
    tokenable_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(255) NOT NULL,
    token VARCHAR(64) NOT NULL UNIQUE,
    abilities TEXT NULL,
    last_used_at TIMESTAMP NULL,
    expires_at TIMESTAMP NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 3. INSERT SAMPLE DATA
-- =====================================================

-- Insert Admin User
-- Password: admin123 (bcrypt hash)
-- =====================================================
INSERT INTO users (name, email, password, created_at, updated_at) VALUES
('Admin User', 'admin@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NOW(), NOW());

-- Insert Regular User
-- Password: password (bcrypt hash)
-- =====================================================
INSERT INTO users (name, email, password, created_at, updated_at) VALUES
('John Doe', 'user@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NOW(), NOW());

-- Insert Categories
-- =====================================================
INSERT INTO categories (name, created_at, updated_at) VALUES
('Fiksi', NOW(), NOW()),
('Non-Fiksi', NOW(), NOW()),
('Ilmiah', NOW(), NOW()),
('Sejarah', NOW(), NOW()),
('Teknologi', NOW(), NOW()),
('Pendidikan', NOW(), NOW());

-- Insert Books
-- =====================================================
INSERT INTO books (title, author, publisher, category_id, stock, book_cover, created_at, updated_at) VALUES
('Laskar Pelangi', 'Andrea Hirata', 'Bentang Pustaka', 1, 10, NULL, NOW(), NOW()),
('Dilan 1990', 'Pidi Baiq', 'Pastel Books', 1, 15, NULL, NOW(), NOW()),
('Atomic Habits', 'James Clear', 'Gramedia', 2, 8, NULL, NOW(), NOW()),
('Sapiens', 'Yuval Noah Harari', 'Gramedia', 4, 5, NULL, NOW(), NOW()),
('Pemrograman Web', 'Nina T. M', 'Elex Media', 5, 12, NULL, NOW(), NOW()),
('Matematika Dasar', 'Dr. Budi', 'Universitas Press', 6, 20, NULL, NOW(), NOW());

-- Insert Members
-- =====================================================
INSERT INTO members (name, member_id, email, phone_number, address, created_at, updated_at) VALUES
('Ahmad Fauzi', 'MEM001', 'ahmad@gmail.com', '081234567890', 'Jakarta Selatan', NOW(), NOW()),
('Siti Nurhaliza', 'MEM002', 'siti@gmail.com', '081234567891', 'Jakarta Pusat', NOW(), NOW()),
('Budi Santoso', 'MEM003', 'budi@gmail.com', '081234567892', 'Jakarta Barat', NOW(), NOW());

-- Insert Loans (Peminjaman)
-- =====================================================
INSERT INTO loans (member_id, book_id, borrow_date, due_date, return_date, fine_amount, created_at, updated_at) VALUES
(1, 1, '2025-01-01', '2025-01-08', '2025-01-07', 0.00, NOW(), NOW()),
(2, 2, '2025-01-05', '2025-01-12', NULL, 0.00, NOW(), NOW()),
(3, 3, '2025-01-10', '2025-01-17', '2025-01-20', 30000.00, NOW(), NOW());

-- =====================================================
-- 4. VIEWS (OPTIONAL)
-- =====================================================

-- View untuk melihat daftar peminjaman yang belum dikembalikan
-- =====================================================
CREATE OR REPLACE VIEW v_loans_unreturned AS
SELECT 
    loans.id,
    members.name AS member_name,
    members.member_id,
    books.title AS book_title,
    books.author,
    loans.borrow_date,
    loans.due_date,
    loans.fine_amount
FROM loans
INNER JOIN members ON loans.member_id = members.id
INNER JOIN books ON loans.book_id = books.id
WHERE loans.return_date IS NULL;

-- View untuk statistik perpustakaan
-- =====================================================
CREATE OR REPLACE VIEW v_library_stats AS
SELECT 
    (SELECT COUNT(*) FROM books) AS total_books,
    (SELECT COUNT(*) FROM members) AS total_members,
    (SELECT COUNT(*) FROM loans WHERE return_date IS NULL) AS active_loans,
    (SELECT COUNT(*) FROM loans WHERE return_date IS NULL AND due_date < CURDATE()) AS overdue_loans;

-- =====================================================
-- 5. SAMPLE QUERIES FOR LOGIN
-- =====================================================

-- Query untuk login Admin
-- =====================================================
-- SELECT * FROM users 
-- WHERE email = 'admin@gmail.com' 
-- AND password = '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi';

-- Query untuk login User/Member
-- =====================================================
-- SELECT * FROM users 
-- WHERE email = 'user@gmail.com' 
-- AND password = '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi';

-- =====================================================
-- END OF SQL SCRIPT
-- =====================================================

