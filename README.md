# 🪪 Boat & Air License System - QBCore

A lightweight license management system for **QBCore**-based FiveM servers that allows staff to issue or revoke **boat** and **air licenses** via command. This system supports SQL-based persistence and item handling for immersive roleplay experiences.

---

## ⚙️ What It Does

Provides admin commands to:

- ✅ Store licenses in the database (`player_dlicenses`)
- 🎫 Give or remove license items (`boat_license`, `air_license`)
- 📋 Track licenses using each player's `citizenid`

### Useful for:

- 🛥️ Roleplay-driven DMV or Air Licensing Departments
- 🚁 Restricting boat/air usage to licensed players
- 🔒 Controlled access to vehicles
- 📉 Lightweight, persistent license system

---

## 🕹️ Command Usage

| Command | Description |
|--------|-------------|
| `/givelicense [id] [boat/air]` | Gives a license to a player (DB + item) |
| `/removelicense [id] [boat/air]` | Removes a player's license (DB + item) |

> 🛡️ Note: These commands require `god` permission access in QBCore.

---

## 🛠️ Installation

1. Place the script inside your `resources/` folder (e.g. `resources/d3-licence`)
2. Add the following to your `server.cfg`:

cfg
ensure `d3-licence`
