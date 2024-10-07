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
            $table->decimal('price');
            $table->string('no_wa');
            $table->string('email');
            $table->text('pesan');
            $table->string('metode_bayar');
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
