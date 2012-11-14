CREATE DATABASE wisemapping CHARACTER SET='utf8' COLLATE='utf8_unicode_ci';
CREATE USER 'wisemapping'@'127.0.0.1' IDENTIFIED BY 'password';
GRANT ALL ON wisemapping.* TO 'wisemapping'@'127.0.0.1';
