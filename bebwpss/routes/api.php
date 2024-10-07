<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\WakafController;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');


// grup api version 1
Route::group(['prefix' => 'v1'], function () {
    Route::resource('/wakaf', WakafController::class)->only(['index', 'show', 'store', 'update', 'destroy']);
});

