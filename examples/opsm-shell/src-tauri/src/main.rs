// SPDX-License-Identifier: PMPL-1.0-or-later
// SPDX-FileCopyrightText: 2026 Hyperpolymath
//
// main.rs - Rust backend for OPSM shell example

#![cfg_attr(
    all(not(debug_assertions), target_os = "windows"),
    windows_subsystem = "windows"
)]

use tauri::{CustomMenuItem, Menu, MenuItem, Submenu};

fn main() {
    let mode_user = CustomMenuItem::new("mode_user".to_string(), "WYSIWYG (User)");
    let mode_maint = CustomMenuItem::new("mode_maint".to_string(), "WYSIWYGM (Maintainer)");
    let mode_dev = CustomMenuItem::new("mode_dev".to_string(), "WYMIWYG (Developer)");
    let dry_run = CustomMenuItem::new("dry_run".to_string(), "Dry-Run Focus");

    let mode_menu = Menu::new()
        .add_item(mode_user)
        .add_item(mode_maint)
        .add_item(mode_dev)
        .add_native_item(MenuItem::Separator)
        .add_item(dry_run);

    let menu = Menu::new().add_submenu(Submenu::new("Mode", mode_menu));

    tauri::Builder::default()
        .menu(menu)
        .on_menu_event(|event| {
            let window = event.window();
            match event.menu_item_id() {
                "mode_user" => {
                    let _ = window.emit("opsm:mode", "wysiwyg");
                }
                "mode_maint" => {
                    let _ = window.emit("opsm:mode", "wysiwygm");
                }
                "mode_dev" => {
                    let _ = window.emit("opsm:mode", "wymiwyg");
                }
                "dry_run" => {
                    let _ = window.emit("opsm:dry-run", "focus");
                }
                _ => {}
            }
        })
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
