# ![](icon.png) Dallas JCC and TBAM Apps for iOS

Mobile Apps for Dallas JCC and TBAM.

## iOS

### App Info - Dallas JCC

    Development Bundle ID: com.accrisoft.appbuilder.dallasjcc.ios.alpha
    Production Bundle ID:  com.accrisoft.appbuilder.dallasjcc.ios

### Setup Development Environment

* Install Fastlane tools
* Setup **match**
* Install iOS certificates and provisioning profiles
```
fastlane certs
```

* Consider permanently removing Xcode's Fix-it button
```
fastlane xcode
```

### iOS Builds
```
fastlane ios test
```

```
fastlane ios beta
```

```
fastlane ios appstore
```

----

## Push Certificates

Create PEM certificates using Fastlane Tools:
```
pem -e ~/certs -a com.accrisoft.appbuilder.dallasjcc.ios -p PASSWORD
```

```
pem -e ~/certs -a com.accrisoft.appbuilder.dallasjcc.ios.alpha --development -p PASSWORD
```
* then copy the pem file your push server
* and set encoded password in server's config file
* *Note: after creating the PEM certificates I had to delete the the provisioning profiles manually from the Apple Development Console and then use match --force to recreate the provisioning profiles*

----

## Coding Standards and Style Guide

* Indent code using 4 spaces, not tabs
* Prefer optional variables to forced-unwrapped variables (ie: prefer ? to !)
* Colons stick to the class name, not the variable, for variable and function declarations
* Colons stick to the prefix name, not the variable, when calling functions
* No spaces after parenthesis opening or before parenthesis close
* Brackets go on the next line for classes, structs, and functions
* Brackets stay on the same line for statements like: if, for, while, etc
* Line up the closing brackets with the opening statement (or class)
* Use "self" when referring to a class variable in that class
* Use parenthesis around if statement predicates

```swift
class MyClass
{
    private var bar :String = ""

    func foo(num :Int) 
    {
        if (num > 0) {
            self.bar = "greater than zero"
        }
    }
}
```

* Keep the brackets of an "else" statement on the same line as the else

```swift
if (num > 0) {
    flag = true
} else {
    flag = false
}
```

* Indent the cases of a switch statement like in the olde days

```swift
switch (flag) {
    case 1:
        return "one"
    case 2:
        return "two"
    ...
}
```
