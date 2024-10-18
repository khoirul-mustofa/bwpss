<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class WakafSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('wakafs')->insert([
            [
                'nama_lengkap' => 'Wakaf tanah di wilayah A',
                'sapaan' => 'kak',
                'category_wakaf' => 1,
                'price' => 1000000,
                'no_wa' => 123456789,
                'email' => 'Wakaf tanah di wilayah A',
                'pesan' => 'Wakaf tanah di wilayah A',
                'metode_bayar' => 'Wakaf tanah di wilayah A',
                'fcm_token' => 'Wakaf tanah di wilayah A',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'nama_lengkap' => 'Wakaf tanah di wilayah B',
                'sapaan' => 'kak',
                'category_wakaf' => 1,
                'price' => 2000000,
                'no_wa' => 123456789,
                'email' => 'Wakaf tanah di wilayah b',
                'pesan' => 'Wakaf tanah di wilayah B',
                'metode_bayar' => 'Wakaf tanah di wilayah B',
                'fcm_token' => 'Wakaf tanah di wilayah B',
                'created_at' => now(),
                'updated_at' => now(),
            ]

        ]);
    }
}
