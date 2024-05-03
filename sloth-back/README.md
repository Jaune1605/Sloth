# Sloth Backend

Sloth Backend est une API REST conçue avec Spring Boot, sécurisée via Keycloak et utilisant MongoDB comme base de données. Ce projet est destiné à gérer des solutions à des problèmes spécifiques, permettant aux utilisateurs d'interagir avec les données de manière sécurisée.

## Fonctionnalités

- **Spring Boot**: Framework de développement pour des applications Java plus rapides et plus accessibles.
- **MongoDB**: Base de données NoSQL pour une flexibilité et une scalabilité optimales.
- **Keycloak**: Système de gestion de l'authentification et de l'autorisation pour une sécurité renforcée.

## Configuration

### MongoDB

- **Base de données**: `slothDatabase`
- **URI de connexion**: Spécifiée dans `application.properties` pour se connecter à l'instance MongoDB.

### Keycloak

- **URL du serveur d'authentification**: Configuré pour pointer sur l'instance Keycloak.
- **Royaume**: `external`
- **Client ID**: `external-client`

### Spring Boot

- **Port**: 8080 (par défaut)
- **Dépendances principales**: Spring Web, Spring Data MongoDB, Spring Security, OAuth2 Resource Server.

## Démarrage rapide

1. **Cloner le dépôt**:
   Editez le fichier src/main/resources/application.properties pour mettre à jour les configurations MongoDB et Keycloak.

2. **Configurer les propriétés de l'application:**:
   ```bash
   git clone https://example.com/sloth-backend.git
   cd sloth-backend

3. **Lancer l'application:**:
   Utilisez Maven pour démarrer l'application :
   './mvnw spring-boot:run'

4. **Accéder à l'API:**:
    Ouvrez http://localhost:8080/api dans votre navigateur ou utilisez un client API comme Postman pour tester les endpoints.


## API Endpoints

- **POST /api/problems**: Soumettre un nouveau problème.
- **GET /api/solutions**: Récupérer toutes les solutions.
- **POST /api/solutions**: Ajouter une nouvelle solution.

## Sécurité

Utilisez Keycloak pour configurer les utilisateurs, les rôles et les politiques d'accès. Assurez-vous que les utilisateurs sont correctement authentifiés et autorisés avant d'accéder aux endpoints critiques de l'API.

## Dépendances

- Spring Boot Starter Web
- Spring Boot Starter Data MongoDB
- Spring Boot Starter Security
- Keycloak Spring Boot Adapter
- OAuth2 Resource Server


