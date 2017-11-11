---
layout: post
wiki: true
published: true
title: Code Examples
permalink: wiki/code-examples
description: Examples per API Method
---
## Usage

Here we present you the code examples of the library per API Method:

* [initSession()](#iS)
* [killSession()](#kS)
* [getMyProfiles()](#gMP)
* [getActiveProfile()](#gAP)
* [changeActiveProfile()](#cAP)
* [getMyEntities()](#gME)
* [getActiveEntities()](#gAE)
* [changeActiveEntities()](#cAE)
* [getFullSession()](#gFS)
* [getItem()](#gI)
* [getAllItems()](#gAI)
* [getSubItems()](#gSI)

## Examples

* <a name="iS"></a> initSession(): this is an example of how to init session using the API Client.

    * initSessionByUserToken: in this case you only require the user token

```swift
GlpiRequest.initSessionByUserToken(userToken: "L8B3f4iiNIjg8W2Kla1AXFjJsYrWxVqDozMzq2G7") { data, _, _ in
            self.responseAPI = [AnyObject]()
            self.loadResponse(endpoint: "initSession", result: self.objectToString(data as Any))
        }
```

* <a name="kS"></a> killSession(): close the user session

```swift
GlpiRequest.killSession(completion: { data, _, _ in
            self.responseAPI = [AnyObject]()
            self.loadResponse(endpoint: "killSession", result: self.objectToString(data as Any))
        }
```

* <a name="gMP"></a> getMyProfiles(): return the profiles associated to the user

```swift
GlpiRequest.getMyProfiles { data, _, _ in
            self.loadResponse(endpoint: "getMyProfiles", result: self.objectToString(data as Any))
        }
```

* <a name="gAP"></a> getActiveProfile(): return the current active profile

```swift
GlpiRequest.getActiveProfile { data, _, _ in
            self.loadResponse(endpoint: "getActiveProfile", result: self.objectToString(data as Any))
        }
```

* <a name="cAP"></a> changeActiveProfile(): change active profile to one of the profiles obtained with 'getMyProfiles()'

```swift
GlpiRequest.changeActiveProfile(profileID: "4", completion: { _, _, _ in
            self.loadResponse(endpoint: "changeActiveProfile", result: "")
        })
```

* <a name="gME"></a> getMyEntities(): return all the possible entities of the current logged user

```swift
GlpiRequest.getMyEntities { data, _, _ in
            self.loadResponse(endpoint: "getMyEntities", result: self.objectToString(data as Any))
        }
```

* <a name="gAE"></a> getActiveEntities(): return active entities of current logged user

```swift
GlpiRequest.getActiveEntities { data, _, _ in
            self.loadResponse(endpoint: "getActiveEntities", result: self.objectToString(data as Any))
        }
```

* <a name="cAE"></a> changeActiveEntities(): change active entity to one of the entities obtained with 'getMyEntities'

```swift
GlpiRequest.changeActiveEntities(entitiesID: "0", completion: { data, _, _ in
            self.loadResponse(endpoint: "changeActiveEntities", result: self.objectToString(data as Any))
        })
```

* <a name="gFS"></a> getFullSession(): return the current php $_SESSION

```swift
GlpiRequest.getFullSession { data, _, _ in
            self.loadResponse(endpoint: "getFullSession", result: self.objectToString(data as Any))
        }
```

* <a name="gI"></a> getItem(): return the instance fields of itemtype identified by id

```swift
GlpiRequest.getItem(itemType: .Computer, itemID: 3, queryString: nil) { data, _, _ in
            self.loadResponse(endpoint: "getAnItem", result: self.objectToString(data as Any))
        }
```

* <a name="gAI"></a> getAllItems(): return a collection of rows of the itemtype

```swift
GlpiRequest.getAllItems(itemType: .Computer, queryString: nil) { data, _, _ in
            self.loadResponse(endpoint: "getAllItems", result: self.objectToString(data as Any))
        }
```

* <a name="gSI"></a> getSubItems(): return a collection of rows of the sub_itemtype for the identified item

```swift
GlpiRequest.getSubItems(itemType: .Computer, itemID: 3, subItemType: .ComputerModel, queryString: nil) { data, _, _ in
            self.loadResponse(endpoint: "getSubItems", result: self.objectToString(data as Any))
        }
```

For more information about the functions check our [Code Documentation](https://glpi-project.github.io/swift-library-glpi/docs/) section


