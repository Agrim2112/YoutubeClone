# YouTube Clone

Welcome to the YouTube Clone project! This project is a simplified version of YouTube, built using Flutter for the frontend and Supabase for the backend. The app includes features like email-based login, video playback, and profile management.

## Features

### 1. Email-Based Login Screen
- Users can log in using their email addresses.
- Utilizes Supabase authentication for secure login.

### 2. Home Screen
- Displays a list of videos.
- Users can browse and select videos to watch.

### 3. Video Screen
- Video playback functionality including:
  - Play/Pause
  - Rewind and Forward
  - Seek time
  - Change playback speed

### 4. Profile Screen
- Users can view and edit their profile settings.
- Profile settings include name and profile photo.
- Users can change their profile picture.

## Tech Stack

### Frontend
- **Flutter**: Used to build the front end of the application.
- **Bloc**: Used for state management to ensure a responsive and scalable UI.

### Backend
- **Supabase**: Provides authentication, storage, and database services.
  - **Authentication**: Implements Supabase authentication for secure user login.
  - **Storage**: Uses Supabase storage for storing video files.
  - **Database**: Uses Supabase's Postgres database for storing user data.

## Getting Started

### Prerequisites
- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Supabase Account: [Sign up for Supabase](https://supabase.io/)

### Installation

1. **Clone the repository:**
    ```sh
    git clone https://github.com/your-username/youtube-clone.git
    cd youtube-clone
    ```

2. **Install dependencies:**
    ```sh
    flutter pub get
    ```

3. **Set up Supabase:**
   - Create a new project in Supabase.
   - Configure authentication, storage, and database as per the Supabase documentation.
   - Update your Flutter app with your Supabase project's API URL and public anon key. Add these in your `lib/config.dart` file:

    ```dart
    const String supabaseUrl = 'https://your-supabase-url.supabase.co';
    const String supabaseAnonKey = 'your-public-anon-key';
    ```

4. **Run the app:**
    ```sh
    flutter run
    ```


