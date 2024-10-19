<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('pay.pay');
});
Route::get('/wakaf', function () {
    $wakaf = \App\Models\Wakaf::all();
    return view('wakaf', compact('wakaf'));
});

// PUT route untuk update wakaf
Route::put('/wakaf/{wakaf}', function (\App\Models\Wakaf $wakaf) {
    $wakaf->update(request()->validate([
        'nama_lengkap' => 'required|string|max:255',
        'sapaan' => 'required|string|max:255',
        'category_wakaf' => 'required|string|max:255',
        'price' => 'required|numeric',
        'no_wa' => 'required|string|max:255',
        'email' => 'required|email',
        'pesan' => 'nullable|string|max:500',
        'metode_bayar' => 'required|string|max:255',
    ]));

    return redirect('/wakaf')->with('success', 'Data wakaf berhasil diperbarui.');
});

// DELETE route untuk hapus wakaf
Route::delete('/wakaf/{wakaf}', function (\App\Models\Wakaf $wakaf) {
    $wakaf->delete();
    return redirect('/wakaf')->with('success', 'Data wakaf berhasil dihapus.');
});
