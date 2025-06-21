# University_Exzamen
Examen project 

Description

Project Portfolio is a SwiftUI-based iOS application that allows users to register, log in, and manage their projects. Users can create, view, edit, and delete projects, each with a title, description, optional GitHub link, optional image, and an automatically assigned author (based on the logged-in user's username). The app uses a custom API for authentication and project data storage, with token-based authentication and multipart/form-data for image uploads.

Features





Authentication: Register and log in with email, password, and username (for registration).



Project Management:





View a list of projects with title, description, image (if available), GitHub link (if available), and author.



Add new projects with a title, description, optional GitHub link, and optional image.



Edit existing projects to update title, description, GitHub link, or image.



Delete projects from the list.



UI: Clean SwiftUI interface with navigation, forms, and image picking from the photo library.



Networking: Communicates with a custom API using URLSession for CRUD operations and image uploads.

Prerequisites





Xcode: Version 16 or later.



iOS: Compatible with iOS 15 or later.



Backend API: A custom API with endpoints for authentication (/auth/register, /auth/login) and project management (/projects, /projects/:id for GET, POST, PUT, DELETE).
Setup Instructions

Follow these steps to set up and run the app locally.

1. Clone the Repository

git clone https://github.com/... .git

2. Configure the API





Update the baseURL in ContentView.swift (inside APIService) to point to your API:

private let baseURL = ""



Ensure your API supports the following endpoints:





POST /auth/register: Accepts email, password, username; returns a token and user data (id, username, email).



POST /auth/login: Accepts email, password; returns a token and user data.



GET /projects: Returns an array of projects for the authenticated user.



POST /projects: Creates a project with title, description, optional githubLink, optional image (multipart/form-data); returns the created project.



PUT /projects/:id: Updates a project with the same fields as POST; returns the updated project.



DELETE /projects/:id: Deletes a project; returns a success status (e.g., 204).



If using a mock API for testing:





Install json-server:

npm install -g json-server



Create a db.json file with sample data (see Sample Data).



Run the mock API:

json-server --watch db.json



Update baseURL to http://localhost:3000.

3. Add Photo Library Permission





Add the following to your Info.plist to enable image picking:

<key>NSPhotoLibraryUsageDescription</key>
<string>Allow access to select project images</string>

4. Open in Xcode





Open the project in Xcode:

open ProjectPortfolio.xcodeproj



Select your target device or simulator (iOS 15 or later).



Build and run the app (Cmd + R).

5. Test the App





Authentication: Use the login or sign-up screen to authenticate. For testing with a mock API, use sample credentials (e.g., email: test@example.com, password: test123, username: test_user).



Projects: View, add, edit, or delete projects. 



Previews: Use Xcode's preview canvas to test the UI with mock data (see ContentView_Previews in ContentView.swift).

