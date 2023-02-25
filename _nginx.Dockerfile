# escape=\
FROM nginx:1.22.1

# Copy nginx config file
COPY ["nginx config/nginx.conf", "/etc/nginx/"]
COPY ["nginx config/default.conf", "/etc/nginx/conf.d"]

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]