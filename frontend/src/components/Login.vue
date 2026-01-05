<template>
    <div class="login-container">
      <div class="container">
        <div class="row justify-content-center align-items-center min-vh-100">
          <div class="col-md-6 col-lg-4">
            <div class="card login-card">
              <div class="card-header text-center">
                <i class="bi bi-shield-lock-fill fs-1 text-warning mb-2"></i>
                <h4>Login Admin</h4>
              </div>
              <div class="card-body">
                <form @submit.prevent="handleLogin">
                  <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" v-model="email" required placeholder="Masukkan email Anda">
                  </div>
                  <div class="mb-4">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" v-model="password" required placeholder="Masukkan password Anda">
                  </div>
                  <button type="submit" class="btn btn-primary w-100">Login</button>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import { mapActions } from 'vuex';
  
  export default {
    data() {
      return {
        email: '',
        password: '',
      };
    },
    methods: {
      ...mapActions(['loginAdmin']),
      async handleLogin() {
        try {
          const success = await this.loginAdmin({
            email: this.email,
            password: this.password,
          });
          if (success) {
            this.$router.push('/dashboard');
          }
        } catch (error) {
          console.error('Login failed:', error);
          // Handle undefined error.response
          if (error.response && error.response.data && error.response.data.message) {
            alert(error.response.data.message);
          } else if (error.message) {
            alert(error.message);
          } else {
            alert('Login gagal. Periksa koneksi atau pastikan server berjalan.');
          }
        }
      },
    },
  };
  </script>
  