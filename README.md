# MYJSON
[![Version](https://img.shields.io/github/release/damonthecricket/MYJSON.svg)](https://github.com/soffes/MYJSON/releases)
[![Travis CI](https://travis-ci.org/damonthecricket/my-json.svg?branch=master)](https://travis-ci.org/damonthecricket/my-json) 
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) 
![CocoaPods](https://img.shields.io/cocoapods/v/MYJSON.svg) 
![Platform](https://img.shields.io/badge/platforms-iOS%208.0+%20%7C%20macOS%2010.10+%20%7C%20tvOS%209.0+%20%7C%20watchOS%202.0+-333333.svg)

![MYJSON](https://github.com/damonthecricket/my-json/blob/master/my-json-lib.jpg)
Swift JSON framework.

MYJSON is a simple Swift library to convert JSON to strongly typed objects.

1. [Features](#features)
2. [Installation](#installation)
3. [Requirements](#requirements)
4. [Usage](#usage)
    - [JSON](#json)
    - [Deserializing](#deserializing)
    - [Serializing](#serializing)
    


### Features

- Mapping JSON to objects.

- Mapping objects to JSON.

- Custom transformations.

- Easy and safe using.

### Installation

- #### [CocoaPods](http://cocoapods.org/)

  ```ruby
  use_frameworks!
  
  pod 'MYJSON'
  ```

- #### [Carthage](https://github.com/Carthage/Carthage)

  ```
  github "damonthecricket/MYJSON"
  ```

- #### [Git](https://git-scm.com/)

  ```
  $ git submodule add https://github.com/damonthecricket/my-json.git
  ```
- #### Manually

  - Copy MYJSON to the root of your project.
  
  - Add it in file inspector of your project.
  
  - Go to Targets -> Add MYJSON to Embedded Binaries.
  
### Requirements
  
 - iOS 8.0+  |  macOS 10.10+  |  tvOS 9.0+  |  watchOS 2.0+.
 
 - Xcode 8.
 
 - Swift 3.
 
### Usage

#### JSON

##### Initialization
```MYJSON``` is ```enum```, which represents JSON in two variations. ```MYJSON``` takes on value ```dictionary``` or ```array of dictionaries```.

You can initialize ```MYJSON``` in the manner described below:

```swift
import MYJSON

let rawJSON: MYSJONType = [
    "id": "sdfsf34324sdfdhg1"
    "index": 98451
    "first name": "Damon"
    "last name": "Cricket"
]

let json: MYJSON = MYJSON(rawValue: rawJSON)

let jsonArray: MYJSON = MYJSON(rawValue: rawJSON)
switch json: {
    case .value(let json):
       // ...
       // Code
       // ...
    default:
       break
}   
```

and

```swift
import MYJSON

let rawJSONArray: MYSJONType = [
    ["id": "sdfsf34324sdfdhg1",
     "index": 98451,
     "first name": "Damon",
     "last name": "Cricket"],
     
    ["id": "fkgfg34kfg",
     "index": 1234,
     "first name": "Zee",
     "last name": "Gor"]
]

let jsonArray: MYJSON = MYJSON(rawValue: rawJSONArray)
switch jsonArray: {
    case .array(let jsonArray):
       // ...
       // Code
       // ...
    default:
       break
}   
```

or 

```swift
import MYJSON

if let json = try? JSONSerialization.allowFragmentsJSON(with: data) {
      // ...
      // Code
      // ...
}
```

1. In first case ```MYJSON``` instance is ```.value(let json)```, where value associated with ```JSON``` instance (```dictionary```, or ```MYJSONType```).

2. In second case ```MYJSON``` instance is ```.array(let array)```, where value associated with ```JSON array``` (or ```MYJSONArrayType```).

3. In third case ```MYJSON``` instance initialized from raw ```JSON data``` and hold associated value.

> *Note*: ```MYJSON init(rawValue: Any)``` takes only two type of input parameter - ```MYJSONType``` (```[String: Any]```) or ```MYJSONArrayType``` (```[[String: Any]]```), otherwise initializer returns empty MYJSON.

##### Properties
```MYJSON``` has a useful properties and functions. For example, you can you can check wheter instance is ```dictionary``` or ```array of dictionaries```:
```swift
import MYJSON

if json.isDictionary {
    // Code
}

if json.isArray {
    // Code
}

```
Also you can access to JSON associated value.
For ```dictionary```:
```swift
import MYJSON

var id: String = json["id"]
```
For ```array of dictionaries```:
```swift
import MYJSON

var json: MYJSONType = jsonArray[0]
```

#### Deserializing

Let's say we have a simple account class and gender enum:
```swift
  
  enum Gender: String {
    case male = "male"
    case female = "female"
  }
  
  class Account {
    var id: String = ""    
    var index: UInt = 0    
    var balance: String = ""
    var age: UInt = 0    
    var gender: GenderTestEnum = .male
    var name: String = ""
  }
```
and JSON like this:

```swift
 import MYJSON
 
 let testJSON: MYJSONType =[
        "id": "590c8ed16470876ae51b4bd8",                 
        "index": 0,
        "guid": "c0fcc2d9-415d-415f-a081-d9d9aedc4b9c",
        "isActive": false,
        "balance": "$1,897.29",
        "picture": "http://placehold.it/32x32",
        "age": 32,
        "eyeColor": "green",
        "name": "Fanny Hughes",
        "gender": "female",
        "company": "ZENTILITY"
]
```
We can add JSON deserialization to this class easily:
```swift
  import MYJSON
  
  extension Account: MYJSONDeserizlizable {
      init(json: MYJSON) {
            id <- json["id"]
            index <- json.number(forKey: "index").uintValue
            balance <- json["balance"]
            age <- json.number(forKey: "index").uintValue
            gender <- json["gender"]
            name <- json["name"]
      }
  }
```

and after that we can deserialize JSON into Account instance very simple and easy:
```swift
import MYJSON

let json = MYJSON(rawValue: testJSON)
let account: Account = Account.self <- json
```
or in case of ```array of dictionaries```:
```swift
import MYJSON

let jsonArray = MYJSON(rawValue: testJSON)
let account: [Account] = Account.self <- jsonArray
```
#### Serializing
Also MYJSON lib has a feature to serialize. For that we should to implement ```MYJSONSerizlizable protocol```, and specifically implement required protocol properry ```var json: MYJSON```.
Let's consider simple class Friend:
```swift
class Friend {
    var id: UInt = 0
    var name: String = ""
}
```
We can add JSON serialization to this class:
```swift
import MYJSON

extension Friend: MYJSONSerizlizable {
    var json: MYJSON {
        return MYJSON(rawValue: ["id": id, "name": name])
    }
}
```
Now we can serialize Friend instance to ```MYJSON```:
```swift
import MYJSON

let friend: Friend = <...>
let json = friend.json
```
Then we have opportunity to serialize ```MYJSON``` instance to ```Data``` using JSONSerialization extension:
```swift
import MYJSON

if let data = try? JSONSerialization.prettyPrintedData(withJSON: json) {
    // Code
}
```
