FROM node:19-alpine AS sahithi

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies

RUN npm install

# Copy source code
COPY . .

# Build app
RUN npm run build

# Expose port
EXPOSE 3000

FROM node:19-alpine AS final

WORKDIR /app

# Copy built application from previous stage
COPY --from=sahithi /app .

# Install only production dependencies
RUN npm install --production

# Start application
CMD ["npm", "start"]
