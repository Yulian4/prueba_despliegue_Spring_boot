# 1️⃣ Etapa de build con Maven incluido
FROM maven:3.9.3-eclipse-temurin-17 AS build

WORKDIR /app

# Copiamos pom.xml y código fuente
COPY pom.xml .
COPY src ./src

# Compilamos y empaquetamos el JAR (sin tests)
RUN mvn clean package -DskipTests

# 2️⃣ Etapa final con JRE 17 para correr la app
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copiamos el JAR desde la etapa de build y renombramos a adso.jar
COPY --from=build /app/target/adso-0.0.1-SNAPSHOT.jar adso.jar

# Exponemos el puerto de Spring Boot
EXPOSE 8080

# Comando para ejecutar la aplicación
ENTRYPOINT ["java","-jar","adso.jar"]
