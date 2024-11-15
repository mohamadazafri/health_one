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

## Privacy Policy
Effective Date: 16th November 2024

Health One is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application ("Health One"). Please read this Privacy Policy carefully to understand our practices regarding your information and how we will treat it.

1. Information We Collect
We may collect the following types of information when you use the App:

a. Personal Information
Information you provide directly, such as:
Name
Fitness goals or health-related preferences (optional)

b. Automatically Collected Information
App usage data (e.g., features accessed, time spent)
Diagnostic and performance data for improving the app experience.

2. How We Use Your Information
We use the information collected to:
Provide and improve the functionality of the App.
Personalize your experience, including generating workout plans and responding to health concerns.
Analyze app performance and troubleshoot technical issues.
Communicate updates, promotions, or important notifications about the App.

3. How We Share Your Information
We do not sell or rent your personal information. However, we may share your information in the following cases:
Service Providers: With trusted third-party providers who assist us in operating the App, such as cloud hosting and AI processing services.
Legal Compliance: If required by law or to comply with legal obligations.
Business Transfers: In the event of a merger, sale, or acquisition, your information may be transferred as part of the business assets.

4. Data Security
We implement reasonable technical and organizational measures to protect your information against unauthorized access, loss, misuse, or alteration. However, no method of transmission over the internet or electronic storage is 100% secure, and we cannot guarantee absolute security.

5. Your Privacy Rights
Depending on your location, you may have the following rights:

Access to the personal information we hold about you.
Request correction or deletion of your personal information.
Restrict or object to the processing of your information.
Data portability, where applicable.
To exercise these rights, contact us at [Your Contact Email Address].

6. Retention of Information
We retain your information only as long as necessary to fulfill the purposes outlined in this Privacy Policy unless a longer retention period is required by law.

7. Use of AI and Uploaded Content
When you use features such as the AI Visual Diagnosis or Health Chatbot:

Uploaded photos are processed by AI algorithms to provide health insights. These photos are not stored permanently on our servers unless required for feature functionality (e.g., history tracking).
Chat history with the AI Health Chatbot is temporarily stored to improve user experience and provide contextual responses but is not shared with third parties.
8. Third-Party APIs and Integrations
The App integrates with third-party APIs, including:

OpenAI API (ChatGPT 4.0): Used for AI Health Chatbot and workout plan generation.
ExerciseDB API: Used to provide exercise information and suggestions.
These third parties may collect and process data according to their own privacy policies. We recommend reviewing their policies to understand their practices.

9. Children’s Privacy
The App is not intended for use by children under the age of 13. We do not knowingly collect personal information from children. If we become aware that we have inadvertently collected personal information from a child, we will take steps to delete such information promptly.

10. Changes to This Privacy Policy
We may update this Privacy Policy from time to time to reflect changes in our practices or for other operational, legal, or regulatory reasons. We encourage you to review this Privacy Policy periodically. Your continued use of the App after changes are posted constitutes your acceptance of the updated Privacy Policy.
