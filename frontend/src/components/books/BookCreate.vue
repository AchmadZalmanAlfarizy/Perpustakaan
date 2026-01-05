<template>
  <div class="container mt-5">
    <h2>Tambah Buku</h2>

    <form @submit.prevent="createBook">
      <div class="mb-3">
        <label for="title" class="form-label">Judul</label>
        <input type="text" class="form-control" id="title" v-model="book.title" required>
      </div>
      <div class="mb-3">
        <label for="author" class="form-label">Penulis</label>
        <input type="text" class="form-control" id="author" v-model="book.author" required>
      </div>
      <div class="mb-3">
        <label for="publisher" class="form-label">Penerbit</label>
        <input type="text" class="form-control" id="publisher" v-model="book.publisher" required>
      </div>
      <div class="mb-3">
        <label for="category" class="form-label">Kategori</label>
        <select class="form-select" id="category" v-model="book.category_id" required>
          <option value="" disabled>Pilih Kategori</option>
          <option v-for="category in categories" :key="category.id" :value="category.id">
            {{ category.name }}
          </option>
        </select>
      </div>
      <div class="mb-3">
        <label for="stock" class="form-label">Stok</label>
        <input type="number" class="form-control" id="stock" v-model="book.stock" required min="1" max="10">
      </div>
      
      <!-- Book Cover Upload -->
      <div class="mb-3">
        <label for="book_cover" class="form-label">Cover Buku</label>
        <input 
          type="file" 
          class="form-control" 
          id="book_cover" 
          @change="handleFileUpload"
          accept="image/jpeg,image/png,image/jpg,image/gif,image/webp"
        >
        <small class="form-text text-muted">Format yang didukung: JPEG, PNG, JPG, GIF, WebP. Maksimal 10MB.</small>
        
        <!-- Preview Image -->
        <div v-if="previewImage" class="mt-3">
          <div class="preview-container">
            <img :src="previewImage" alt="Preview" class="preview-image">
            <button type="button" class="btn btn-sm btn-danger remove-preview" @click="removePreview">
              <i class="fas fa-times"></i>
            </button>
          </div>
        </div>
      </div>
      
      <button type="submit" class="btn btn-primary">Simpan</button>
      <router-link :to="{ name: 'BookList' }" class="btn btn-secondary ms-2">Kembali</router-link>
    </form>
  </div>
</template>

<script>
import api from '../../services/api';

export default {
  data() {
    return {
      book: {
        title: '',
        author: '',
        publisher: '',
        category_id: '',
        stock: '',
      },
      categories: [],
      bookCoverFile: null,
      previewImage: null,
    };
  },
  async created() {
    await this.fetchCategories();
  },
  methods: {
    async fetchCategories() {
      try {
        const response = await api.get('/categories');
        this.categories = response.data;
      } catch (error) {
        console.error('Error fetching categories:', error);
      }
    },
    async createBook() {
      try {
        const formData = new FormData();
        
        // Append book data
        Object.keys(this.book).forEach(key => {
          formData.append(key, this.book[key]);
        });
        
        // Append book cover if selected
        if (this.bookCoverFile) {
          formData.append('book_cover', this.bookCoverFile);
        }
        
        await api.post('/books', formData, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
        });
        
        this.$router.push({ name: 'BookList' }); 
      } catch (error) {
        console.error('Error creating book:', error);
        if (error.response && error.response.status === 400) {
          alert(error.response.data.message || 'Validation error');
        } else {
          alert('An error occurred while creating the book');
        }
      }
    },
    handleFileUpload(event) {
      const file = event.target.files[0];
      if (file) {
        // Validate file size (10MB)
        if (file.size > 10 * 1024 * 1024) {
          alert('File terlalu besar. Maksimal 10MB.');
          event.target.value = '';
          return;
        }
        
        // Validate file type
        const allowedTypes = ['image/jpeg', 'image/png', 'image/jpg', 'image/gif', 'image/webp'];
        if (!allowedTypes.includes(file.type)) {
          alert('Tipe file tidak didukung. Gunakan JPEG, PNG, JPG, GIF, atau WebP.');
          event.target.value = '';
          return;
        }
        
        this.bookCoverFile = file;
        
        // Create preview
        const reader = new FileReader();
        reader.onload = (e) => {
          this.previewImage = e.target.result;
        };
        reader.readAsDataURL(file);
      }
    },
    removePreview() {
      this.bookCoverFile = null;
      this.previewImage = null;
      // Clear the file input
      const fileInput = document.getElementById('book_cover');
      if (fileInput) {
        fileInput.value = '';
      }
    },
  },
};
</script>

<style scoped>
.preview-container {
  position: relative;
  display: inline-block;
  max-width: 200px;
}

.preview-image {
  width: 100%;
  height: auto;
  max-height: 250px;
  object-fit: cover;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.remove-preview {
  position: absolute;
  top: -8px;
  right: -8px;
  width: 24px;
  height: 24px;
  border-radius: 50%;
  padding: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
}
</style>