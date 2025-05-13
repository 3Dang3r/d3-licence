CREATE TABLE IF NOT EXISTS player_dlicenses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    citizenid VARCHAR(50) NOT NULL,
    license_type VARCHAR(20) NOT NULL,
    UNIQUE KEY unique_license (citizenid, license_type)
);