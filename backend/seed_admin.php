<?php

// seed_admin.php
// Jalankan: php seed_admin.php

require_once 'vendor/autoload.php';

$app = require_once 'bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\User;
use Illuminate\Support\Facades\Hash;

// Hapus user admin lama jika ada
User::where('email', 'admin@gmail.com')->delete();

// Buat user admin baru dengan password plain
// Laravel akan otomatis menghash-nya karena ada casts pada model
User::create([
    'name' => 'Admin User',
    'email' => 'admin@gmail.com',
    'password' => 'admin123', // Password plain, akan di-hash otomatis
]);

echo "Admin user created successfully!\n";
echo "Email: admin@gmail.com\n";
echo "Password: admin123\n";

