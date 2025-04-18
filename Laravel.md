# Laravel Cheat Sheet

## Choose Laravel Version
Create a new Laravel project with a specific version:
```bash
composer create-project laravel/laravel="5.1.*" myProject
```

## Create via docker container

```bash
docker run --rm -v "$(pwd):/app" -w /app felipesms/liga:1.0 bash -c "composer create-project laravel/laravel folder && mv folder/* folder/.* /app 2>/dev/null || true && rmdir folder && chmod -R 777 /app"
```



## Install Laravel Breeze
For a simple authentication setup:
```bash
composer require laravel/breeze --dev
php artisan breeze:install
npm install
npm run build
php artisan migrate
```

## Shortcuts
To install a command-line shortcut:
```bash
sudo wget https://raw.githubusercontent.com/felipesms2/Laravel-CheatSheet/main/cli-shortcurt -P /usr/bin
sudo mv /usr/bin/cli-shortcurt /usr/bin/lv
sudo chmod +x /usr/bin/lv
```

## Common Artisan Commands

- **Generate model with all components:**
```bash
php artisan make:model table --all
```

## SQLite Support
Configure SQLite as the database connection:
```env
DB_CONNECTION=sqlite
DB_DATABASE=/absolute/path/to/database.sqlite
```
Install Doctrine DBAL for schema operations:
```bash
composer require doctrine/dbal
```

## User Interface
For Bootstrap UI:
```bash
composer require laravel/ui
php artisan ui bootstrap
```

## Factory Example
Define model factories:
```php
public function definition()
{
    return [
        "name" => ->faker->jobTitle
    ];
}
```

Insert static values:
```php
use Illuminate\Support\Facades\DB;
DB::table('roles')->insert([
    "name" => "Admin"
]);
```
Generate random values:
```php
Role::factory()->times(10)->create();
```

## Using Tinker
Generate and manage model instances:
```bash
php artisan tinker
User::factory()->count(3)->make();
User::factory()->times(5)->create();
App\Models\User::factory()->count(1)->create();
App\Models\Secret::factory()->create(['user_id' => 2]);
User::with('secrets')->get();
```

## Seeders
Create a new seeder:
```bash
php artisan make:seeder RoleUserSeeder
```

Inside the seeder file, use the model factory:
```php
use App\Models\User;

public function run()
{
    User::factory()->count(10)->create();
}
```

Run seeders:
```bash
php artisan db:seed --class=RoleSeeder
php artisan migrate:refresh --seed
```

## Controller Subfolders
Create a controller in a subfolder:
```bash
php artisan make:controller Admin\UserController -r
```

Define routes:
```php
use App\Http\Controllers\Admin\UserController;
Route::resource('/admin/users', UserController::class);
```

## Route Grouping and Prefixing
Group and prefix routes:
```php
Route::prefix('admin')->name('admin.')->group(function(){
    Route::resource('/users', UserController::class);
});
```

## Pagination
Modify pagination:
```php
return view('admin.users.index', ["users" => User::paginate(10)]);
```

Add pagination links in the view:
```html
{{->links()}}
```

Configure Bootstrap pagination styling in :
```php
use Illuminate\Pagination\Paginator;

public function boot()
{
    Paginator::useBootstrap();
}
```

## Request Validation
Create a new request validation class:
```bash
php artisan make:request StoreUserRequest
```

## Gates
Define a gate in :
```php
use Illuminate\Support\Facades\Gate;

public function boot()
{
    ->registerPolicies();

    Gate::define('logged-in', function(){
        return ;
    });
}
```

Check gate in a controller method:
```php
if (Gate::denies('logged-in')) {
    dd('Access Denied');
}
```

## Email Verification
Follow the guide on [Laravel Email Verification](https://larainfo.com/blogs/laravel-8-email-verification-with-laravel-ui) for setting up email verification.

## API Route Prefix
Define API routes with a version prefix:
```php
Route::group(['prefix' =>"v1", 'namespace' => 'App\Http\Controllers\Api\V1'], function()
{
    Route::apiResource('customers', CustomerController::class);
    Route::apiResource('invoices', InvoiceController::class);
});
```

## Migrations
Create and manage migrations:
```bash
php artisan make:migration add_name_field_table_name --table=users
```

## Call a function controller inside tinker shell
```
app(ArticleController::class)->test()
```

Update schema:
```php
->string('name', 100)->change();
->dropColumn('image');
->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
```

## Controller from Tinker
Instantiate a controller:
```php
 = app('App\Http\Controllers\MyController');
```

## Vscode as Default Editor
Set VSCode as the default editor for Laravel Ignition:
```env
IGNITION_EDITOR="vscode"
```

## CI/CD Article
Refer to this [CI/CD pipeline article for Laravel](https://redberry.international/creating-ci-cd-pipeline-for-laravel-project/).

# Queue Handle

reschecule job failed:
```php
php artisan queue:failed # show failed jobs
php artisan queue:retry all # retry all failed jobs
```

# Disable CSRF Laravel 11

https://medium.com/@agitari65/disabling-csrf-protection-in-laravel-11-a-step-by-step-guide-8b41216ee571

## Traits

```shell
php artisan make:trait MyTrait
```
