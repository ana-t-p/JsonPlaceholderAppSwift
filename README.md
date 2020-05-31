# JsonPlaceholderAppSwift
JsonPlaceholderAppSwift is a small mobile iOS app in Swift 5 that consumes a REST API service from Fake API, offered by [jsonplaceholder](https://jsonplaceholder.typicode.com/), and displays it on the UI.

## About the implementation
### Structure
- The project is structured based on the **Clean Swift** architecture, so I have used the [templates](https://clean-swift.com/) created by **Raymond Law** for that.
I think that is a very modular structure, which although it may be difficult to understand at first, in the end makes things much easier.
### Networking
- For the API calls, since I didn't use any *pod*, I used the native framework from *Foundation*: [URLRequest](https://developer.apple.com/documentation/foundation/urlrequest). All the request are asynchronous so I used a [DispatchGroup](https://developer.apple.com/documentation/dispatch/dispatchgroup) in the second view to match them because it is made several API calls (two of them are also synchronous).
### UI/UX
- The UI is quite simple and accessible. The application is composed of three screens (one of them can be considered as a popup), coloured with a small palette of colours.
I have used one picker, one collection and one table to display the written data and the native [UIAlertController](https://developer.apple.com/documentation/uikit/uialertcontroller) to show the errors that may occur when obtaining it (there is a small error manager). All the assets are natives from iOS (all but app icon, which was added by me).
- Also, for the loading time, I used [UIActivityIndicatorView](https://developer.apple.com/documentation/uikit/uiactivityindicatorview).
### Localisable
- The project has a Localisable file, but just in English.
### Tests
- The tests have been done for each scene and for the added extensions.


## Things to improve
Maybe the first thing to improve would be the networking issue. Now it is not controlling if a call is done and the user leaves the screen and again tries to make a new call. In the past I have used other frameworks to control things like that.

The cells from the table do not adjust their height based on the content, as well as the collection ones. Maybe if the views were made by code instead of *Storyboards* it wouldn't be similar issues, but I thought this was the fastest (and visual) option to implement.

The app can be localisabled. All the texts are displayed by using keys, so it would be possible to add new languages for the app.

Maybe some animations would be nice.

The way to show errors is a little invasive, I think. Maybe a snackbar at the bottom of the screen would be better.

## Running
Just open the .xcproject file and run it in a simulator. No need to install pods.

## License
[MIT](https://choosealicense.com/licenses/mit/)

## Authors
Ana Tirado Pro
