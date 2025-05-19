CREATE TABLE if NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    type ENUM('donor', 'volunteer','beneficiary','admin') NOT NULL,
    role ENUM('super_admin', 'donations_admin', 'payment_admin', 'user') DEFAULT 'user',
    email VARCHAR(100) NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    login_type ENUM('email', 'social') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    skills TEXT NOT NULL,
    availability ENUM('available', 'unavailable', 'busy') DEFAULT 'available',
    hours_worked INT DEFAULT 0
);

CREATE TABLE if NOT EXISTS donations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    donorId Int Null,
    donor_name VARCHAR(100),
    donation_type ENUM('online', 'check', 'in-kind', 'product', 'service') NOT NULL,
    amount DECIMAL(10, 2),            -- For money donations
    product_name VARCHAR(100),        -- For product donations
    service_description TEXT,         -- For service donations
    state ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (donorId) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    location VARCHAR(255) NOT NULL,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_deleted TINYINT(1) DEFAULT 0
);
/* events need price */
/* add certificates table */
/*  */

CREATE TABLE tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NULL,
    name VARCHAR(255) NOT NULL,
    required_skill VARCHAR(255) NOT NULL,
    is_completed TINYINT(1) DEFAULT 0,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_deleted TINYINT(1) DEFAULT 0,
    assigned_to INT NULL,
    hours INT NULL,
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE SET NULL,
    FOREIGN KEY (assigned_to) REFERENCES users(id) ON DELETE SET NULL

);

/* tasks need hours */
CREATE TABLE event_registrations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    event_id INT NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_attended TINYINT(1) DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (event_id) REFERENCES events(id)
);



CREATE TABLE action_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    entity_type ENUM('task', 'event') NOT NULL,
    action_type ENUM('add', 'edit', 'delete') NOT NULL,
    entity_id INT NOT NULL,
    entity_data JSON NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE beneficiary_needs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    beneficiary_id INT NOT NULL,
    description TEXT NOT NULL, -- JSON-encoded needs
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    state ENUM('requested', 'approved', 'fulfilled', 'cancelled') DEFAULT 'requested',
    FOREIGN KEY (beneficiary_id) REFERENCES users(id)
);
