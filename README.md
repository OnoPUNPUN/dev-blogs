# DevBlogs

DevBlogs is a Flutter application built as a personal project to demonstrate a full SOLID clean architecture approach, modular structure, and clean code practices.

## 🌟 Project Summary

- Platform: Flutter (Android/iOS)
- Architecture: SOLID + Clean Architecture + Layered separation (presentation/domain/data)
- State management: (project-specific, e.g. Provider/BLoC/StateNotifier; update if needed)
- Features: authentication, blog listing, create/edit blog, blog detail, image upload, category tags.
- Responsibility: meaningful separation of concerns across `core/` and `features/` modules.

## 📁 Repository Structure

- `lib/main.dart` - app entrypoint
- `lib/core/` - shared services, theming, dependency injection and utilities
- `lib/features/auth/` - authentication flow and screens
- `lib/features/blog/` - blog CRUD business logic and UI
- `android/`, `ios/` - platform folders
- `test/` - unit and widget tests

### 🗺️ Project Structure Diagram

```mermaid
tree
  lib
    main.dart
    core
      common
      helpers
      network
      secrets
      theme
      usecase
      utils
    features
      auth
        data
        domain
        presentation
      blog
        data
        domain
        presentation
  android
  ios
  test
    widget_test.dart
```

## 🚀 How to Run

1. Install Flutter SDK
2. Run `flutter pub get`
3. Run on device/emulator:

```bash
flutter run
```

4. For tests:

```bash
flutter test
```

## 🛠️ Clone and Local Setup

1. Clone the repo:

```bash
git clone https://github.com/YOUR_USERNAME/dev-blogs.git
cd dev-blogs
```

2. Install dependencies:

```bash
flutter pub get
```

3. Configure secrets:

- `lib/core/secrets/app_secrets.dart` includes `subaseUrl` and `subaseKey`.
- Set your own from Supabase project settings (recommended to keep keys out of source control by using your own local secret management strategy).

4. Run:

```bash
flutter run
```

## 🧩 Clean Architecture Details

### 1. Presentation Layer
- Widgets, pages, and view models/controllers
- Input validation and UI state transformations
- Example path: `lib/features/blog/presentation`

### 2. Domain Layer
- Entities, use cases, and abstract repository contracts
- Business rules independent from frameworks
- Example path: `lib/features/blog/domain`

### 3. Data Layer
- Concrete repository implementations, remote/local sources
- Network API calls, persistence, serialization
- Example path: `lib/features/blog/data`

## 🔐 Authentication Flow

- Sign in screen
- Sign up screen
- Auth with Supabase built-in email/password
- Stores user additional data in `profiles` table

## ☁️ Supabase Backend Configuration

This project uses Supabase for authentication, database, and file storage.

Required Supabase tables:
- `profiles` (id, name, email, metadata)
- `blogs` (id, title, body, category, user_id, created_at, image_url, etc.)

Required Supabase storage:
- Bucket `blog_images` for blog image upload.

Expected Supabase CRUD flow:
- Sign up: `supabase.auth.signUp(email, password, data: {name})`
- Login: `supabase.auth.signInWithPassword(email, password)`
- Get all blogs: `supabase.from('blogs').select('*, profiles (name)')`
- Upload blog: `supabase.from('blogs').insert(...)`
- Upload image: `supabase.storage.from('blog_images').upload(id, file)`

## ✍️ Blog Features

- Home list of blog cards by category
- Detail view with title, author, date, image, content
- Create/update blog screen with title, body, image and categories
- Local caching and remote sync logic (if configured)

## 🖼️ Screenshots

> All local screenshots are in `screenshots/`.

1. `screenshots/screenshot_1.png` - blog list with category tags
2. `screenshots/screenshot_2.png` - create/edit blog screen
3. `screenshots/screenshot_3.png` - blog detail screen

> If your CLI or repo uses different screenshot file names, update those entries.

## 🧪 Tests

- `test/widget_test.dart` for UI widget tests
- Add domain/use case tests in `test/features/*`

## 🛠️ Notes

- The project is intentionally organized to support scalability in teams.
- Add/maintain coding standards via `analysis_options.yaml`, `flutter_lints`, and code review.

---

### 📌 Contribution

PRs welcome. Please keep code in clean modules, add tests for new behavior, and update README screenshots when UI changes occur.

### 💬 Contact

Personal developer project: many ideas will continue to grow into a full blog app.

