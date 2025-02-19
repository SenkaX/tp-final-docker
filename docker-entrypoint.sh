#!/bin/sh

if [ ! -f .env ]; then
  cp .env.example .env
fi

# php artisan key:generate
php artisan migrate:fresh --seed

exec "$@"