<?php

namespace Tests\Feature;

use App\Models\Wakaf;
use Database\Factories\WakafFactory;
use Tests\TestCase;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Foundation\Testing\RefreshDatabase;

class WakafApiTest extends TestCase
{
    use RefreshDatabase;

    #[\PHPUnit\Framework\Attributes\Test]
    public function it_can_get_all_wakaf()
    {
        Wakaf::factory()->count(3)->create();

        $response = $this->getJson('/api/v1/wakaf');

        $response->assertStatus(200)
                 ->assertJsonStructure([
                     'status',
                     'message',
                     'data' => [
                         '*' => [
                             'id',
                             'nama_lengkap',
                             'category_wakaf',
                             'price',
                             'no_wa',
                             'email',
                             'pesan',
                             'metode_bayar',
                             'fcm_token',
                         ]
                     ],
                     'errors'
                 ]);
    }

    #[\PHPUnit\Framework\Attributes\Test]
    public function it_can_create_a_wakaf()
    {
        $data = [
            'nama_lengkap' => 'John Doe',
            'sapaan' => 'bapak',
            'category_wakaf' => 'pendidikan',
            'price' => 100000,
            'no_wa' => '081234567890',
            'email' => 'johndoe@example.com',
            'pesan' => 'Semoga berkah.',
            'metode_bayar' => 'transfer',
            'fcm_token' => 'dummy_fcm_token',
        ];

        $response = $this->postJson('/api/v1/wakaf', $data);

        $response->assertStatus(200)
                 ->assertJson([
                     'status' => 'success',
                     'data' => $data,
                     'errors' => null
                 ]);

        $this->assertDatabaseHas('wakafs', $data);
    }

    #[\PHPUnit\Framework\Attributes\Test]
    public function it_can_show_a_wakaf()
    {
        $wakaf = Wakaf::factory()->create();

        $response = $this->getJson("/api/v1/wakaf/{$wakaf->id}");

        $response->assertStatus(200)
                 ->assertJson([
                     'status' => 'success',
                     'data' => [
                         'id' => $wakaf->id,
                         'nama_lengkap' => $wakaf->nama_lengkap,
                         'category_wakaf' => $wakaf->category_wakaf,
                         'price' => $wakaf->price,
                         'no_wa' => $wakaf->no_wa,
                         'email' => $wakaf->email,
                         'pesan' => $wakaf->pesan,
                         'metode_bayar' => $wakaf->metode_bayar,
                         'fcm_token' => $wakaf->fcm_token,
                     ],
                     'errors' => null
                 ]);
    }

    #[\PHPUnit\Framework\Attributes\Test]
    public function it_can_update_a_wakaf()
    {

        $wakaf = Wakaf::factory()->create();

        $data = [
            'nama_lengkap' => 'Jane Doe',
            'sapaan' => 'ibu',
            'category_wakaf' => 'kesehatan',
            'price' => 200000,
            'no_wa' => '081234567891',
            'email' => 'janedoe@example.com',
            'pesan' => 'Semoga sehat selalu.',
            'metode_bayar' => 'e-wallet',
            'fcm_token' => 'new_dummy_fcm_token',
        ];

        $response = $this->putJson("/api/v1/wakaf/{$wakaf->id}", $data);

        $response->assertStatus(200)
                 ->assertJson([
                     'status' => 'success',
                     'data' => $data,
                     'errors' => null
                 ]);

        $this->assertDatabaseHas('wakafs', $data);
    }

    #[\PHPUnit\Framework\Attributes\Test]
    public function it_can_delete_a_wakaf()
    {
        $wakaf = Wakaf::factory()->create();

        $response = $this->deleteJson("/api/v1/wakaf/{$wakaf->id}");

        $response->assertStatus(200)
                 ->assertJson([
                     'status' => 'success',
                     'message' => 'Wakaf deleted successfully',
                     'errors' => null
                 ]);

        $this->assertDatabaseMissing('wakafs', [
            'id' => $wakaf->id,
        ]);
    }
}
