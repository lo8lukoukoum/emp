-- Create a database for an employment registration system
CREATE DATABASE employment_registration_system;

-- Use the created database
USE employment_registration_system;

-- Create a table for job seekers
CREATE TABLE job_seekers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    resume VARCHAR(255) NOT NULL, -- Path to the resume file
    skills TEXT, -- Comma-separated list of skills
    experience TEXT, -- Description of work experience
    education TEXT, -- Description of educational background
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create a table for employers
CREATE TABLE employers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(255) NOT NULL,
    industry VARCHAR(100),
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    company_description TEXT,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create a table for job listings
CREATE TABLE job_listings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    employer_id INT,
    job_title VARCHAR(255) NOT NULL,
    job_description TEXT NOT NULL,
    required_skills TEXT,
    salary_range VARCHAR(100),
    location VARCHAR(100),
    posted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employer_id) REFERENCES employers(id)
);

-- Create a table for applications
CREATE TABLE applications (
    id INT PRIMARY KEY AUTO_INCREMENT,
    job_seeker_id INT,
    job_listing_id INT,
    application_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    cover_letter TEXT,
    status VARCHAR(50) DEFAULT 'Pending', -- e.g., Pending, Shortlisted, Rejected, Hired
    FOREIGN KEY (job_seeker_id) REFERENCES job_seekers(id),
    FOREIGN KEY (job_listing_id) REFERENCES job_listings(id)
);

-- Insert some sample data for job seekers
INSERT INTO job_seekers (full_name, email, phone_number, resume, skills, experience, education) VALUES
('John Doe', 'john.doe@example.com', '123-456-7890', 'path/to/resume1.pdf', 'Java, Python, SQL', '5 years of experience in software development', 'Bachelor of Science in Computer Science'),
('Jane Smith', 'jane.smith@example.com', '987-654-3210', 'path/to/resume2.pdf', 'Marketing, SEO, Content Creation', '3 years of experience in digital marketing', 'Master of Business Administration');

-- Insert some sample data for employers
INSERT INTO employers (company_name, industry, email, phone_number, company_description) VALUES
('Acme Corp', 'Technology', 'hr@acme.com', '555-123-4567', 'A leading technology company specializing in software solutions.'),
('Globex Corporation', 'Manufacturing', 'careers@globex.com', '555-987-6543', 'A global manufacturing company with a focus on innovation.');

-- Insert some sample data for job listings
INSERT INTO job_listings (employer_id, job_title, job_description, required_skills, salary_range, location) VALUES
(1, 'Software Engineer', 'We are looking for a skilled software engineer to join our team.', 'Java, Spring Boot, REST APIs', '$80,000 - $100,000', 'New York, NY'),
(2, 'Marketing Manager', 'We are seeking an experienced marketing manager to lead our marketing efforts.', 'Digital Marketing, SEO, Social Media', '$70,000 - $90,000', 'San Francisco, CA');

-- Insert some sample data for applications
INSERT INTO applications (job_seeker_id, job_listing_id, cover_letter) VALUES
(1, 1, 'I am very interested in the Software Engineer position at Acme Corp...'),
(2, 2, 'I am excited to apply for the Marketing Manager position at Globex Corporation...');

-- Retrieve all job seekers
SELECT * FROM job_seekers;

-- Retrieve all job listings
SELECT * FROM job_listings;

-- Retrieve applications for a specific job listing
SELECT js.full_name, js.email, a.application_date, a.status
FROM applications a
JOIN job_seekers js ON a.job_seeker_id = js.id
WHERE a.job_listing_id = 1;
