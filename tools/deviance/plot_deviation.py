import json
import matplotlib.pyplot as plt
from datetime import datetime

def load_stats(log_file):
    """Load the logged OCR deviation stats from a JSON file."""
    with open(log_file, "r", encoding="utf-8") as f:
        return json.load(f)

def plot_deviation(stats, output_file="deviation_plot.png"):
    """Plot deviation percentage over time and save to a file."""
    timestamps = [datetime.fromisoformat(entry["timestamp"]) for entry in stats]
    deviation = [entry["deviation_percentage"] for entry in stats]

    plt.figure(figsize=(10, 5))
    plt.plot(timestamps, deviation, marker="o", linestyle="-", color="royalblue", label="Deviation %")
    plt.title("OCR Error Deviation Over Time", fontsize=14)
    plt.xlabel("Date", fontsize=12)
    plt.ylabel("Deviation Percentage", fontsize=12)
    plt.grid(True)
    plt.legend()
    plt.tight_layout()
    plt.xticks(rotation=45)

    # Save to file instead of showing interactively
    plt.savefig(output_file)
    print(f"Plot saved as: {output_file}")

if __name__ == "__main__":
    log_file = "stats.json"
    stats = load_stats(log_file)
    plot_deviation(stats)
