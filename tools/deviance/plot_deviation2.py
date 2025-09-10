import json
import matplotlib.pyplot as plt
from datetime import datetime

# Load data
def load_stats(log_file):
    with open(log_file, "r", encoding="utf-8") as f:
        return json.load(f)

# Plot deviation percentage over time
def plot_deviation(stats, output_file="deviation_plot.png"):
    timestamps = [datetime.fromisoformat(entry["timestamp"]) for entry in stats]
    deviation = [entry["deviation_percentage"] for entry in stats]

    plt.figure(figsize=(10, 5))
    plt.plot(timestamps, deviation, marker="o", linestyle="-", color="royalblue", label="Deviation %")
    plt.title("OCR Error Deviation Over Time")
    plt.xlabel("Date")
    plt.ylabel("Deviation Percentage")
    plt.grid(True)
    plt.legend()
    plt.tight_layout()
    plt.xticks(rotation=45)
    plt.savefig(output_file)

# Plot number of unknown words over time
def plot_unknown_words(stats, output_file="unknown_words_plot.png"):
    timestamps = [datetime.fromisoformat(entry["timestamp"]) for entry in stats]
    unknown_words = [entry["total_unknown_words"] for entry in stats]

    plt.figure(figsize=(10, 5))
    plt.plot(timestamps, unknown_words, marker="s", linestyle="--", color="darkred", label="Unknown Words")
    plt.title("Total Unknown Words Over Time")
    plt.xlabel("Date")
    plt.ylabel("Unknown Words")
    plt.grid(True)
    plt.legend()
    plt.tight_layout()
    plt.xticks(rotation=45)
    plt.savefig(output_file)

# Plot total word count over time
def plot_total_words(stats, output_file="total_words_plot.png"):
    timestamps = [datetime.fromisoformat(entry["timestamp"]) for entry in stats]
    total_words = [entry["total_words"] for entry in stats]

    plt.figure(figsize=(10, 5))
    plt.plot(timestamps, total_words, marker="^", linestyle="-.", color="darkgreen", label="Total Words")
    plt.title("Total Words Processed Over Time")
    plt.xlabel("Date")
    plt.ylabel("Total Words")
    plt.grid(True)
    plt.legend()
    plt.tight_layout()
    plt.xticks(rotation=45)
    plt.savefig(output_file)

# Run all plots
log_file_path = "stats.json"
stats = load_stats(log_file_path)

plot_deviation(stats)
plot_unknown_words(stats)
plot_total_words(stats)
