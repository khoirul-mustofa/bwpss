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
            $wakaf = Wakaf::all();
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
            $wakaf = Wakaf::create($request->all());
            return ResponseHelper::success($wakaf);
        } catch (\Throwable $th) {
            return ResponseHelper::error($th->getMessage());
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(Wakaf $wakaf)
    {
        $response = [
            "id" => $wakaf->id,
            "nama_lengkap" => $wakaf->nama_lengkap,
            "sapaan" => $wakaf->sapaan,
            "category_wakaf" => $wakaf->category->name,
            "price" => $wakaf->price,
            "no_wa" => $wakaf->no_wa,
            "email" => $wakaf->email,
            "pesan" => $wakaf->pesan,
            "metode_bayar" => $wakaf->metode_bayar,
            "fcm_token" => $wakaf->fcm_token,

        ];

        return ResponseHelper::success($response);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Wakaf $wakaf)
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
    public function destroy(Wakaf $wakaf)
    {
        try {
            $wakaf->delete();
            return response()->json([
                'status' => 'success',
                'message' => 'Wakaf deleted successfully',
                'errors' => null
            ], 200);
        } catch (\Throwable $th) {
            return ResponseHelper::error($th->getMessage());
        }
    }

    public function totalPriceByCategory($categoryId)
    {

        try {
            $response = ['total_amount' =>  Wakaf::where('category_wakaf', $categoryId)->sum('price')];

            return ResponseHelper::success($response);
        } catch (\Throwable $th) {
            return ResponseHelper::error($th->getMessage());
        }
    }
}
