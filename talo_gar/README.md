# Talo-Gar - Barber Booking App

![Barber](images/barber.jpg)

A Flutter application for booking barber appointments.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Screenshots](#screenshots)
- [Getting Started](#getting-started)
- [Dependencies](#dependencies)
- [Usage](#usage)
- [Contributing](#contributing)
- [Credits](#credits)
- [Links](#links)

## Overview
Talo-Gar is a mobile application designed to simplify the process of booking barber appointments. Built with Flutter, it provides a seamless experience for both customers and barbers. This project was developed as a final portfolio project for the ALX Software Engineering Backend Specialization.

## Features
- User authentication (sign up, login)
- Book appointments with barbers
- View available services (haircut, beard, facials, etc.)
- Admin panel for managing bookings and users
- Persistent user data with Firebase and Shared Preferences
- Onboarding and welcome screens

## Screenshots
<!-- Add screenshots here if available -->

## Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Firebase account](https://firebase.google.com/)

### Installation
1. **Clone the repository:**
   ```sh
   git clone https://github.com/Da-Rumi/Talo-Gar.git
   cd Talo-Gar/talo_gar
   ```
2. **Install dependencies:**
   ```sh
   flutter pub get
   ```
3. **Configure Firebase:**
   - Add your `google-services.json` to `android/app/`.
   - Add your `GoogleService-Info.plist` to `ios/Runner/`.
4. **Run the app:**
   ```sh
   flutter run
   ```

### Generating Launcher Icons
To generate custom launcher icons, run:
```sh
flutter pub run flutter_launcher_icons
```

## Dependencies
- flutter
- firebase_core
- cloud_firestore
- firebase_auth
- random_string
- shared_preferences
- image_picker
- cupertino_icons
- flutter_launcher_icons
- flutter_lints

## Usage
- Sign up or log in as a user or admin.
- Browse available services and book appointments.
- Admins can manage bookings and users from the admin panel.

## Contributing
Contributions are welcome! Please fork the repository and submit a pull request.

1. Fork the repo
2. Create your feature branch (`git checkout -b feature/YourFeature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/YourFeature`)
5. Open a pull request

## Credits
Developed by **Mahbub Mahbub** as part of the ALX Software Engineering program.

## Links
- [Project Presentation Video](https://youtu.be/uwD1ya-v3eA)
- [GitHub Repository](https://github.com/Da-Rumi/Talo-Gar)
- [Google Slides Presentation](https://docs.google.com/presentation/d/1ZXA66zT4jXO2YRpHzEFOuKO0Vke-anjQLLP5mxJSoVQ/edit?usp=sharing)


