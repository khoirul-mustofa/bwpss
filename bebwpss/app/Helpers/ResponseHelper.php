<?php

namespace App\Helpers;

class ResponseHelper
{
    public static function success($data = [], $message = 'Operation completed successfully')
    {
        return response()->json([
            'status' => 'success',
            'message' => $message,
            'data' => $data,
            'errors' => null
        ]);
    }

    public static function error($message = 'An error occurred', $errors = [])
    {
        return response()->json([
            'status' => 'error',
            'message' => $message,
            'data' => null,
            'errors' => $errors
        ]);
    }
}
