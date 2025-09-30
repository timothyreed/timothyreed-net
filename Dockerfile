# Use nginx alpine as base image
FROM nginx:alpine

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy all files to nginx html directory
COPY --chown=nginx:nginx . /usr/share/nginx/html/

# Ensure proper permissions
RUN chmod -R 755 /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx (default CMD from base image)
CMD ["nginx", "-g", "daemon off;"]
