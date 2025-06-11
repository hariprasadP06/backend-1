FROM node:22.1.0

WORKDIR /app

# Only copy package.json and lock file first to cache layer
COPY package*.json ./

# Install dependencies first
RUN npm install

# Copy the rest of the application
COPY . .

# Prisma generate (optional, safe)
RUN if [ -f "./prisma/schema.prisma" ]; then npx prisma generate; fi

# Ensure build script exists
RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]
