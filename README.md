# Weather Forecast

## Dependencies

Using [CocoaPods](https://cocoapods.org), in the root of the project, run:

```
pod install
```

Be sure to use the same version of CocoaPods that was used to generate `Podfile.lock`. One way to do that is through [podenv](https://github.com/kylef-archive/podenv).

We try to use always the latest version of CocoaPods.

## Schemes and Configurations

There is only one scheme:

1. weatherforecast – Use this scheme when developing or building for App Store deployment. 

This scheme has two configurations: debug and release.

## Groups and Folders

The Xcode project's groups correspond directly to filesystem folders to keep the two as logically organized as possible.

The contents of Xcode project groups are kept alphabetized to make it easier to find files. To alphabetize a group's contents, control-click the group in Xcode and then select Sort by Name.

## Tests

Unit tests cover a few parts of the code that deal with things like tricky logic or asynchronous race conditions. Before pushing to GitHub, please run the tests to make sure they all still pass.

## Weather API

  - API: <http://openweathermap.org/api>
  - Documentation: Current <https://openweathermap.org/current> - Forecast <https://openweathermap.org/forecast5>
# weatherForecastApp
