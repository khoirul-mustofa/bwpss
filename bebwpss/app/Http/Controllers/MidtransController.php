<?php

namespace App\Http\Controllers;

use App\Models\Wakaf;
use Carbon\Carbon;
use Midtrans\Config;
use Midtrans\CoreApi;
use Midtrans\Transaction;
use Illuminate\Http\Request;

class MidtransController extends Controller
{
    public function __construct()
    {
        Config::$serverKey = config('services.midtrans.serverKey');
        Config::$isProduction = config('services.midtrans.isProduction');
    }

    public function charge(Request $request)
    {
        $params = [];
        $orderId = 'WAKAF-' . Carbon::now()->format('YmdHis') . '-' . uniqid();

        switch ($request->bank) {
            case 'mandiri':
                $params = [
                    'payment_type' => 'echannel',
                    'transaction_details' => [
                        'order_id' => $orderId,
                        'gross_amount' => $request->amount,
                    ],
                    'customer_details' => [
                        'first_name' => $request->first_name,
                        'last_name' => $request->last_name,
                        'email' => $request->email,
                        'phone' => $request->phone,
                    ],

                    'bank_transfer' => [
                        'bank' => $request->bank,
                    ],
                    'echannel' => [
                        "bill_info1" => "Payment:",
                        "bill_info2" => "Online purchase"
                    ],
                ];
                break;

            case 'permata':
                $params = [
                    'payment_type' => 'permata',
                    'transaction_details' => [
                        'order_id' => $orderId,
                        'gross_amount' => $request->amount,
                    ],
                    'customer_details' => [
                        'first_name' => $request->first_name,
                        'last_name' => $request->last_name,
                        'email' => $request->email,
                        'phone' => $request->phone,
                    ],
                ];

                break;

            case 'bca':
                $params = [
                    'payment_type' => 'bank_transfer',
                    'transaction_details' => [
                        'order_id' => $orderId,
                        'gross_amount' => $request->amount,
                    ],
                    'customer_details' => [
                        'email' => $request->email,
                        'phone' => $request->phone,
                    ],

                    'bank_transfer' => [
                        'bank' => $request->bank,
                    ],
                ];
                break;

            default:

                if ($request->bank == 'qris') {
                    $params = [
                        'payment_type' => 'gopay',
                        'transaction_details' => [
                            'order_id' => $orderId,
                            'gross_amount' => $request->amount,
                        ],

                    ];
                } else if ($request->bank == 'cstore') {
                    $params = [
                        'payment_type' => 'cstore',
                        'transaction_details' => [
                            'order_id' => $orderId,
                            'gross_amount' => $request->amount,
                        ],
                        "cstore" => [
                            "store" => "alfamart",
                            "message" => "Message ",
                            "alfamart_free_text_1" => "1st row of receipt,",
                            "alfamart_free_text_2" => "This is the 2nd row,",
                            "alfamart_free_text_3" => "3rd row. The end."
                        ],
                    ];
                } else {
                }
                break;
        }

        try {
            Wakaf::create([
                'order_id' => $orderId,
                'metode_bayar' => $request->bank,
                'fcm_token' => $request->fcm_token,
                'status_payment' => 'pending',
                'nama_lengkap' => $request->nama_lengkap,
                'sapaan' => $request->sapaan,
                'category_wakaf' => $request->category_wakaf,
                'price' => $request->amount,
                'no_wa' => $request->phone,
                'email' => $request->email,
                'pesan' => $request->pesan,

            ])->save();
            // Proses pembayaran menggunakan Core API
            $payment = CoreApi::charge($params);

            return response()->json($payment);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function transactionStatus($orderId)
    {
        try {
            $status = Transaction::status($orderId);
            return response()->json($status);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function handleWebhook(Request $request)
    {
        $notification = $request->all();

        // Pastikan signature key cocok untuk verifikasi
        $calculatedSignatureKey = hash('sha512', $notification['order_id'] . $notification['status_code'] . $notification['gross_amount'] . config('midtrans.server_key'));

        if ($notification['signature_key'] === $calculatedSignatureKey) {
            // Lakukan tindakan berdasarkan status pembayaran
            if ($notification['transaction_status'] === 'settlement') {
                // Pembayaran berhasil
                // Update status pembayaran di database



            } elseif ($notification['transaction_status'] === 'expire') {
                // Transaksi expired
            } elseif ($notification['transaction_status'] === 'cancel' || $notification['transaction_status'] === 'deny') {
                // Pembayaran ditolak atau dibatalkan
            }

            return response()->json(['message' => 'Notification received successfully']);
        } else {
            return response()->json(['error' => 'Invalid signature key'], 403);
        }
    }
}
