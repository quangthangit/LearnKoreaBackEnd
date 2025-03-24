# --- Build Stage ---
FROM ubuntu:latest AS build

# Cập nhật và cài đặt JDK & Maven
RUN apt-get update && apt-get install -y openjdk-17-jdk maven

# Đặt thư mục làm việc
WORKDIR /app

# Copy toàn bộ source code vào container
COPY . .

# Build project với Maven
RUN mvn clean package -DskipTests

# --- Run Stage ---
FROM openjdk:17-jdk-slim

# Expose cổng 8080
EXPOSE 8080

# Copy file JAR từ build stage
COPY --from=build /app/target/*.jar app.jar

# Chạy ứng dụng
ENTRYPOINT ["java", "-jar", "app.jar"]
