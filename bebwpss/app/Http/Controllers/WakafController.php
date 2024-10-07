<?php

namespace App\Http\Controllers;

use App\Models\Wakaf;
use Illuminate\Http\Request;
use App\Helpers\ResponseHelper;

class WakafController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            $wakaf = wakaf::all();
            return ResponseHelper::success($wakaf);
        } catch (\Throwable $th) {
            //throw $th;
            return ResponseHelper::error($th->getMessage());
        }
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'nama_lengkap' => 'required',
            'sapaan' => 'in:bapak,ibu,kak',
            'category_wakaf' => 'required',
            'price' => 'required',
            'no_wa' => 'required',
            'email' => 'email',
            'pesan' => 'max:500',
            'metode_bayar' => 'required',
            'fcm_token' => 'required',
        ]);

        try {
            $wakaf = wakaf::create($request->all());
            return ResponseHelper::success($wakaf);
        } catch (\Throwable $th) {
            //throw $th;
            return ResponseHelper::error($th->getMessage());
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(wakaf $wakaf)
    {
        return ResponseHelper::success($wakaf);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, wakaf $wakaf)
    {
        try {
            $request->validate([
            'nama_lengkap' => 'required',
            'sapaan' => 'in:bapak,ibu,kak',
            'category_wakaf' => 'required',
            'price' => 'required',
            'no_wa' => 'required',
            'email' => 'email',
            'pesan' => 'max:500',
            'metode_bayar' => 'required',
            'fcm_token' => 'required',
        ]);
            $wakaf = wakaf::find($wakaf->id);

        $wakaf->update($request->all());
        return ResponseHelper::success($wakaf);

        } catch (\Throwable $th) {
            //throw $th;
            return ResponseHelper::error($th->getMessage());
        }


    }


    //


    /**
     * Remove the specified resource from storage.
     */
  public function destroy(wakaf $wakaf)
{
    try {
        $wakaf->delete(); // Hanya hapus tanpa mencari lagi
        return response()->json([
            'status' => 'success',
            'message' => 'Wakaf deleted successfully',
            'errors' => null
        ], 200);
    } catch (\Throwable $th) {
        return ResponseHelper::error($th->getMessage());
    }
}

}
