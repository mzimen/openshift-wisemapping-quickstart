CREATE DATABASE wisemapping CHARACTER SET='utf8' COLLATE='utf8_unicode_ci';
CREATE USER 'wisemapping'@'127.0.0.1' IDENTIFIED BY 'password';
CREATE USER 'admin'@'127.0.0.1' IDENTIFIED BY 'RtpGzRgv7Ndv';
GRANT ALL ON wisemapping.* TO 'wisemapping'@'127.0.0.1';
GRANT ALL ON wisemapping.* TO 'admin'@'127.0.0.1';
