# Tasky - A Flutter To-Do App
[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/yousefemadkhazbak183/TaskyApp)

Tasky is a clean and intuitive task management application built with Flutter. It helps you organize your daily to-dos, track your progress, and stay motivated with a personalized profile. The app features a smooth user experience with both light and dark modes, local data persistence, and a focused feature set for optimal productivity.

## Key Features

-   **📝 Full Task Management:** Create, read, update, and delete tasks with ease. Each task can have a name and a detailed description.
-   **⭐ Priority System:** Mark important tasks as "High Priority" to keep them at the forefront.
-   **📊 Progress Tracking:** The home screen features a dynamic progress circle that visually represents your daily task completion.
-   **🗂️ Smart Task Views:** Seamlessly filter and view your tasks in dedicated sections:
    -   To-Do
    -   Completed
    -   High Priority
-   **👤 Customizable User Profile:**
    -   Set a custom username and a personal motivational quote.
    -   Upload a profile picture from your device's camera or gallery.
-   **🌓 Dual Theme Support:** Enjoy a sleek dark mode or a clean light mode. The theme can be toggled manually from the profile screen.
-   **💾 Local Data Persistence:** Your tasks and profile information are saved locally on your device using `shared_preferences`, ensuring your data is always available.
-   **👋 Personalized Welcome:** A welcoming onboarding screen to set up your profile when you first use the app.

## Technology Stack

-   **Framework:** Flutter
-   **Language:** Dart
-   **State Management:** `provider`
-   **Persistence:** `shared_preferences` for storing tasks and user data.
-   **Image Handling:** `image_picker` for selecting profile pictures and `path_provider` for storing them.
-   **Vector Graphics:** `flutter_svg` for crisp and scalable icons.

## Project Structure

The project follows a feature-first architecture to ensure scalability and maintainability.

```
lib/
├── core/           # Shared components, services, themes, and constants
│   ├── components/
│   ├── services/
│   └── theme/
├── features/       # Individual application features (screens & controllers)
│   ├── home/
│   ├── profile/
│   ├── tasks/
│   └── welcome/
├── model/          # Data models for the application (TaskModel)
└── main.dart       # App entry point
```

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

-   Flutter SDK installed on your machine. You can follow the official [Flutter installation guide](https://docs.flutter.dev/get-started/install).

### Installation

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/yousefemadkhazbak183/TaskyApp.git
    ```
2.  **Navigate to the project directory:**
    ```sh
    cd TaskyApp
    ```
3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```
4.  **Run the application:**
    ```sh
    flutter run
