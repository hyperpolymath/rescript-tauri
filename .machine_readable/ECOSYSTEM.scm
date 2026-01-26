; SPDX-License-Identifier: PMPL-1.0-or-later
; SPDX-FileCopyrightText: 2026 Hyperpolymath
;
; ECOSYSTEM.scm - Ecosystem position for rescript-tauri
; Media-Type: application/vnd.ecosystem+scm

(ecosystem
  (version "1.0")
  (name "rescript-tauri")
  (type "bindings-library")
  (purpose "Type-safe ReScript bindings for Tauri 2.0 desktop and mobile development")

  (position-in-ecosystem
    (category "presentation")
    (subcategory "native-shell")
    (layer "P4 - Mobile & Desktop")
    (unique-value
      ("Only ReScript path to native desktop/mobile apps")
      ("Type-safe command bridge pattern")
      ("TEA integration examples")
      ("Zero npm for Deno users")))

  (related-projects
    ;; Core dependencies
    (("@tauri-apps/api" "upstream" "Official Tauri JS API")
     ("@tauri-apps/cli" "tooling" "Tauri CLI for building apps")
     ("rescript" "compiler" "ReScript compiler"))

    ;; Hyperpolymath ecosystem
    (("rescript-tea" "sibling-component" "TEA architecture for ReScript UIs")
     ("cadre-tea-router" "sibling-component" "Routing for rescript-tea")
     ("rescript-full-stack" "parent-ecosystem" "Full-stack ReScript ecosystem map")
     ("rescript-sqlite" "future-integration" "Embedded database for offline-first Tauri apps")
     ("rescript-wasm-runtime" "potential-integration" "WASM compute modules in Tauri"))

    ;; Community alternatives
    (("tauri-apps/tauri" "upstream-runtime" "Tauri framework itself")
     ("nickel" "configuration" "Tauri config could use Nickel")))

  (what-this-is
    ("ReScript bindings for Tauri 2.0 JavaScript API")
    ("Type-safe command bridge for Rust IPC")
    ("Plugin bindings (fs, dialog, shell, etc.)")
    ("Examples showing TEA integration")
    ("Part of rescript-full-stack P4 milestone"))

  (what-this-is-not
    ("NOT a Rust library - this is ReScript/JS bindings")
    ("NOT a framework - just FFI bindings with helpers")
    ("NOT Tauri 1.x compatible - 2.0 only")
    ("NOT a React library - works with any frontend")
    ("NOT bundling Tauri CLI - install separately")))
