#  parseTemplate - iOS Photo Sharing App

`parseTemplate` is a full-featured iOS social media application built with Swift, adopting the MVVM architecture, and leveraging Parse Server (Back4App) for backend services. It enables users to authenticate, upload photos with custom captions, view a real-time feed, and maintain local session state.

---

##  Screenshots

| Login & Sign Up | Error Alert | Photo Selection |
| :---: | :---: | :---: |
| <img src="screenshots/HomeVC_4.png" width="220"> | <img src="screenshots/SignUpError.png" width="220"> | <img src="screenshots/imageSelected.png" width="220"> |

| Upload Post | Success Alert | Main Feed |
| :---: | :---: | :---: |
| <img src="screenshots/uploadPost.png" width="220"> | <img src="screenshots/uploadPostSuccess.png" width="220"> | <img src="screenshots/FeedVC2.png" width="220"> |

---

##  Features

* **User Authentication & Session Management:**
  * User Registration (**Sign Up**) and Login (**Log In**) via Parse User module
  * Persistent user sessions using **UserDefaults** (remembers logged-in status across app restarts)
  * Dynamic validation and custom alert dialogs for error handling
  * Secure **Log Out** functionality with session clearing
* **Media & Post Creation:**
  * Photo selection from device library using `PHPickerViewController` / `UIImagePickerController`
  * Image compression and conversion for cloud storage
  * Attach custom text captions/comments to posts
  * File and data upload directly to Back4App cloud storage (`PFFileObject` & `PFObject`)
* **Main Feed & Real-time Content:**
  * Display shared posts in a structured feed including author username, post image, and caption
  * Dynamic data fetching and UI updating from Parse database

---

##  Tech Stack & Dependencies

* **Language:** Swift
* **Architecture:** MVVM (Model-View-ViewModel)
* **UI Framework:** UIKit, Custom TabBar Controller, Storyboards & Custom Views
* **Local Data Persistence:** `UserDefaults` (Local session tracking & user state retention)
* **Backend Platform:** Back4App / Parse Server
* **Third-Party Libraries & SDKs:**
  * `Parse` (Parse-Swift) - Complete backend integration (Authentication, Cloud Database, File Storage)
  * `IQKeyboardManagerSwift` - Automatic keyboard presentation & text field adjustment
* **Security & Environment Management:** `Config.xcconfig` for securing sensitive Application IDs, Client Keys, and Server URLs outside of source control

---

##  Installation & Setup

1. Clone the repository:
   ```bash
   git clone [https://github.com/MelikeS28/parseTemplate.git](https://github.com/MelikeS28/parseTemplate.git)
