
If you wnat to build it without cache then execute the command below:
```sh
sudo docker compose down --remove-orphans
sudo docker compose build --no-cache
sudo docker compose up -d
```