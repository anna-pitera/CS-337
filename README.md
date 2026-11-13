# Weather App [CS-337-01]
This weather app project implements a number of iOS app development features as follows:
| Package  | Implementation |
| :-------------: | ------------- |
| SwiftUI  | - `NavigationStack` and `NavigationLink` for linking views<br> - `HStack` & `VStack` for displaying content horizontally and vertically<br> - `Text` views for formatting and customizing text (font styles, digit styles, alignment, labels)<br> - `Section` views for separating and organizing content hierarchically<br> - `Grid` views to display `GridRow` structures as tables |
| MapKit  | - `Map` view to embed an interactive map interface<br> - `MapReader` for converting screen tap gestures into usable information<br> - `Marker` and `UserAnnotation` structures for displaying location pin annotations |
| CoreLocation  | - `CLLocationManager` for authorizing the collection of data from location-related app events<br> - `CLLocationCoodinate2D` for mapping latitude and longitude to real-world locations |

## App Architecture
### CurrentWeather Struct
| Variable | Type | Purpose | 
| :-------------: | :-------------: | ------------- | 
| `date` | `Date` | Current weather's date |
| `temperature` | `Double` | Current weather's temperature (in Fahrenheit) |
| `windSpeed` | `Double` | Current weather's wind speed (in mph) |

### DailyForecast Struct (Identifiable)
| Variable | Type | Purpose | 
| :-------------: | :-------------: | ------------- | 
| `id` | `Date { date }` | Daily forecast's required `id` value, which computes to the existing `date` value instead of making a whole new identifying value |
| `temperature` | `Double` | Daily forecast's temperature (in Fahrenheit) |
| `windSpeed` | `Double` | Daily forecast's wind speed (in mph) |

### Forecast Struct
| Variable | Type | Purpose | 
| :-------------: | :-------------: | ------------- | 
| `days` | `[DailyForecast]` | A collection of `DailyForecast` structs, each corresponding to a day of the week |

### WeatherData Struct
| Variable | Type | Purpose | 
| :-------------: | :-------------: | ------------- | 
| `current` | `CurrentWeather` | The current weather, simplified into a `CurrentWeather` struct |
| `forecast` | `Forecast` | The week's weather forecast, simplified into a `Forecast` struct |

### APIResponse Struct (Decodable)
| Variable | Type | Purpose | 
| :-------------: | :-------------: | ------------- | 
| `current` | `Current` | The current weather, as decoded by the `Current` struct's `Decodable` protocol |
| `daily` | `Daily` | Each day of the week's daily weather, as decoded by the `Daily` struct's `Decodable` protocol |

### WeatherModel Class
In my design of this app, I created one main class `WeatherModel` to contain the function `getForecastData()`, which takes in a `CLLocationCoordinate2D` set of coordinates and gathers the weather forecast data corresponding to the location of the coordinates. `getForecastData()` goes through the following steps:
1. Designate `lat` and `long` as constants to store the latitude and longitude of the `CLLocationCoordinate2D` set of coordinates
2. Designate `url` as a constant `URL` struct that holds the [Open-Meteo](https://open-meteo.com/) API, which gets filled in with the `lat` and `long` values in addition to basic weather API call parameters (e.g. `temperature_unit=fahrenheit`, `wind_speed_unit=mph`, `timezone=auto`, and which weather forecast data to fetch)
   - If the URL cannot be properly resolved at this step, `guard` ensures that a `NetworkError` will be thrown to indicate that something went wrong
4. Fetch the data in an API call (returns as `(data, response)`) using `URLSession.shared`, making sure to include `await` so the Swift compiler knows to pause until the data is returned
5. Designate `decoded` as a constant that holds `data` after it is decoded using `JSONDecoder()` according to the `Decodable` protocol of `APIResponse`
6. Create two separate instances of the `DateFormatter()` class, which are then used to format the `CurrentWeather` data and the `DailyForecast` data respectively
7. Extract the current day's weather from `CurrentWeather` using `decoded` and create a `CurrentWeather` struct from that data
8. Extract each day of the week's `DailyForecast` from `decoded` and append it to `days`, which is then used to create a `Forecast` struct
10. Return a `WeatherData` object containing the aforementioned `CurrentWeather` and `Forecast` structs

## App UI
### Views
| View | Purpose |
| :-------------: | ------------- | 
| `SearchView` | Displays a search bar, which uses a `search()` function to position the map's perspective after a `searchString` is submitted |
| `MapView` | Displays a `Map` view with various `VStack` and `HStack` views overlaid to hold the `TempView` and `DetailButtonView` views |
| `TempView` | Displays a `Text` view to show a quick representation of the current location's temperature at this exact moment |
| `DetailButtonView` | Displays a tappable `Text` view with an icon, which the user can tap to navigate to the `DetailView` view |
| `DetailView` | Displays a `List` view with various `VStack` and `HStack` views in `Section` views corresponding to the current weather data and the week's forecasted weather data (using the `forecastTable()` function to create a `Grid` view with `GridRow` structs highlighting the week's daily high and low temperatures) |

### ViewModel
`WeatherViewModel` contains three functions:
1. `useCurrentLocation()` is used for displaying the user's current location before they submit a location as a `searchString` (e.g. when the app first loads and the user has not searched for any location yet)
    - This function checks if `hasSelectedLocation` is true or false to determine if the user's current immediate location should be used
3. `handleSearchSubmit()` is used when the user submits a `searchString` in the search bar, making sure to validate the `searchString` the user enters as a proper location
    - If the user's entered `searchString` is valid, the search bar is reset so that the user can enter the next location faster and more conveniently
    - If the user's entered `searchString` is invalid (e.g. if it would not return a valid set of coordinates using the `Geocoder`), the search bar is not reset, which gives the user room to fix any accidental typos in the `searchString` they entered
4. `select()` is used when the user has selected a location on the map (`hasSelectedLocation = true`) in order to get the corresponding weather data
    - This function also uses `async` and `await` to wait for the `Geocoder` to complete the `getPlaceName()` function, which reverse-geocodes the location's coordinates into the more commonplace name of the location (e.g. "West Long Branch, New Jersey")
    - The `getPlaceName()` function's result is then used in the `DetailView` view to display the currently selected location in a more user-friendly way
