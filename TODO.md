# TODO: Ubah Rentang Kolom Stock Field Menjadi 1-10

## Tasks
- [x] Edit frontend/src/components/books/BookEdit.vue: Ubah atribut min="0" menjadi min="1" dan tambah max="10" pada input stock.
- [x] Edit frontend/src/components/books/BookCreate.vue: Ubah atribut min="0" menjadi min="1" dan tambah max="10" pada input stock.
- [x] Edit backend/app/Http/Controllers/BookController.php: Ubah validasi stock dari 'required|integer|min:0' menjadi 'required|integer|min:1|max:10' di store dan update methods.
- [x] Edit backend/database/factories/BookFactory.php: Ubah range di numberBetween dari (1,20) menjadi (1,10).

## Followup Steps
- [x] Jalankan seeder untuk memastikan data sesuai rentang baru. (Seeder berhasil dijalankan, data stock dalam rentang 1-10)
- [ ] Test validasi di frontend dan backend.
