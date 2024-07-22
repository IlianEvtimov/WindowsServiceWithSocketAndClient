# WindowsServiceWithSocketAndClient

**Project Description:**

`WindowsServiceWithSocketAndClient` is a project designed to demonstrate how to create a Windows service that uses sockets for communication with a client application. This project includes both the server part (Windows service) and a client application that connects to the service via the TCP/IP protocol.

**Installation:**
- Open the folder WindowsService\Win32\Release.
- Open cmd as an administrator.
- Open the project in cmd by navigating to: ../WindowsService\Win32\Release.
- Type the command: WindowsService.exe /install.
- Press Enter, and you should see a message indicating that the service has been successfully installed.
- Now find the Windows service in services named "Update VCL UI with Socket" and start it.
- Open the folder ..\Client\Win32\Release and run the executable. The client application will automatically connect to the port of the Windows service.

**Main Features:**

- **Windows Service:** The server part of the project runs as a Windows service, listening on a specified TCP port and accepting connections from clients.
- **Client Application:** The client-side application connects to the server service and allows sending and receiving messages.
- **Socket Communication:** Utilizes sockets for bidirectional communication between the client and the server.
- **Error Handling:** Built-in error handling to manage connection states and retry attempts.
- **Easy Configuration:** Configurable settings for IP address and port that can be easily modified.

**Installation and Usage:**

1. **Compile the Project:**
   - Clone the repository.
   - Open the project with Delphi or your preferred IDE.
   - Compile and install the Windows service.
   - Compile the client application.

2. **Setup the Windows Service:**
   - Register the service using the command line or an installer.
   - Start the service via `services.msc` or the command line.

3. **Use the Client Application:**
   - Run the client application.
   - Enter the IP address and port to which you want to connect.
   - Begin communication with the server service.

**Use Cases:**

- **Monitoring and Managing System Resources:** Creating monitoring services that collect data from multiple clients.
- **Notification Systems:** Building real-time notification systems between various components of the software infrastructure.
- **Device Management:** Developing services for communication with IoT devices and sensors.

**Contributing:**

Contributions to this project are welcome. Please fork the repository and submit a pull request with your proposed changes. Ensure your changes are well-documented and tested.
