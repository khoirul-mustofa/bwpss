<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CategoryWakafSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('category_wakafs')->insert([
            [
                'name' => 'Penembangan SMA Toleransi',
                'image' => 'https://bwpt.or.id/wp-content/uploads/2022/09/SMA-650x350.png',
                'target_amount' => 10000000,
                'location' => 'Jombang JawaTimur',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'Zakat Penghasilan dan Gaji',
                'image' => 'https://bwpt.or.id/wp-content/uploads/2022/11/Ayo-Zakat.png',
                'target_amount' => 2000000,
                'location' => 'Jombang JawaTimur',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'Bantuan Sertifikasi Tanah Wakaf',
                'image' => 'https://bwpt.or.id/wp-content/uploads/2022/10/langkah-mengurus-sertifikat-tanah-secara-gratis.jpg',
                'target_amount' => 2000000,
                'location' => 'Jombang JawaTimur',
                'created_at' => now(),
                'updated_at' => now(),
            ]
        ]);
    }
}
