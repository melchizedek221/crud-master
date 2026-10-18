# 🎬 Movie Streaming Platform Microservices

Welcome to the **Movie Streaming Platform**! This project sets up a microservices architecture with an **API Gateway**, an **Inventory API**, and a **Billing API**. The Inventory API handles movie data while the Billing API processes payments through RabbitMQ.

## 🚀 Project Overview

This project is designed to facilitate modular service deployment for a movie streaming platform:

- **Inventory API**: Manages movie details stored in a PostgreSQL database.
- **Billing API**: Processes payments via RabbitMQ without direct database interactions.
- **API Gateway**: Routes requests to the appropriate services, ensuring seamless communication.


## 📦 Prerequisites

Before you begin, ensure you have the following tools installed:

- Python 3 (with Flask, SQLAlchemy, and other packages)
- PostgreSQL
- RabbitMQ
- Postman
- VirtualBox or VMware
- Vagrant

## 🛠️ Project Structure

Here's a breakdown of the project structure:

```
.
├── README.md
├── config.yaml
├── .env
├── scripts
│   └── [...]
├── srcs
│   ├── api-gateway
│   │   ├── app
│   │   │   ├── __init__.py
│   │   │   └── ...             
│   │   ├── requirements.txt
│   │   └── server.js
│   ├── billing-app
│   │   ├── app
│   │   │   ├── __init__.py
│   │   │   └── ...             
│   │   ├── requirements.txt
│   │   └── server.js
│   └── inventory-app
│       ├── app
│       │   ├── __init__.py
│       │   └── ...             
│       ├── requirements.txt
│       └── server.py
└── Vagrantfile
```

## 📜 API Endpoints

### Inventory API

- **Base URL**: `http://localhost:8080/api/movies`

| Method | Endpoint              | Description                                   |
|--------|----------------------|-----------------------------------------------|
| GET    | /api/movies          | Retrieve all movies.                          |
| GET    | /api/movies?title=[name] | Retrieve movies by title.                   |
| POST   | /api/movies          | Create a new movie entry.                     |
| DELETE | /api/movies          | Delete all movies in the database.           |
| GET    | /api/movies/:id      | Retrieve a single movie by ID.                |
| PUT    | /api/movies/:id      | Update a single movie by ID.                  |
| DELETE | /api/movies/:id      | Delete a single movie by ID.                  |

### Billing API

- **Message Format**:
```json
{
  "user_id": "3",
  "number_of_items": "5",
  "total_amount": "180"
}
```

- Messages will be sent to the `billing_queue` in RabbitMQ.

## 📦 Environment Variables

To streamline the configuration process, create a `.env` file with the following variables:

```plaintext
# Database credentials for movies_db
MOVIES_DB_URL=...

# Database credentials for billing_db
BILLING_DB_URL=...

# RabbitMQ settings
RABBITMQ_URL=...
```

> **Note:** Ensure to replace `...` with actual credentials.

## 🚀 Running the Project

To start the project, navigate to the root of the project and run:

```bash
vagrant up
```

This command will initialize all three virtual machines:

- **gateway-vm**: Contains the API Gateway.
- **inventory-vm**: Contains the Inventory API and movies database.
- **billing-vm**: Contains the Billing API, orders database, and RabbitMQ.

### 🌐 Testing the APIs

You can use Postman to test the APIs:

1. Import the Postman collection.
2. Execute requests to the endpoints defined above.
3. Monitor responses and validate functionality.

## 📜 API Documentation

Documentation for the API Gateway will be available via OpenAPI specifications. Consider using [SwaggerHub](https://swagger.io/tools/swaggerhub/) for comprehensive documentation.

## ✨ Conclusion

This project aims to provide a robust, scalable, and modular microservices architecture for a movie streaming platform. Feel free to explore and modify it as per your requirements.

## 📝 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Happy coding! 🎉

## ✍️ Authors

This project was developed by:

- **[djibsow]** - [gitea](https://learn.zone01dakar.sn/git/djibsow)
- **[osamb]** - [gitea](https://learn.zone01dakar.sn/git/osamb)

