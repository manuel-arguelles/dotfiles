/**
 * @file cpu-usage.cpp
 *
 * @brief CPU usage block for i3blocks.
 *
 * [cpu-usage]
 * REFRESH_TIME=1
 * LABEL=CPU
 * interval=persist
 * format=json
 * markup=pango
 *
 * Licensed under the terms of the GNU GPL v3, or any later version.
 *
 * Copyright 2020 Manuel Argüelles <manuel.arguelles@gmail.com>
 *
 * Based on cpu_usage2.c by Nolan Leake <nolan@sigbus.net> and
 * cpu.sh by Quentin Forand <quentin@forand.fr>
 */
#include <cstdint>
#include <cstdlib>
#include <fstream>
#include <iomanip>
#include <ios>
#include <iostream>
#include <sstream>
#include <string>
#include <thread>
#include <vector>

static constexpr const char* RED = "#FF7373";
static constexpr const char* ORANGE = "#FFA500";
static constexpr double CRITICAL_LEVEL = 80;
static constexpr double WARNING_LEVEL = 50;
static constexpr size_t SYMBOLS_SIZE = 16;
static constexpr size_t MAX_PERCENTAGE = 100;
static constexpr std::chrono::seconds DEFAULT_INTERVAL(1);

/**
 * @brief Data structure of the CPU usage statistics.
 */
struct CpuUsage
{
  uint64_t oldTotal;
  uint64_t oldUsed;
  uint64_t total;
  uint64_t used;
};

/**
 * @brief Parses a line of the CPU stat file.
 *
 * @param line The line to parse.
 *
 * @return The CpuUsage structure.
 */
static CpuUsage parse_cpu_stat(const std::string& line)
{
  CpuUsage usage = { 0, 0, 0, 0 };
  std::string label;
  uint64_t user = 0;
  uint64_t nice = 0;
  uint64_t sys = 0;
  uint64_t idle = 0;
  uint64_t iowait = 0;
  uint64_t irq = 0;
  uint64_t sirq = 0;
  uint64_t steal = 0;
  uint64_t guest = 0;
  uint64_t nguest = 0;

  if (std::istringstream(line) >> label >> user >> nice >> sys >> idle
      >> iowait >> irq >> sirq >> steal >> guest >> nguest)
  {
    usage.used = user + nice + sys + irq + sirq + steal + guest + nguest;
    usage.total = usage.used + idle + iowait;
  }

  return usage;
}

/**
 * @brief Gets a collection with the CPU usage per core from /proc/stat.
 *
 * @return The collection of CpuUsage.
 */
static std::vector<CpuUsage> get_cpu_usage()
{
  const unsigned int cores = std::thread::hardware_concurrency() + 1;
  std::vector<CpuUsage> cpuUsage;
  std::ifstream stat("/proc/stat");

  for (size_t i = 0; i < cores; ++i)
  {
    std::string line;

    std::getline(stat, line);
    cpuUsage.push_back(parse_cpu_stat(line));
  }

  return cpuUsage;
}

/**
 * @brief Updates a collection of CPU usage with a more recent one.
 *
 * @param oldStats The old collection of CPU usage statistics.
 * @param newStats The new collection of CPU usage statistics.
 *
 * @return The updated collection of CPU usage statistics.
 */
static std::vector<CpuUsage> update_cpu_usage(
  const std::vector<CpuUsage>& oldStats,
  const std::vector<CpuUsage>& newStats)
{
  std::vector<CpuUsage> updatedUsage;

  for (size_t i = 0; i < oldStats.size(); ++i)
  {
    CpuUsage updated = { 0, 0, 0, 0 };

    updated.oldTotal = oldStats[i].total;
    updated.oldUsed = oldStats[i].used;
    updated.total = newStats[i].total;
    updated.used = newStats[i].used;

    updatedUsage.push_back(updated);
  }

  return updatedUsage;
}

/**
 * @brief Gets the percentage of CPU use of a given core.
 *
 * @param core The CPU usage statistics of the core to evaluate.
 *
 * @return The percentage of use in the range [0..100].
 */
static double get_use_percentage(const CpuUsage& core)
{
  return 100.00 * static_cast<double>(core.used - core.oldUsed) / static_cast<double>(core.total - core.oldTotal);
}

/**
 * @brief Gets the formatted symbol that represents the given use percentage.
 *
 * @param percent The CPU usage in the range of [0..100].
 *
 * @return The string with the pango-formatted symbol.
 */
static std::string get_symbol(const double percent)
{
  const std::array<std::string, SYMBOLS_SIZE> symbols = {
    u8"\u28C0", u8"\u28E0", u8"\u28F0", u8"\u28F8",
    u8"\u28C4", u8"\u28E4", u8"\u28F4", u8"\u28FC",
    u8"\u28C6", u8"\u28E6", u8"\u28F6", u8"\u28FE",
    u8"\u28C7", u8"\u28E7", u8"\u28F7", u8"\u28FF" };

  const int key = static_cast<int>(percent / MAX_PERCENTAGE * (SYMBOLS_SIZE - 1));
  const std::string openTag = "<span";
  const std::string closeTag = "</span>";
  std::string color;

  if (percent > CRITICAL_LEVEL)
    color = " color='" + std::string(RED) + "'>";
  else if (percent > WARNING_LEVEL)
    color = " color='" + std::string(ORANGE) + "'>";
  else
    color = ">";

  return openTag + color + symbols.at(key) + closeTag;
}

/**
 * @brief Displays the JSON formatted status output.
 *
 * @param label The prefix to use in the full text.
 * @param cores The collection of CPU usage statistics per core.
 */
static void display(const std::string& label, const std::vector<CpuUsage>& cores)
{
  const double totalUsage = get_use_percentage(cores.front());
  std::stringstream output;

  output << R"({"full_text": ")" << label;

  for (auto it = cores.cbegin() + 1; it != cores.cend(); ++it)
    output << get_symbol(get_use_percentage(*it));

  output << R"(", "short_text":")";
  output << get_symbol(totalUsage);
  output << R"("})";

  std::cout << output.str() << std::endl;
  std::cout << std::flush;
}

/**
 * @brief Main function.
 *
 * @param argc The number of arguments.
 * @param argv The collection with the value of the arguments.
 *
 * @return The exit status code.
 */
int main(int, char**)
{
  std::string label;
  std::chrono::seconds interval = DEFAULT_INTERVAL;
  std::vector<CpuUsage> cpuUsage = get_cpu_usage();

  if (const char* env = std::getenv("LABEL"))
    label = env;

  if (const char* env = std::getenv("REFRESH_TIME"))
    interval = std::chrono::seconds(std::stoi(env));

  std::this_thread::sleep_for(interval);

  while (true)
  {
    const std::vector<CpuUsage> increment = get_cpu_usage();

    cpuUsage = update_cpu_usage(cpuUsage, increment);
    display(label, cpuUsage);

    std::this_thread::sleep_for(interval);
  }

  return 0;
}
