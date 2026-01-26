; SPDX-License-Identifier: PMPL-1.0-or-later
; SPDX-FileCopyrightText: 2026 Hyperpolymath
;
; META.scm - Architecture decisions and development practices
; Media-Type: application/meta+scheme

(meta
  (version "1.0.0")
  (project "rescript-tauri")

  (architecture-decisions
    (adr-001
      (title "Tauri 2.0 over Tauri 1.x")
      (status "accepted")
      (date "2026-01-05")
      (context "Need stable bindings for mobile support")
      (decision "Target Tauri 2.0 exclusively, no 1.x compatibility")
      (consequences
        ("Native iOS and Android support")
        ("Modern plugin system")
        ("Breaking changes from 1.x users")
        ("API may change until 2.0 stable")))

    (adr-002
      (title "Command bridge pattern")
      (status "accepted")
      (date "2026-01-05")
      (context "Need type-safe IPC between ReScript and Rust")
      (decision "Implement a command definition pattern with encode/decode")
      (consequences
        ("Type safety at compile time")
        ("Structured error handling")
        ("Retry and timeout support built-in")
        ("Slight overhead vs raw invoke")))

    (adr-003
      (title "Plugin bindings as separate modules")
      (status "accepted")
      (date "2026-01-05")
      (context "Tauri plugins are optional peer dependencies")
      (decision "Each plugin gets its own module, users import what they need")
      (consequences
        ("Tree-shaking friendly")
        ("Clear separation of concerns")
        ("Users must install plugin packages separately")
        ("Module naming follows Tauri_* convention")))

    (adr-004
      (title "rescript-tea as reference integration")
      (status "accepted")
      (date "2026-01-05")
      (context "Need to show idiomatic ReScript patterns with Tauri")
      (decision "Examples use rescript-tea for state management")
      (consequences
        ("Demonstrates TEA pattern with commands")
        ("Shows subscription-based event handling")
        ("Not required for library use")
        ("Users can use React or other frameworks")))

    (adr-005
      (title "Interface files required")
      (status "accepted")
      (date "2026-01-05")
      (context "API documentation and type safety")
      (decision "All public modules must have .resi interface files")
      (consequences
        ("Clear public API")
        ("Better IDE support")
        ("Enforced encapsulation")
        ("Maintenance overhead for .resi files"))))

  (development-practices
    (code-style
      (formatter "rescript format")
      (linter "deno lint")
      (module-format "esmodule")
      (file-extension ".res")
      (naming-convention "Tauri_* for bindings"))

    (security
      (permissions-model "Tauri capabilities")
      (ipc-validation "Command bridge validates all responses")
      (no-eval "Never use eval or Function constructor"))

    (testing
      (unit-framework "vitest")
      (integration "Tauri test driver")
      (e2e "playwright for webview"))

    (versioning
      (strategy "semantic")
      (tauri-alignment "Match Tauri 2.x minor versions")
      (breaking-changes "major-version-only"))

    (documentation
      (format "asciidoc")
      (api-docs "generated from .resi files")
      (examples "required for each plugin module"))

    (branching
      (strategy "trunk-based")
      (main-branch "main")
      (feature-branches "short-lived")))

  (design-rationale
    (why-tauri
      "Tauri provides a lightweight alternative to Electron with Rust backend.
       Tauri 2.0 adds mobile support (iOS/Android) with same codebase.
       Native performance with web UI flexibility.")

    (why-command-bridge
      "Raw invoke is stringly-typed and error-prone.
       Command definitions provide compile-time type checking.
       Error handling is centralized and consistent.
       Retry/timeout patterns are reusable.")

    (why-separate-modules
      "Tauri plugins are optional features with separate npm packages.
       Bundling all bindings would bloat apps that don't need them.
       Separate modules enable proper tree-shaking.
       Clear mapping to @tauri-apps/plugin-* packages.")

    (why-not-electron
      "Electron bundles Chromium (200MB+ overhead).
       Tauri uses system webview (10MB typical app size).
       Rust backend is memory-safe and performant.
       Tauri 2.0 supports mobile, Electron doesn't.")))
