# Generated by https://smithery.ai. See: https://smithery.ai/docs/config#dockerfile
# Use a Node.js base image that supports bun installation
FROM node:18-alpine as builder

# Install bun
RUN npm install -g bun

# Set the working directory
WORKDIR /app

# Copy package and lock files
COPY package.json bun.lockb ./

# Install dependencies using bun
RUN bun install

# Copy the rest of the application
COPY . .

# Build the application
RUN bun run build

# Create a release image
FROM node:18-alpine

# Install bun
RUN npm install -g bun

# Set the working directory
WORKDIR /app

# Copy built files from builder
COPY --from=builder /app/dist /app/dist

# Set the command to run the server
ENTRYPOINT ["node", "/app/dist/index.js"]
