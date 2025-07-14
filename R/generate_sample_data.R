# Generate Sample Radiation Sensor Data for Radiation Demo
# This script creates realistic radiation monitoring data for the demo

library(tidyverse)
library(lubridate)

set.seed(42)

# Create sensor locations around Flamanville (approximate coordinates)
sensor_locations <- tibble(
  sensor_id = sprintf("Radiation_%03d", 1:15),
  latitude = runif(15, 49.52, 49.55),
  longitude = runif(15, -1.88, -1.84),
  sensor_type = sample(c("gamma", "beta", "alpha"), 15, replace = TRUE),
  installation_date = sample(seq(as.Date("2020-01-01"), as.Date("2023-01-01"), by = "day"), 15),
  status = sample(c("operational", "maintenance", "calibration"), 15, replace = TRUE, prob = c(0.85, 0.1, 0.05))
)

# Generate 30 days of hourly radiation measurements
start_date <- as.POSIXct("2024-01-01 00:00:00", tz = "Europe/Paris")
end_date <- start_date + days(30)
timestamps <- seq(start_date, end_date, by = "hour")

# Create base radiation levels (typical background: 0.1-0.3 µSv/h)
radiation_data <- expand_grid(
  timestamp = timestamps,
  sensor_id = sensor_locations$sensor_id
) %>%
  left_join(sensor_locations, by = "sensor_id") %>%
  mutate(
    # Base background radiation with slight sensor variation
    base_radiation = case_when(
      sensor_type == "gamma" ~ rnorm(n(), 0.15, 0.02),
      sensor_type == "beta" ~ rnorm(n(), 0.12, 0.015),
      sensor_type == "alpha" ~ rnorm(n(), 0.08, 0.01)
    ),
    
    # Add daily cycle (slightly higher during day due to cosmic rays)
    daily_cycle = 0.01 * sin(2 * pi * (hour(timestamp) - 6) / 24),
    
    # Add weather influence (higher during rain/storms)
    weather_factor = case_when(
      # Simulate storm period from Jan 15-17
      date(timestamp) >= as.Date("2024-01-15") & date(timestamp) <= as.Date("2024-01-17") ~ 
        rnorm(n(), 0.05, 0.02),
      TRUE ~ rnorm(n(), 0, 0.005)
    ),
    
    # Add random measurement noise
    measurement_noise = rnorm(n(), 0, 0.003),
    
    # Calculate final radiation level
    radiation_level = pmax(0, base_radiation + daily_cycle + weather_factor + measurement_noise),
    
    # Add measurement quality flags
    quality_flag = case_when(
      status != "operational" ~ "invalid",
      radiation_level > 0.5 ~ "high",
      radiation_level < 0.05 ~ "low",
      TRUE ~ "normal"
    ),
    
    # Round to realistic precision
    radiation_level = round(radiation_level, 4)
  ) %>%
  select(timestamp, sensor_id, latitude, longitude, sensor_type, 
         radiation_level, quality_flag, status)

# Generate weather data
weather_timestamps <- unique(radiation_data$timestamp)
n_weather <- length(weather_timestamps)

weather_data <- tibble(
  timestamp = weather_timestamps,
  temperature = 8 + 5 * sin(2 * pi * (yday(timestamp) - 15) / 365) + rnorm(n_weather, 0, 2),
  humidity = pmax(30, pmin(95, 65 + 15 * sin(2 * pi * yday(timestamp) / 365) + rnorm(n_weather, 0, 10))),
  wind_speed = pmax(0, rnorm(n_weather, 12, 5)),
  wind_direction = runif(n_weather, 0, 360),
  precipitation = case_when(
    # Storm period
    date(timestamp) >= as.Date("2024-01-15") & date(timestamp) <= as.Date("2024-01-17") ~ 
      pmax(0, rnorm(n_weather, 5, 3)),
    TRUE ~ pmax(0, rnorm(n_weather, 0.1, 0.5))
  ),
  atmospheric_pressure = rnorm(n_weather, 1013, 10)
) %>%
  mutate(
    temperature = round(temperature, 1),
    humidity = round(humidity, 1),
    wind_speed = round(wind_speed, 1),
    wind_direction = round(wind_direction, 0),
    precipitation = round(precipitation, 1),
    atmospheric_pressure = round(atmospheric_pressure, 1)
  )

# Save datasets
write_csv(radiation_data, "data/flamanville_sensors_2024.csv")
write_csv(weather_data, "data/meteorological_2024.csv")
write_csv(sensor_locations, "data/sensor_locations.csv")

# Generate regulatory thresholds reference
regulatory_thresholds <- tibble(
  threshold_type = c("Public Alert", "Investigation Level", "Background Normal", "Instrument Detection"),
  radiation_level = c(1.0, 0.5, 0.2, 0.05),
  unit = "µSv/h",
  authority = "Radiation",
  reference_document = "Radiation-REG-2023-001"
)

write_csv(regulatory_thresholds, "data/regulatory_thresholds.csv")

cat("Sample data generated successfully!\n")
cat("Files created:\n")
cat("- data/flamanville_sensors_2024.csv (", nrow(radiation_data), " observations)\n")
cat("- data/meteorological_2024.csv (", nrow(weather_data), " observations)\n")
cat("- data/sensor_locations.csv (", nrow(sensor_locations), " sensors)\n")
cat("- data/regulatory_thresholds.csv (", nrow(regulatory_thresholds), " thresholds)\n")