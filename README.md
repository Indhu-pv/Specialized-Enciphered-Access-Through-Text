# Specialized Enciphered Access Through Text Steganography

A secure healthcare document management system that protects sensitive patient medical reports using Text Steganography, Encryption, and Role-Based Access Control.

This project allows doctors to securely upload confidential patient reports and ensures that only authorized patients can extract and decrypt the hidden medical data safely.

## Features

- Doctor and Patient Role-Based Login
- Secure User Registration and Authentication
- Medical Report Upload by Doctor
- Patient-Specific Secure Report Sharing
- Text Steganography for Hidden Data Transfer
- AES-Based Encryption and Decryption
- Real-Time Extract and Decrypt Functionality
- Secure Storage of Confidential Medical Data
- JSP-Based Dashboard for Doctor and Patient

## Tech Stack

### Frontend
- JSP
- HTML
- CSS
- JavaScript
- AJAX

### Backend
- Java
- J2EE
- Servlets
- JDBC

### Database
- MySQL

### Server
- Apache Tomcat 9

### Build Tool
- Maven

## Project Workflow

1. Doctor and Patient register in the system.

2. Doctor logs in and uploads the medical report using the patient’s registered email.

3. Sensitive medical data is encrypted and hidden using Text Steganography.

4. Patient logs in and views the received documents.

5. Patient clicks "Extract Steganography Payload & Decrypt" to securely retrieve the original medical data.

## How to Run

### 1. Clone the Repository

git clone https://github.com/Indhu-pv/Specialized-Enciphered-Access-Through-Text.git

### 2. Setup Database

Run the database.sql file in MySQL.

mysql -u root -p < database.sql

### 3. Build the Project

mvn clean install

This generates:

target/SecureCare.war

### 4. Deploy to Tomcat

Copy SecureCare.war into:

apache-tomcat-9/webapps/

### 5. Start Tomcat

Run:

startup.bat

from:

apache-tomcat-9/bin

### 6. Open in Browser

http://localhost:8080/SecureCare

## Author

Indhu P  
Final Year Project
