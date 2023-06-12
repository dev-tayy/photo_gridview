# PhotoView Gallery Mobile

PhotoView Gallery Mobile Application.


  <summary>Architecture & code organization</summary>

```sh
.
├── .vscode                    # contains launch configurations for the app if using VS Code
├── android                   # android
├── ios                       # ios
├── coverage                  # to get the overall test coverage of the app 
├── lib                       # library
│   ├── data                      # datasource, repositories models {basically interacts with APIs} 
│   ├── components                # components: general components found throughout the app.
│   ├── bloc                      # bloc state management properties {this interacts with the repository and the UI components}
│   ├── utils                     # shared utilities: api.client, constants, database, bloc.observer.
│   ├── screens                   # screens & pages.
│   └── main.dart
└── test                      # testing
```



## Running PhotoView Mobile App
```sh
.
├── Step-1:    # Clone the 'main' branch from this repository

├── Step-2:    # Create an env.json file and populate it using the details sent to your email, see env.example.json file in the root path of the project for reference

├── Step-3:    # (Skip this step and run your app if you use VSCode) Run flutter using the following command "flutter run --dart-define-from-file=env.json" from your terminal.
```

### Generate test coverage report 

```bash
# Generate `coverage/lcov.info` file
flutter test --coverage
# Generate HTML report
# Note: on macOS you need to have lcov installed on your system (`brew install lcov`) to use this:
genhtml coverage/lcov.info -o coverage/html
# Open the report
open coverage/html/index.html
```

Alternatively, just run ```flutter test``` !