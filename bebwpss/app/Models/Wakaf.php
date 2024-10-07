<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Wakaf extends Model
{
    use HasFactory;

    protected $fillable = [
        'nama_lengkap',
        'sapaan',
        'category_wakaf',
        'price',
        'no_wa',
        'email',
        'pesan',
        'metode_bayar',
        'fcm_token',
    ];
}
