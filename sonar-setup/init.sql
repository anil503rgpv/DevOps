-- init.sql

-- Create schema
CREATE SCHEMA IF NOT EXISTS sonarqube;

-- Grant permissions to JDBC user on the schema
GRANT ALL PRIVILEGES ON SCHEMA sonarqube TO sonar;

-- Grant permissions to JDBC user on existing and future tables, indices, and triggers in the schema
ALTER DEFAULT PRIVILEGES IN SCHEMA sonarqube
  GRANT ALL PRIVILEGES ON TABLES TO sonar;

ALTER DEFAULT PRIVILEGES IN SCHEMA sonarqube
  GRANT ALL PRIVILEGES ON SEQUENCES TO sonar;

ALTER DEFAULT PRIVILEGES IN SCHEMA sonarqube
  GRANT ALL PRIVILEGES ON FUNCTIONS TO sonar;

ALTER DEFAULT PRIVILEGES IN SCHEMA sonarqube
  GRANT ALL PRIVILEGES ON TYPES TO sonar;
