Dallas JCC and TBAM
===================
Mobile Apps for Dallas JCC and TBAM.

----

## iOS
### App Info - Dallas JCC
* Development Bundle ID: com.accrisoft.appbuilder.dallasjcc.ios.alpha
* Production Bundle ID:  com.accrisoft.appbuilder.dallasjcc.ios

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
