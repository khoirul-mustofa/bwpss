<?php

use App\Http\Controllers\CategoryWakafController;
use App\Http\Controllers\MidtransController;
use App\Http\Controllers\TransactionController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\WakafController;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');


// grup api version 1
Route::group(['prefix' => 'v1'], function () {
    Route::resource('/wakaf', WakafController::class)->only(['index', 'show', 'store', 'update', 'destroy']);
    Route::resource('/category_wakaf', CategoryWakafController::class)->only(['index', 'show', 'store', 'update', 'destroy']);

    Route::get('/total-price-by-category/{categoryId}', [WakafController::class, 'totalPriceByCategory'])->name('totalPriceByCategory');

    Route::post('/pay', [TransactionController::class, 'pay'])->name('pay');



    Route::post('/midtrans/charge', [MidtransController::class, 'charge']);
    Route::get('/midtrans/status/{orderId}', [MidtransController::class, 'transactionStatus']);
    Route::match(['post', 'get'], '/midtrans/webhook', [MidtransController::class, 'handleWebhook']);
});
