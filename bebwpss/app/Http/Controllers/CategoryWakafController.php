<?php

namespace App\Http\Controllers;

use App\Helpers\ResponseHelper;
use App\Http\Controllers\Controller;
use App\Models\CategoryWakaf;
use Illuminate\Http\Request;

class CategoryWakafController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            $category = CategoryWakaf::all();
            return ResponseHelper::success($category);
        } catch (\Throwable $th) {
            return ResponseHelper::error($th->getMessage());
        }
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try {
            $request->validate([
                'name' => 'required',
                'image' => 'required',
                'target_amount' => 'required',
            ]);
            $category = CategoryWakaf::create($request->all());
            return ResponseHelper::success($category);
        } catch (\Throwable $th) {
            return ResponseHelper::error($th->getMessage());
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(CategoryWakaf $categoryWakaf)
    {
        try {
            //code...
            return ResponseHelper::success($categoryWakaf);
        } catch (\Throwable $th) {
            //throw $th;
            return ResponseHelper::error($th->getMessage());
        }
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(CategoryWakaf $categoryWakaf)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, CategoryWakaf $categoryWakaf)
    {
        try {
            $request->validate([
                'name' => 'required',
                'image' => 'required'
            ]);
            $categoryWakaf = CategoryWakaf::find($categoryWakaf->id);

            if (!$categoryWakaf) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Category not found',
                    'data' => null,
                    'errors' => [],
                ], 404);
            }

            $categoryWakaf->update($request->all());

            return ResponseHelper::success($categoryWakaf);
        } catch (\Throwable $th) {
            return ResponseHelper::error($th->getMessage());
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(CategoryWakaf $categoryWakaf)
    {
        try {
            $categoryWakaf->delete();
            return response()->json([
                'status' => 'success',
                'message' => 'Category deleted successfully',
                'errors' => null
            ], 200);
        } catch (\Throwable $th) {
            return ResponseHelper::error($th->getMessage());
        }
    }
}
