<?php
use App\Models\Book;
use App\Models\Category;
use Illuminate\Database\Eloquent\Factories\Factory;

class BookFactory extends Factory
{
    protected $model = Book::class;

    public function definition(): array
    {
        return [
            'title' => $this->faker->sentence(3),
            'author' => $this->faker->name(),
            'publisher' => $this->faker->company(),
            'category_id' => Category::inRandomOrder()->first()?->id ?? Category::factory(),
            'stock' => $this->faker->numberBetween(1, 10),
            'book_cover' => $this->faker->imageUrl(),
        ];
    }
}
