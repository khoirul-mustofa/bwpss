<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

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
        'order_id',
        'status_payment',
        'fcm_token',
    ];


    public function category(): BelongsTo
    {
        return $this->belongsTo(CategoryWakaf::class, 'category_wakaf');
    }
}
