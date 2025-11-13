# 1️⃣ Etapa de build con Maven y JDK 17
FROM eclipse-temurin:17-jdk-alpine AS build

WORKDIR /app

# Copiamos pom.xml y código fuente
COPY pom.xml .
COPY src ./src

# Compilamos y empaquetamos el JAR (sin tests)
RUN ./mvnw clean package -DskipTests || mvn clean package -DskipTests

# 2️⃣ Etapa final con JRE 17 para correr la app
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copiamos el JAR desde la etapa de build y renombramos a adso.jar
COPY --from=build /app/target/adso-0.0.1-SNAPSHOT.jar adso.jar

# Exponemos el puerto de Spring Boot
EXPOSE 8080

# Comando para ejecutar la aplicación
ENTRYPOINT ["java","-jar","adso.jar"]
