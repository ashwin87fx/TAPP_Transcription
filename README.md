# TAPP - Intelligent Transcription & Analysis Platform

![Project Banner](https://via.placeholder.com/1200x600.png?text=TAPP+Showcase+Banner)

**TAPP** is a next-generation AI transcription studio that transforms raw audio into actionable insights. Built with **Flutter** (Web) and **FastAPI** (Python), it combines state-of-the-art speech recognition (**Faster-Whisper**) with Large Language Model intelligence (**Google Gemini API**) to deliver accurate, diarized transcripts and executive summaries.

---

## 🚀 The Problem
In today's fast-paced digital world, valuable information is locked inside hours of audio recordings—meetings, lectures, interviews, and podcasts.
*   **Manual transcription** is slow and expensive.
*   **Traditional tools** often lack accuracy with accents or mixed languages (Code-switching/Hinglish).
*   **Raw transcripts** are overwhelming to read without structure or summaries.

## 💡 The Solution
TAPP solves this by offering a unified "studio" experience:
1.  **High-Fidelity Transcription**: Uses OpenAI's Whisper model (via Faster-Whisper) for near-perfect accuracy, even with accents.
2.  **Speaker Diarization**: Distinguishes between speakers (Speaker A, Speaker B) automatically.
3.  **Smart Summarization**: Integrated **Google Gemini AI** analyzes the text to generate concise executive summaries and key bullet points.
4.  **Brain-Body Sync**: Interactive UI where clicking any sentence instantly seeks the audio to that exact moment.
5.  **Multi-Language Support**: Specialized support for **Hinglish** (Hindi-English mix) and Urdu, alongside 98+ other languages.

---

## 📸 Screenshots

| **The Studio (Dark Mode)** | **AI Summary** |
|:---:|:---:|
| ![Transcribe View](https://via.placeholder.com/600x400.png?text=Studio+View) | ![Summary Modal](https://via.placeholder.com/600x400.png?text=AI+Summary+Dialog) |
| *Glassmorphic interactive transcript with audio waveforms.* | *Instant executive summaries via Gemini.* |

| **Landing Page** | **Themes (Light Mode)** |
|:---:|:---:|
| ![Home Page](https://via.placeholder.com/600x400.png?text=Landing+Page) | ![Light Mode](https://via.placeholder.com/600x400.png?text=Light+Theme) |
| *Modern, responsive landing page.* | *Adaptive theming for any environment.* |

---

## 🛠️ Tech Stack

### **Frontend (The Body)**
*   **Framework**: [Flutter](https://flutter.dev/) (Web)
*   **State Management**: [GetX](https://pub.dev/packages/get) (Reactive state & Dependency Injection)
*   **Design System**: Custom **Glassmorphism** UI with animated gradients and blur effects.
*   **Audio Engine**: `audioplayers` for precise playback control and syncing.

### **Backend (The Brain)**
*   **Framework**: [FastAPI](https://fastapi.tiangolo.com/) (Python)
*   **AI Models**:
    *   **ASR**: `faster-whisper` (Quantized Whisper implementation for speed).
    *   **LLM**: `google-generativeai` (Gemini 1.5 Flash) for summarization.
*   **Architecture**: REST API with CORS support for secure client-server communication.

---

## ✨ Key Features
*   **Glassmorphic Design**: A premium, "frosted glass" aesthetic that adapts to Dark and Light modes.
*   **Interactive Playback**: Click on any transcript segment to jump the audio to that timestamp.
*   **Drag & Drop**: Modern file upload zone with hover animations.
*   **Export Options**: Download transcripts as `.txt` or `.srt` (SubRip) formats.
*   **Live Language Switching**: Toggle between English, Spanish, Hindi, Hinglish, and more instantly.

---

## 🚀 Getting Started

### Prerequisites
*   [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.0+)
*   [Python](https://www.python.org/) (3.8+)
*   Google Gemini API Key

### 1. Clone the Repository
```bash
git clone https://github.com/alimxm480-oss/TAPP_Transcription.git
cd TAPP_Transcription
```

### 2. Backend Setup
```bash
# Install dependencies
pip install -r requirements.txt

# Set your API Key (in main.py or env)
# export GEMINI_API_KEY="your_key_here"

# Run the Server
uvicorn main:app --reload
```
*Server runs at `http://127.0.0.1:8000`*

### 3. Frontend Setup
```bash
# Get dependencies
flutter pub get

# Run on Chrome (Disable web security for local CORS if needed)
flutter run -d chrome --web-browser-flag "--disable-web-security"
```

---

## 🔮 Future Roadmap
*   [ ] Real-time streaming transcription (WebSocket).
*   [ ] User Accounts & History Storage (Firebase/Supabase).
*   [ ] Speaker Identification (naming speakers).
*   [ ] Mobile App (iOS/Android) release.

---

**Developed by Ali**
*Showcasing the power of Agentic AI Development.*
