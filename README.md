# Thirdwayv. inc

## Architecture used:

MVVM With Dependency Injection and using UnitTesting and to Mocking API

  View
– According to the definition, the View consists of only visual elements.
– In the View, we only do things like layout, animation, initializing UI components, etc. • ViewModel
– There’s a special layer between the View and the Model called the 

ViewModel
– The ViewModel is the representation of the View.
– ViewModel provides a set of interfaces, each of which represents a UI component in the View.

• Binding
– We use a technique called “binding” to connect UI components to ViewModel interfaces.
– So, in MVVM, we don’t touch the View directly, we deal with business logic in the ViewModel and thus the View changes itself accordingly.
• We write presentational things such as converting Date to String in the ViewModel instead of the View
Therefore, it becomes possible to write a simpler test for the presentational logic without knowing the implementation of the View.

* Use the Product API - No authentication needed  https://jsonkeeper.com/b/9OW4

 -     Fetch all products based on categories and show details it

### Features


     •     Project Organization & Architecture
    •     MVVM With Dependency Injection
    •     Support Dark Mode & light mode 
    •     Downloading & Caching images and data
    •     Custom Animations
    •     scrolled infinitely to load more products 
        •        Generated Documentation file using HeaderDoc, markdown&jazzy
    •     Asynchronous Data Fetch
        •        check the internet connection and refresh the app 
    •     Planning our Network Calls - API, JSON, Model
        •        Generics Networking(Custom Response)
        •           Animations
        •     UnitTesting API by mock
        •        Cached locally and show when no have internet
        •        and many tools used

#### UI
## video demo
https://user-images.githubusercontent.com/41602889/173255269-87f8578f-7eda-4110-ad61-d8b752379c39.mp4
