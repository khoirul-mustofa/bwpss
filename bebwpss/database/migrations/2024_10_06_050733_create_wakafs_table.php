<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('wakafs', function (Blueprint $table) {
            $table->id();
            $table->string('nama_lengkap');
            $table->string('sapaan');
            $table->string('category_wakaf');
            $table->double('price');
            $table->string('no_wa');
            $table->string('email');
            $table->text('pesan');
            $table->string('metode_bayar');
            $table->enum('status_payment', [
                'pending',        // Status awal saat pembayaran baru dibuat
                'settlement',     // Ketika pembayaran berhasil
                'capture',        // Ketika pembayaran berhasil di-capture
                'deny',           // Ketika pembayaran ditolak
                'cancel',         // Ketika pembayaran dibatalkan
                'expire',         // Ketika pembayaran kedaluwarsa
                'refund',         // Ketika pembayaran dikembalikan
                'partial_refund', // Ketika pembayaran dikembalikan sebagian
                'failure'         // Ketika pembayaran gagal
            ])->default('pending');
            $table->string('fcm_token');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('wakafs');
    }
};
