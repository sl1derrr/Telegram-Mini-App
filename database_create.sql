-- Таблица пользователей
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    telegram_id BIGINT UNIQUE,
    username VARCHAR(100),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    height INT COMMENT 'Рост в см',
    weight DECIMAL(5,2) COMMENT 'Вес в кг',
    age INT,
    gender ENUM('male', 'female', 'other'),
    fitness_level ENUM('beginner', 'intermediate', 'advanced'),
    goal ENUM('weight_loss', 'muscle_gain', 'maintenance', 'endurance')
);

-- Таблица сна
CREATE TABLE IF NOT EXISTS sleep_records (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    date DATE NOT NULL,
    sleep_time TIME NOT NULL COMMENT 'Время отхода ко сну',
    wake_time TIME NOT NULL COMMENT 'Время пробуждения',
    sleep_duration DECIMAL(4,2) COMMENT 'Продолжительность сна в часах',
    quality TINYINT(1) COMMENT 'Оценка качества сна (1-10)',
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Таблица тренировок
CREATE TABLE IF NOT EXISTS workouts (
    workout_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    duration_minutes INT,
    calories_estimated INT,
    difficulty ENUM('easy', 'medium', 'hard')
);

-- Таблица записей на тренировки
CREATE TABLE IF NOT EXISTS workout_bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    workout_id INT,
    booking_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    scheduled_time DATETIME NOT NULL,
    status ENUM('booked', 'completed', 'cancelled', 'missed'),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (workout_id) REFERENCES workouts(workout_id)
);

-- Таблица результатов тренировок
CREATE TABLE IF NOT EXISTS workout_results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    actual_duration INT COMMENT 'Фактическая продолжительность в минутах',
    calories_burned INT,
    notes TEXT,
    rating TINYINT(1) COMMENT 'Оценка тренировки (1-5)',
    completed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES workout_bookings(booking_id)
);

-- Таблица активности
CREATE TABLE IF NOT EXISTS user_activities (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    activity_type ENUM('workout', 'walk', 'run', 'cycle', 'swim'),
    start_time DATETIME,
    end_time DATETIME,
    duration_minutes INT,
    distance_km DECIMAL(5,2),
    calories_burned INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
