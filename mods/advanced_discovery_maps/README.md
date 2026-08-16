## Advanced Discovery Maps: A Topological and Telemetry Overhaul

**Advanced Discovery Maps** is a professional-grade evolution of the original `discovery_maps` mod for Luanti. It features a completely rewritten rendering engine, introducing advanced cartographic tools such as topographic shading, multi-layered geological scanning, and a highly responsive UI with dynamic waypoint telemetry. 

This project was built focusing on **extreme optimization**, delivering complex 3D-aware mapping while maintaining a tiny memory footprint and preventing CPU throttling on entry-level hardware.

### ✨ Key Features & Improvements

*   **Topographic Shading & Dual-Buffer Rendering:** Generates both standard satellite and relief maps simultaneously. It uses differential height calculations to apply directional shadow multipliers, perfectly simulating 3D terrain illumination.
*   **Deep Cave & Bathymetric Scanning:** The engine uses a "penetrating ray" algorithm to map underwater topography seamlessly. It also includes a strict State Machine vegetation filter to prevent tree canopies from being misidentified as cave ceilings.
*   **Asynchronous `VoxelManip` Engine:** Synchronous map generation has been replaced with passive memory reading. Maps are drawn asynchronously using a task queue, avoiding Out of Memory (OOM) crashes and stuttering.
*   **Advanced UI/UX & Virtual Touch Navigation:** The formspec has been mathematically redesigned to prevent clipping on any screen resolution. Click anywhere on the map to instantly center your view.
*   **Target-Tracking Telemetry:** Replaced the legacy "greedy scanner" with a selectable dropdown target system. The engine isolates your chosen waypoint and calculates the exact Euclidean distance without unnecessary background loop iterations.
*   **Logarithmic Scaling & Dynamic Grids:** Player avatars use a log-dampened scaling formula (Chevron polygon) to remain visible without obscuring the map. The cartesian grid subdivides dynamically based on your zoom level.
*   **Longitudinal Profiles (Topographic Analysis):** Instantly generate cross-sectional elevation profiles of the terrain along the X or Z axis.
*   **Native i18n Support:** Fully decoupled UI text using Luanti's native translation system (Spanish `.tr` file included).

### 🤝 Credits and Acknowledgements

This mod is a heavily optimized and expanded fork of the original `discovery_maps` by TomCon .

**AI Assistance Disclosure:**
Much of the refactoring, logical optimization, and geometric stabilization of the user interface were developed with the
help of the following Artificial Intelligences: Gemini, ChatGPT, DeepSeek, Grok, Claude, Vibe (LeChat).
