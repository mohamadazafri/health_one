## Setting up

### Download Android Studio

1. Download Android Studio through this URL: https://developer.android.com/studio?gclid=EAIaIQobChMIzcu0zdH3ggMV3qNmAh3x_Q7jEAAYASAAEgL4o_D_BwE&gclsrc=aw.ds
2. After installing Android Studio, please add new PATH in your environment variables for Android SDK
3. From the Start search bar, enter ‘env’ and select Edit environment variables for your account.
4. Under 'User variables for {USER-NAME}' check if there is an entry called 'Path':
5. Double click the 'Path' to edit it,
6. Add new full path to {USER-NAME}\AppData\Local\Android\SDK
7. Press 'OK'

### Download Flutter SDK

1. Download Flutter SDK through this URL: https://docs.flutter.dev/get-started/install/windows
2. Extract the zip file and place the contained flutter in the desired installation location for the Flutter SDK
3. Update your path (by doing step 4 until 8)
4. From the Start search bar, enter ‘env’ and select Edit environment variables for your account.
5. Under 'User variables for {USER-NAME}' check if there is an entry called 'Path'
6. Double click the 'Path' to edit it,
7. Add new full path to flutter\bin
8. Press 'OK'

### Setup VS Code for Flutter Development

There are a few extension to install to have a better experience:

1. Dart
2. Flutter

### Run The Project

There are 2 ways to run the code, either using emulator or real device

#### Using emulator

1. Open Android Studio
2. On the welcome page, press 'More Actions' then select 'Virtual Device Manager'
3. In this page, there will be a list of your virtual device
4. If you don't have any (or want to create a new one), press the '+'
5. Choose your device (highly recommended to download device with Play Store), then press 'Next'
6. Choose your system image and install it if you still don't have it (please refer to 'API level distribution chart' to get an idea which system image is suitable), then press 'Next'
7. Verify configuration then press 'Finish'
8. Choose your AVD then press 'Start'

Then you can run the code

1. Open VS Code then open the 'health_one' folder
2. Select device you have chosen previously (normally VS Code will automatically detect the device)
3. Open health_one\lib\main.dart file
4. Press 'Run' on top of main() function

#### Using real device

1. Enable the USB Debugging option under Settings > Developer options.

For Android 4.2 and newer, Developer options is hidden by default; use the following steps:

1. On the device, go to Settings > About <device>.
2. Tap the Build number seven times to make Settings > Developer options available.
3. Then enable the USB Debugging option.

Tip: You might also want to enable the Stay awake option, to prevent your Android device from sleeping while plugged into the USB port.

### Reference

https://docs.flutter.dev/get-started/install/windows

## Adding .env file

1. Create file name '.env' in the project root folder
2. In the file, you must initialize 2 variables, OPENAI_API_KEY and RAPID_API_KEY

Example of '.env' file content format:<br />
OPENAI_API_KEY=[Your OpenAI API key]<br />
RAPID_API_KEY=[Your Rapid API key]

### Reference

Please refer to this link on how to get OpenAI API and Rapid API key<br />
OpenAI API: https://platform.openai.com/docs/quickstart<br />
Rapid API: https://docs.rapidapi.com/docs/keys-and-key-rotation
