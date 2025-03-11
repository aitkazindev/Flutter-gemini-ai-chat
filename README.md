# Flutter Gemini Chat

Flutter Gemini Chat is a chat application that uses the power of AI to chat with your friends and family. This project is built using Flutter and integrates with the Google Generative AI API.

## Features

- Light and Dark theme support
- AI-powered chat responses
- Onboarding screen
- Customizable themes

## Getting Started

### Prerequisites

- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK**: Comes with Flutter
- **CocoaPods (for iOS)**: [Install CocoaPods](https://guides.cocoapods.org/using/getting-started.html#installation)

### Installation

1. **Clone the repository:**

    ```sh
    git clone https://github.com/yourusername/flutter_gemini_chat.git
    cd flutter_gemini_chat
    ```

2. **Install dependencies:**

    ```sh
    flutter pub get
    ```

3. **Set up the `.env` file:**

    Create a `.env` file in the root directory of the project and add your Google API key:
    [Get your API key here](https://aistudio.google.com/app/apikey)

    ```env
    GOOGLE_API_KEY=your_google_api_key
    ```

4. **Run the app:**

    For iOS:

    ```sh
    cd ios
    pod install
    cd ..
    flutter run
    ```

    For Android:

    ```sh
    flutter run
    ```

### Usage

1. Launch the app on your device or emulator.
2. Follow the onboarding instructions.
3. Start chatting with the AI-powered assistant.

## Project Structure

- `lib/main.dart`: Entry point of the application.
- `lib/onboarding.dart`: Onboarding screen.
- `lib/MyHomePage.dart`: Main chat screen.
- `lib/themes.dart`: Theme configuration.
- `lib/themeNotifier.dart`: Theme provider using Riverpod.
- `lib/message.dart`: Message model.

## Dependencies

- `flutter`: ^2.0.0
- `flutter_riverpod`: ^1.0.0
- `flutter_dotenv`: ^5.0.2
- `google_generative_ai`: ^1.0.0

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
````