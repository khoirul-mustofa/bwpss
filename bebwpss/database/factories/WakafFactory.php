<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\Wakaf;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Wakaf>
 */
class WakafFactory extends Factory
{
    protected $model = Wakaf::class;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition()
    {
        return [
            'nama_lengkap' => $this->faker->name,
            'sapaan' => $this->faker->randomElement(['bapak', 'ibu', 'kak']),
            'category_wakaf' => $this->faker->word,
            'price' => $this->faker->numberBetween(1000, 100000),
            'no_wa' => $this->faker->unique()->numerify('08#########'),
            'email' => $this->faker->safeEmail,
            'pesan' => $this->faker->sentence,
            'metode_bayar' => $this->faker->randomElement(['transfer', 'e-wallet']),
            'fcm_token' => $this->faker->uuid,
        ];
    }
}
