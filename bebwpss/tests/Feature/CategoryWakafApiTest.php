<?php

namespace Tests\Feature;

use Tests\TestCase;
use App\Models\CategoryWakaf;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Foundation\Testing\RefreshDatabase;

class CategoryWakafApiTest extends TestCase
{
    /**
     * A basic feature test example.
     */
    #[\PHPUnit\Framework\Attributes\Test]

    public function get_all_category(): void
    {
        CategoryWakaf::factory()->count(3)->create();
        $response = $this->getJson('/api/v1/category_wakaf');
        $response->assertStatus(200)->assertJsonStructure([
            'status',
            'message',
            'data' => [
                '*' => [
                    'id',
                    'name',
                    'image'

                ]
            ],
            'errors'
        ]);
    }

    #[\PHPUnit\Framework\Attributes\Test]
    public function create_category_wakaf()
    {
        $data = [
            'name' => 'Bantuan Sertifikasi Tanah Wakaf',
            'image' => 'https://bwpt.or.id/wp-content/uploads/2022/10/langkah-mengurus-sertifikat-tanah-secara-gratis.jpg'
        ];
        $response = $this->postJson('/api/v1/category_wakaf', $data);
        $response->assertStatus(200)->assertJson([
            'status' => 'success',
            'data' => $data,
            'errors' => null
        ]);
    }

    #[\PHPUnit\Framework\Attributes\Test]
    public function show_category_wakaf()
    {
        $category = CategoryWakaf::factory()->create();

        $response = $this->getJson("/api/v1/category_wakaf/{$category->id}");

        $response->assertStatus(200)->assertJson([
            'status' => 'success',
            'data' => [
                'id' => $category->id,
                'name' => $category->name,
                'image' => $category->image,
            ],
            'errors' => null
        ]);
    }

    #[\PHPUnit\Framework\Attributes\Test]
    public function update_category_wakaf()
    {

        $category = CategoryWakaf::factory()->create();

        $data = [
            'name' => 'Category update',
            'image' => 'https://bwpt.or.id/wp-content/uploads/2022/10/langkah-mengurus-sertifikat-tanah-secara-gratis.jpg',
        ];

        $response = $this->putJson("/api/v1/category_wakaf/{$category->id}", $data);

        $response->assertStatus(200)->assertJson([
            'status' => 'success',
            'data' => $data,
            'errors' => null,
        ]);

        $this->assertDatabaseHas('category_wakafs', $data);
    }
}
