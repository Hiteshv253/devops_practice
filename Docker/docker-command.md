
# docker build -t lions-app .
# docker run -p 8980:80 lions-app
# docker run -d -p 8980:80 --name lions-app-container lions-app

# docker-compose up --build -d

# docker exec -it lions-app php artisan migrate
# docker exec -it lions-app composer install
# docker exec -it lions-app php artisan key:generate

# docker exec -it lions-app bash
# chown -R www-data:www-data storage bootstrap/cache
# chmod -R 775 storage bootstrap/cache
# exit

# docker exec -it lions-app php artisan config:clear
# docker exec -it lions-app php artisan view:clear
# docker exec -it lions-app php artisan cache:clear
# docker exec -it lions-app php artisan route:clear


# docker exec -it lions-app bash
# mkdir -p public/storage/sponsors
# chown -R www-data:www-data public/storage
# chmod -R 775 public/storage
# exit



## Remove 
## docker-compose down --volumes --remove-orphans

# Docker remove unwanted images
## docker image prune -f

## Remove all unused images
## docker image prune -a

## docker system prune -a --volumes


# Remove build cache too
# docker builder prune -a
