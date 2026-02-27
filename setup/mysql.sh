

sudo pacman -S mysql

mysqld --version

# Step 4: Initialize MySQL
# Initialize the MySQL data directory before starting the server:
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql


# Step 5: Start MySQL
# Initiate the MySQL server using systemctl:
sudo systemctl start mysqld
sudo systemctl status mysqld

# Step 6: Enable MySQL
# Enable MySQL to start on system boot:
sudo systemctl enable mysqld

# Configuring MySQL
# Step 1: Secure Installation
# Run the MySQL security installation script to configure security settings:
sudo mysql_secure_installation

# Step 2: Log into MySQL
# Access the MySQL command-line interface as the root user:
sudo mysql

# Step 3: Create User
# Create a new MySQL user with the desired username and password:
CREATE USER '<username>'@'localhost' IDENTIFIED BY '<password>';

# Step 4: Grant Privileges
# Grant all privileges to the newly created user:
GRANT ALL PRIVILEGES ON *.* TO '<username>'@'localhost' WITH GRANT OPTION;

# Step 5: Flush Privileges
# Flush privileges to apply the changes and exit MySQL:
FLUSH PRIVILEGES;
exit

# Step 6: Log in with New User
# Log in to MySQL with the newly created user:

mysql -u <username> -p
# Step 7: Create Database
# Create a new database for your application:
CREATE DATABASE <dbname>;

# Step 8: Verify Databases
# List all available databases to verify the successful creation:
SHOW DATABASES;
