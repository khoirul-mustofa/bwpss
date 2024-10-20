<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CategoryWakaf extends Model
{
    /** @use HasFactory<\Database\Factories\CategoryWakafFactory> */


    use HasFactory;

    protected $fillable = ['name', 'image', 'target_amount', 'location'];
}
