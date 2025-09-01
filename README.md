# 🗺️ CitySwipe — AI Trip Planner with Tinder-style Swipes (Delphi + FireMonkey)
![Delphi](https://img.shields.io/badge/Delphi-12%20FMX-blue?style=for-the-badge)
![Android](https://img.shields.io/badge/Android-Mobile%20App-brightgreen?style=for-the-badge&logo=android)
![SQLite](https://img.shields.io/badge/SQLite-Embedded%20DB-003B57?style=for-the-badge&logo=sqlite)
![Google_Maps](https://img.shields.io/badge/Google%20Maps-Places%20API-red?style=for-the-badge&logo=googlemaps)
![AI](https://img.shields.io/badge/AI-DeepSeek%20R1-orange?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Prototype-yellow?style=for-the-badge)

**Stats:**

- **Total lines:** 2,399  
- **Code lines:** 1,598  
- **Blank lines:** 345  
- **Comment lines:** 456  
- **Classes:** 35 **Functions:** 18 **Procedures:** 62

---

## 🔥 TL;DR

A **cross-platform Delphi FireMonkey** mobile app that plans a full day out in a new city:  
- Users **swipe** activities/restaurants **left/right** (Tinder-style), and the app computes an **optimized day plan**.  
- Pulls **Google Maps** data, mixes in **group preferences**, budgets, and constraints, and uses **AI (DeepSeek R1)** to curate and finalize the trip.  
- Runs on **Android/Windows**, with a **local SQLite** cache for speed and fewer API calls. :contentReference[oaicite:0]{index=0}

---

## 🧩 Tech Stack

| Category            | Tools & Libraries |
|--------------------|-------------------|
| **Framework**      | Delphi 12 **FMX** (FireMonkey), Android & Windows targets :contentReference[oaicite:1]{index=1} |
| **AI**             | **DeepSeek** wrapper (R1 / DeepThink) with large (~35k) input prompts :contentReference[oaicite:2]{index=2} |
| **Maps & Network** | **Google Maps Places API**, Delphi `HttpClient` / `System.Net` :contentReference[oaicite:3]{index=3} |
| **Data**           | **SQLite** via FireDAC (TFD), JSON (REST.Json/System.Json) :contentReference[oaicite:4]{index=4} |
| **Design**         | **Figma** prototype & color-theory-driven animated UI :contentReference[oaicite:5]{index=5} |

---

## 🔥 Overview

**CitySwipe** helps visitors decide **what to do today** in an unfamiliar city.  
Workflow: create a **Group Profile** (accessibility, vibe, energy, kids count, budget), start a **New Trip**, then swipe suggested activities/restaurants. The app merges your choices with live **Google Maps** data and outputs a **route/plan** for the day. Built end-to-end in **FireMonkey** with **animated UI** and strong color hierarchy. :contentReference[oaicite:6]{index=6}

---

## 🎥 Key Features

- **Tinder-Style Swiping UI**  
  Swipe **right** to like and **left** to skip; the AI generates a day plan from your kept cards. (Fully animated; uses haptics on Android via an OS bridge.) :contentReference[oaicite:7]{index=7} :contentReference[oaicite:8]{index=8}

- **Group Profiles & Trip Settings**  
  Rich profiles drive personalization (mood, social level, energy, style, accessibility, etc.). Trip sliders control **budget per person**, **activity count**, and **max distance**. :contentReference[oaicite:9]{index=9} :contentReference[oaicite:10]{index=10}

- **Google Maps + Local Caching**  
  Fetches **top activities & restaurants**, then **caches** them in a local **CityInfo** table (place id, price, rating, accessibility flags, photo ref, hours, etc.). Reduces network calls and speeds up swiping. :contentReference[oaicite:11]{index=11} :contentReference[oaicite:12]{index=12}

- **AI Curation & Finalization**  
  DeepSeek evaluates **group prefs + city data** to propose **swipeable cards** and then compute the **final trip** from your likes. Large prompt context (≈**35k tokens**) with retries if the model returns invalid JSON. Sub-$1 per trip if within Google Maps’ free tier. :contentReference[oaicite:13]{index=13}

- **Distance Math**  
  Calculates straight-line distances with the **Haversine formula** to help score feasibility and filter results. :contentReference[oaicite:14]{index=14}

- **SQLite-Backed History**  
  Saves **Previous Trips** (plus a JSON file of places per trip) for quick reload; **Groups** can be saved/loaded for reuse. :contentReference[oaicite:15]{index=15}

- **Helpful Dev Ergonomics**  
  - Android packaging via `assets\internal\` deployment for data files  
  - Heavy `try..except`—**run without debugger** to avoid break-on-handled exceptions  

---

## 🗃️ Data Model (SQLite)

- **tblGroups** – persisted group profiles (name, accessibility, energy, social level, vibe, style, kids, etc.)  
- **PreviousTrips** – trip metadata + path to trip’s **Activities.json** on device  
- **CityInfo** – cached places (id, price, rating, flags like **GoodForGroups**, **HasKidsMenu**, **IsReservable**, etc.) pulled from Maps until the city changes  

---

## 🧠 Notable Engineering Bits

- **FMX Mobile from scratch:** learned **FireMonkey** + **Android** build/deploy independently, including device targets and USB debugging. :contentReference[oaicite:19]{index=19}  
- **Android OS bridges:** implemented device **vibration** and OS hooks where Delphi lacks direct APIs (Android “JS injections” technique). :contentReference[oaicite:20]{index=20}  
- **Robust JSON layer:** end-to-end serialization for AI I/O and for **Activities.json** trip files. :contentReference[oaicite:21]{index=21}  
- **Field-masked Places API calls:** pragmatic use of Google’s fields + local caching to keep runs **fast & cheap**. :contentReference[oaicite:22]{index=22} :contentReference[oaicite:23]{index=23}

---

## 🎯 Why This Project Matters

✅ Built a **real** mobile app with **animated UI** and color theory  
✅ Combined **AI reasoning** with **live geodata** and user preferences  
✅ Designed for **offline-ish performance** via **SQLite caching**  
✅ Strong **software architecture** (classes, arrays for likes/dislikes, overloads)  
✅ Clear **dev guide** + run instructions for Android/Windows testers  

---

## 🔗 Design & Dev Notes

- **Design prototype (Figma):** CitySwipe UI flow & visuals  
- **Run notes:** Windows x64 or Android; include DataFiles in deployment  
- **Limitations:** DeepThink can be slower; Delphi FMX dynamic components can visually glitch under rapid updates (UI refresh fixes it)  
:contentReference[oaicite:26]{index=26} :contentReference[oaicite:27]{index=27}
