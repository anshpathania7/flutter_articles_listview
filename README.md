markdown
CopyEdit
# Flutter Article App
A Flutter app that fetches and displays a list of articles from a public
API.
## Features
- List of articles
- Search functionality
- Detail view
- Responsive UI
## Setup Instructions
1. Clone the repo:
git clone <your-repo-link>
cd flutter_article_app
2. Install dependencies:
flutter pub get
3. Run the app:
flutter run
## Tech Stack
- Flutter SDK: 3.29.3
- State Management: Provider
- HTTP Client: Dio
- Persistence: Shared Preferences
- Dependency Injection: Get It

## State Management Explanation
Used Provider to maintain a common state regarding data and flow of data liek :
- show loading state -> fetch data remotely -> update loaded/error state
- filter posts list locally on application side depending on title/body
- add/remove posts to favourites
  
## Known Issues / Limitations
