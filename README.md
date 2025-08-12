# ⚽ Football Player Management App

A **Flutter** application for managing football players' data in **academies** and **clubs**.  
The app allows coaches and admins to **register players**, record their **training results**, and **evaluate performance** over time — all powered by **Supabase** backend and **BLoC** state management.

---

## 🚀 Features

- 📝 **Player registration** with personal details (name, birthdate, phone, national ID, academy, position, photo)
- 🏟 **Academy & Club management** (link players to their teams)
- 📊 **Training result recording** for each player
- ⭐ **Performance evaluations** grouped by categories and criteria
- 🌐 Multi-language support (Arabic & English)
- 📂 File & Image picker for player photos
- 📡 Internet connectivity detection
- 📊 Export player data to Excel
- 🎨 Beautiful animations with Lottie
- 📤 Share reports via `share_plus`


## 🏗 Architecture & Patterns

This project follows a **clean and maintainable architecture** that ensures scalability and testability:

- **State Management** → `Cubit` (BLoC Pattern) for predictable and reactive UI updates.
- **Architecture Pattern** → `MVVM` (Model–View–ViewModel) for separation of concerns.
- **Data Fetching**:
  - **GraphQL API** → For efficient querying and precise data fetching from Supabase.
  - **RESTful API** → For standard HTTP endpoints when needed.
- **Layered Folder Structure**:
  - lib/
    ├── data/ # Models & Repositories
    ├── presentation/ # Cubits, Views, Widgets
    ├── core/ # Constants, Themes, Utilities
    ├── # Localization (AR/EN)
