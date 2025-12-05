# Canteen Management System

## Work with docker

For running the application using docker compose use the command below:

```sh
sudo docker compose up -d --build
```

If you want to build it without cache then execute the command below:

```sh
sudo docker compose down --remove-orphans
sudo docker compose build --no-cache
sudo docker compose up -d
```

For remove previous running instace execute the command below:

```sh
docker rm -f canteen_phpmyadmin
docker rm -f canteen_db
docker rm -f canteen_web

docker volume rm $(docker volume ls -q)
```

Then if try to re run this execute the command below:

```sh
docker compose down -v
docker compose up --build -d
```

### Login to database

Here you can login to the database. For that go to `http://your-ip:8081/` like `http://127.0.0.1:8081/`. Then you will ask the Username and password. There put `root` as username and no need anything to put on password feild. Then hit log in. If you follow this you can log in your database successfully.

### Access Application

For access application you will have to use `http://your-ip:7000/` like for local `http://127.0.0.1/`. Then you can see the login system for the user.
