# Use Node 18 Alpine as base
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy only package files first (for caching dependencies)
COPY package*.json ./

# Install dependencies (production only) without Git metadata issues
RUN npm install --only=production

# Copy the rest of the application code
COPY . .

# Expose the port your app listens on
EXPOSE 5000

# Healthcheck to ensure container is alive
HEALTHCHECK --interval=10s --timeout=3s --start-period=5s \
  CMD wget -qO- http://localhost:5000/ || exit 1

# Run the application
CMD ["node", "index.js"]
