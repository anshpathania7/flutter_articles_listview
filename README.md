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
- currently post id are stored in shared preferences and then is matched with id of posts obtained by api, need to store whole json of post data lcoally
- pagination required, currently loads 100 items at once
- need to option of refreshing data in case of api failure
- need to cache posts before calling api, and after api call update the cached data, and show only cached data
- could add skeleton view while loading data to improve UI
- need to check network connection while application is running, if offline, notify the user of same and load cached data
  
