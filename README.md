# 📝 User Task Management API

Sistem manajemen user dan task dengan role-based authorization (**Admin, Manager, Staff**) menggunakan Laravel dan Sanctum.

---

## ⚡ Fitur

✅ **Auth**
- Login (Sanctum Token)
- Middleware status aktif user

✅ **User**
- **Admin**: create user, view all users
- **Manager**: view users
- **Staff**: tidak memiliki akses user management

✅ **Task**
- **Admin**: CRUD semua task
- **Manager**: create & manage task assigned ke staff
- **Staff**: view task assigned, update status task sendiri

✅ **Activity Logs**
- View logs (hanya admin)

---

+--------------------+          +-------------------------------+      +-------------------------+
|       Users        |          |       Tasks                   |      |     Activity Logs       |
+--------------------+          +-------------------------------+      +-------------------------+
| id (UUID, PK)      |<------.  | id (UUID, PK)                 |      | id (UUID, PK)           |
| name (string)      |       |  | title (string)                |      | user_id (UUID, FK)      |
| email (string, UQ) |       '--| description (text)            |      | action (string)         |
| password (string)  |          | assigned_to (UUID, FK->Users) |      | description (text)      |
| role (enum)        |          | status (enum)                 |      | logged_at (datetime)    |
| status (boolean)   |          | due_date (date)               |      +-------------------------+
+--------------------+          | created_by (UUID, FK->Users)  |
                                +-------------------------------+ 
🗂️ Entity Relationship Diagram (ERD)
erDiagram
    User {
        UUID id PK
        string name
        string email UK
        string password
        enum role "admin, manager, staff"
        boolean status "active/inactive"
    }

    Task {
        UUID id PK
        string title
        text description
        UUID assigned_to FK "relasi ke User"
        enum status "pending, in progress, done"
        date due_date
        UUID created_by FK
    }

    ActivityLog {
        UUID id PK
        UUID user_id FK
        string action "create_user, update_task, etc."
        text description
        datetime logged_at
    }

    User ||--o{ Task : "assigned_to"
    User ||--o{ Task : "created_by"
    User ||--o{ ActivityLog : "user_id"

📌 Detail Entitas

1. User

| Field        | Tipe Data | Keterangan                                  |
| ------------ | --------- | ------------------------------------------- |
| **id**       | UUID      | Pengidentifikasi unik untuk pengguna (PK)   |
| **name**     | string    | Nama pengguna                               |
| **email**    | string    | Email pengguna (unique)                     |
| **password** | string    | Kata sandi (di-hash)                        |
| **role**     | enum      | Peran pengguna: `admin`, `manager`, `staff` |
| **status**   | boolean   | Status akun: `active` atau `inactive`       |

2. Task

| Field            | Tipe Data | Keterangan                                     |
| ---------------- | --------- | ---------------------------------------------- |
| **id**           | UUID      | Pengidentifikasi unik untuk tugas (PK)         |
| **title**        | string    | Judul tugas                                    |
| **description**  | text      | Deskripsi tugas                                |
| **assigned\_to** | UUID      | ID pengguna yang ditugaskan (FK ke User)       |
| **status**       | enum      | Status tugas: `pending`, `in progress`, `done` |
| **due\_date**    | date      | Tanggal jatuh tempo tugas                      |
| **created\_by**  | UUID      | ID pengguna yang membuat tugas (FK ke User)    |

3. ActivityLog

| Field           | Tipe Data | Keterangan                                               |
| --------------- | --------- | -------------------------------------------------------- |
| **id**          | UUID      | Pengidentifikasi unik untuk log aktivitas (PK)           |
| **user\_id**    | UUID      | ID pengguna terkait aktivitas (FK ke User)               |
| **action**      | string    | Aksi yang dilakukan, misal: `create_user`, `update_task` |
| **description** | text      | Deskripsi rinci aktivitas                                |
| **logged\_at**  | datetime  | Waktu pencatatan aktivitas                               |


---

## ⚙️ Setup

1. **Clone repository**

```bash
git clone https://github.com/username/user-task-api.git
cd user-task-api

2. Install dependencies
composer install

3. Copy file .env dan generate app key
cp .env.example .env
php artisan key:generate

4. Atur koneksi database di .env
APP_NAME=UserTaskAPI
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://127.0.0.1:8000

LOG_CHANNEL=stack

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=user_task_db
DB_USERNAME=root
DB_PASSWORD=

SANCTUM_STATEFUL_DOMAINS=localhost
SESSION_DOMAIN=localhost

Setelah itu jalankan:
php artisan key:generate

5. Migrasi database
php artisan migrate

6. Jalankan server lokal
php artisan serve
Akses di: http://127.0.0.1:8000

🔑 Endpoint Utama
| Method | Endpoint        | Role Akses            | Deskripsi                    |
| ------ | --------------- | --------------------- | ---------------------------- |
| POST   | /api/login      | All                   | Login user (email, password) |
| GET    | /api/users      | Admin, Manager        | Lihat list user              |
| POST   | /api/users      | Admin                 | Buat user baru               |
| GET    | /api/tasks      | Admin, Manager, Staff | Lihat list task              |
| POST   | /api/tasks      | Admin, Manager        | Buat task baru               |
| PUT    | /api/tasks/{id} | Admin, Manager, Staff | Update task                  |
| DELETE | /api/tasks/{id} | Admin, Manager        | Hapus task                   |
| GET    | /api/logs       | Admin                 | Lihat activity logs          |


🔒 Authorization Policy
Didefinisikan di AuthServiceProvider.php menggunakan Gate::define.
| Policy       | Role                  |
| ------------ | --------------------- |
| manage-users | admin                 |
| view-users   | admin, manager        |
| manage-tasks | admin, manager, staff |
| view-logs    | admin                 |

💡 Contoh Request JSON
🔑 Login
POST /api/login
Content-Type: application/json

{
    "email": "admin@example.com",
    "password": "password"
}

👤 Create User (Admin)
POST /api/users
Authorization: Bearer {token}
Content-Type: application/json

{
    "name": "Manager One",
    "email": "manager@example.com",
    "password": "password",
    "role": "manager"
}

✅ Create Task (Admin / Manager)
POST /api/tasks
Authorization: Bearer {token}
Content-Type: application/json

{
    "title": "Finish Report",
    "description": "Prepare monthly report",
    "assigned_to": "user-uuid",
    "due_date": "2025-07-05"
}

🛠 Tools & Teknologi
PHP 8.x

Laravel 9.x

Sanctum (API Token)

MySQL / MariaDB

Postman (testing)

VSCode


👤 Penulis
Muhammad Rizki
GitHub • Bogor, Indonesia
