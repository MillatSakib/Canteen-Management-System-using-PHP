# Canteen Management System

This is a web-based application for managing a canteen. It allows customers to order food, and administrators to manage products, orders, and users.

## File Structure

The project is organized as follows:

```
.
├── admin
│   ├── addProduct.php
│   ├── config.php
│   ├── customers.php
│   ├── dashboard.php
│   ├── deleteProduct.php
│   ├── deleteUser.php
│   ├── feedback.php
│   ├── foodModify.php
│   ├── makeAdmin.php
│   ├── orders.php
│   ├── products.php
│   ├── query-execution.php
│   ├── reports.php
│   ├── script.js
│   ├── statusUpdate.php
│   ├── style.css
│   ├── update_order_status.php
│   └── userManage.php
├── assets
│   └── style.css
├── auth
│   ├── login.php
│   ├── logout.php
│   └── register.php
├── config
│   └── db.php
├── db
│   └── canteen_management_system (1).sql
├── .htaccess
├── docker-compose.yml
├── Dockerfile
├── feedback.php
├── index.php
├── orderFood.php
├── status.php
├── user_home.php
└── viewCart.php
```

- **`/admin`**: Contains the administrator-facing pages for managing the system.
- **`/assets`**: Contains static files like CSS.
- **`/auth`**: Contains the authentication logic for user login, logout, and registration.
- **`/config`**: Contains the database connection configuration.
- **`/db`**: Contains the database dump file.
- **`docker-compose.yml`**: Defines the services, networks, and volumes for Docker.
- **`Dockerfile`**: Contains the instructions for building the Docker image.
- **`index.php`**: The main entry point of the application.
- **Other `.php` files**: Various pages for the user-facing part of the application.

## Deployment

This application is containerized using Docker. To deploy it, you will need to have Docker and Docker Compose installed.

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/MillatSakib/Canteen-Management-System-using-PHP.git
    ```

2.  **Navigate to the project directory:**

    ```bash
    cd Canteen-Management-System-using-PHP/

    ```

3.  **Build and run the containers:**
    ```bash
    sudo docker compose up -d --build
    ```

This will start the application and the database services. The application will be accessible at `http://server-ip:8080`.

4. **For stop the server use the command below**

```sh
 sudo docker compose down
```

5.  **Then you can delete the image of the container using the command below:**

```sh
sudo docker rmi test-web:latest
```

## Database

The database schema is provided in the `db/canteen_management_system (1).sql` file. When you run `docker-compose up`, a MySQL service is started and the database is created. The SQL dump file is not automatically imported.

To set up the database:

1.  **Access the MySQL container:**

    ```bash
    docker-compose exec -T db mysql -u root -p root
    ```

2.  **Create the database:**

    ```sql
    CREATE DATABASE Canteen_Management_System;
    ```

3.  **Import the database schema:**
    ```bash
    docker-compose exec -T db mysql -u root -proot Canteen_Management_System < db/'canteen_management_system (1).sql'
    ```
