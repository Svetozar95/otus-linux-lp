# Используем базовый образ Alpine с Nginx
FROM nginx:alpine

# Копируем кастомную страницу в директорию по умолчанию, где лежат файлы сайта nginx
COPY index.html /usr/share/nginx/html/index.html




# При желании, можно добавить дополнительную конфигурацию Nginx
# COPY nginx.conf /etc/nginx/nginx.conf

# Определяем порт, который будет экспонирован из контейнера
EXPOSE 80