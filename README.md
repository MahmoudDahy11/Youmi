# Youmi (悠見)

[![Flutter Version](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Isar Database](https://img.shields.io/badge/Isar-Database-FF9800?style=for-the-badge)](https://isar.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

**Youmi** is a high-performance, offline-first personal productivity application designed for power users. Built with Flutter and Isar, it provides a seamless experience for managing tasks and notes with zero latency, ensuring your data remains private and accessible regardless of connectivity.

---

## 📸 Screenshots

| Today's Tasks | Weekly Tasks |
| :---: | :---: |
| <img src="https://github.com/user-attachments/assets/26824132-034d-4f64-9cf4-1459b766cad3" width="400" /> | <img src="https://github.com/user-attachments/assets/187ae7e4-7fa9-4eda-af2e-e5676e885fd6" width="400" /> |
| *Focus on your daily goals* | *Plan your entire week ahead* |

| Note Management | Detailed Notes | Settings & Themes |
| :---: | :---: | :---: |
| <img src="https://github.com/user-attachments/assets/b5b051a8-3300-4ed0-8375-36e536e63c93" width="300" /> | <img src="https://github.com/user-attachments/assets/27652186-c08c-42b4-a7cd-9273c57ca35a" width="300" /> | <img src="https://github.com/user-attachments/assets/3aa8ed8d-dacb-40b3-a8f3-dc81b3a168a0" width="300" /> |
| *Clean notes list* | *Rich markdown support* | *Personalize your experience* |

---

## ✨ Features

- **Advanced Task Management**:
  - Intelligent filtering (Today, Weekly, Overdue).
  - Automated overdue handling and status synchronization.
  - Granular task lifecycle management.
- **Rich Note Taking**:
  - Full-text search powered by Isar's native indexing.
  - Pinning mechanism for critical information.
  - Markdown support for structured content.
- **Reminders & Notifications**:
  - Scheduled daily evening reminders for task review.
  - System-level notifications with custom scheduling logic.
- **Offline-First Excellence**:
  - ACID-compliant local persistence.
  - Instant startup and zero-latency interactions.
- **Personalization**:
  - Adaptive theme engine (Light/Dark/System).
  - Customizable notification preferences.

---

## 🛠 Tech Stack

| Category | Technology |
| :--- | :--- |
| **Framework** | [Flutter](https://flutter.dev) (SDK >= 3.2.0) |
| **Language** | [Dart](https://dart.dev) |
| **Database** | [Isar](https://isar.dev) (NoSQL) |
| **State Management** | [flutter_bloc](https://pub.dev/packages/flutter_bloc) (Cubit) |
| **Dependency Injection** | [get_it](https://pub.dev/packages/get_it) |
| **Navigation** | [go_router](https://pub.dev/packages/go_router) |
| **Local Notifications** | [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) |

---

## 🏗 Architecture Overview

Youmi follows **Clean Architecture** principles with a **Feature-Driven** structure. This ensures high testability, maintainability, and clear separation of concerns.

```mermaid
graph TD
    subgraph Presentation_Layer
        UI[Widgets/Pages] --> Cubit[Cubit State Management]
    end
    
    subgraph Domain_Layer
        Cubit --> UC[Use Cases]
        UC --> RI[Repository Interfaces]
    end
    
    subgraph Data_Layer
        RI --> RP[Repository Implementation]
        RP --> DS[Data Sources / Isar]
        RP --> MD[Models / DTOs]
    end
    
    style Domain_Layer fill:#f9f,stroke:#333,stroke-width:2px
