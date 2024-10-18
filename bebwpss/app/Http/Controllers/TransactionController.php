<?php

namespace App\Http\Controllers;

use Midtrans\Snap;
use Midtrans\Config;
use App\Models\Transaction;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TransactionController extends Controller
{
    public function __construct()
    {
        Config::$serverKey    = config('services.midtrans.serverKey');
        Config::$isProduction = config('services.midtrans.isProduction');
        Config::$isSanitized  = config('services.midtrans.isSanitized');
        Config::$is3ds        = config('services.midtrans.is3ds');
    }

    public function pay(Request $request)
    {
        $validated = $request->validate([
            'name'   => 'required|string|max:255',
            'email'  => 'required|email|max:255',
            'amount' => 'required|numeric|min:1000',
            'note'   => 'nullable|string|max:500',
        ]);

        try {
            // Transaksi database
            $snapToken = DB::transaction(function () use ($validated) {
                $donation = Transaction::create([
                    'code'   => 'TRANSACTION-' . mt_rand(100000, 999999),
                    'name'   => $validated['name'],
                    'email'  => $validated['email'],
                    'amount' => $validated['amount'],
                    'note'   => $validated['note'] ?? null,
                ]);

                $payload = [
                    'transaction_details' => [
                        'order_id'     => $donation->code,
                        'gross_amount' => $donation->amount,
                    ],
                    'customer_details' => [
                        'first_name' => $donation->name,
                        'email'      => $donation->email,
                    ],
                    'item_details' => [[
                        'id'            => $donation->code,
                        'price'         => $donation->amount,
                        'quantity'      => 1,
                        'name'          => 'Donation to ' . config('app.name'),
                        'brand'         => 'Donation',
                        'category'      => 'Donation',
                        'merchant_name' => config('app.name'),
                    ]],
                ];

                $snapToken = Snap::getSnapToken($payload);
                $donation->update(['snap_token' => $snapToken]);

                return $snapToken;
            });

            return response()->json([
                'status'     => 'success',
                'snap_token' => $snapToken,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status'  => 'error',
                'message' => 'Payment process failed.',
                'error'   => $e->getMessage(),
            ], 500);
        }
    }
}
