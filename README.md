# Supermarket Layout Optimizer

A Java-based optimization engine designed to maximize cross-selling in retail environments. The system calculates the optimal distribution of products on a circular shelf based on the degree of similarity or relationship between pairs of products, maximizing the probability that customers buy related items.

## 🚀 Features

* **Advanced Layout Calculation:** Includes two core algorithms to find the optimal distribution: a baseline algorithm (brute-force/greedy) and an advanced approximation algorithm for complex datasets.
* **Dynamic Configuration:** Allows interactive configuration of algorithm parameters to fine-tune the optimization process.
* **Custom Modifications:** Supports manual overrides and modifications of the proposed optimal solution.
* **Data Integration:** Flexible data ingestion, allowing product metrics to be defined interactively or imported from standard text files.

## 🛠️ Tech Stack
* **Language:** Java
* **Testing:** JUnit
* **Build System:** Makefile 

## ⚙️ Getting Started

### Prerequisites
Make sure you have Java and `make` installed on your local system.

### Running the Application

You can easily compile and run the application using the provided `Makefile` system:

* **Compile the project:**
  ```bash
  make all
