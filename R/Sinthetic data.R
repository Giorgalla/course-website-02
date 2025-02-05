library(tibble)
library(dplyr)
library(lubridate)
library(forcats)
library(knitr)
library(kableExtra)
library(ggplot2)
#install.packages('knitr')
#install.packages('kableExtra')
#install.packages("see")
install.packages("reshape2")
# Create Codebook
codebook <- tibble(
  variable_name = c("age", "gender", "education", "decision_factor", "decision_fatigue", "overanalysis", "decision_style", "cognitive_bias", "decision_strategies", "decision_confidence"),
  question = c(
    "What is your age?",
    "What is your gender?",
    "What is your education level?",
    "When making a decision, which factor influences you the most?",
    "How often do you experience decision fatigue?",
    "Do you tend to overanalyze decisions before making them?",
    "Which type of decision-making style best describes you?",
    "Have you ever experienced cognitive bias affecting your decisions?",
    "What strategies do you use to improve your decision-making process?",
    "On a scale from 1-5, how confident are you in your decision-making skills?"
  )
)

# Generate a synthetic dataset
set.seed(123)
data <- tibble(
  age = sample(18:65, 100, replace = TRUE),
  gender = sample(c("Male", "Female", "Non-binary", "Prefer not to say"), 100, replace = TRUE),
  education = sample(c("High school or below", "Undergraduate degree", "Graduate degree", "Other"), 100, replace = TRUE),
  decision_factor = sample(c("Logical reasoning", "Emotions and intuition", "Social influences", "Past experiences"), 100, replace = TRUE),
  decision_fatigue = sample(c("Never", "Sometimes", "Often", "Always"), 100, replace = TRUE),
  overanalysis = sample(c("Yes", "No", "Sometimes"), 100, replace = TRUE),
  decision_style = sample(c("Rational", "Intuitive", "Dependent", "Avoidant"), 100, replace = TRUE),
  cognitive_bias = sample(c("Yes", "No", "Unsure"), 100, replace = TRUE),
  decision_strategies = sample(c("Seeking advice", "Analyzing pros and cons", "Taking time", "Relying on past experiences"), 100, replace = TRUE),
  decision_confidence = sample(1:5, 100, replace = TRUE)
)


# Age distribution
age_plot <- ggplot(data, aes(x = age)) +
  geom_histogram(binwidth = 5, fill = "steelblue", color = "black") +
  labs(title = "Age Distribution", x = "Age", y = "Frequency") +
  theme_minimal()

age_plot
