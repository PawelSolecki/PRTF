# PRTF

**Portfolio Management Application** is a project created to explore microservices architecture and seamlessly integrate multiple components into a unified system.
The application enables management of investment portfolios, user data, and provides a clear and interactive visual layer.

> This project is continuously being developed and improved to enhance its features and reliability.

## Project Structure

The project consists of several independent services communicating via REST APIs.

Below are their descriptions along with repository links:

- [_Portfolio Service_](https://github.com/PawelSolecki/PRTF-portfolio#)  
  Responsible for processing portfolio-related data.
  Allows retrieving and modifying portfolio information and collaborates with other system services.
- [_User Management Service_](https://github.com/PawelSolecki/PRTF-user-mgmt)  
  Manages user accounts, handling registration, login, and token refresh operations.
  Stores additional user data and exposes it to other services.
- [_Gateway_](https://github.com/PawelSolecki/PRTF-gateway)  
  The single entry point to the backend.
  Handles request routing, filtering, and authorization.
- [_Frontend_](https://github.com/PawelSolecki/PRTF-frontend)  
  A Single Page Application providing the system’s visual layer and interactive access to data.

## Running the Demo

This repository contains a script that launches all services and the frontend automatically.

```bash
./show_demo.sh
```

After running it, the application will be accessible at: http://localhost:3000

**Demo login credentials:**

- Email: demo@demo.com
- Password: omed

Logging in will give you access to sample data and full frontend functionality.
