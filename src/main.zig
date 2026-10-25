const std = @import("std");
const c = @import("c");

fn draw_cent_text(text: [:0]const u8, x: i32, y: i32, size: i32, color: c.Color) void {
    const text_width = c.MeasureText(text, size);
    const text_x = x - @divFloor(text_width, 2);
    const text_y = y - @divFloor(size, 2);
    c.DrawText(text, @intCast(text_x), @intCast(text_y), size, color);
}

fn handle_fullscreen() void {
    if (c.IsKeyPressed(c.KEY_F11) or
        (c.IsKeyPressed(c.KEY_ENTER) and c.IsKeyDown(c.KEY_LEFT_ALT)))
    {
        c.ToggleFullscreen();
        if (!c.IsWindowFullscreen()) {
            c.SetWindowSize(800, 450);
        }
    }
}

pub fn main() void {
    c.SetConfigFlags(c.FLAG_WINDOW_RESIZABLE | c.FLAG_MSAA_4X_HINT);
    c.InitWindow(800, 450, "raytest");
    defer c.CloseWindow();
    //c.SetTargetFPS(60);

    while (!c.WindowShouldClose()) {
        const w = @as(i32, c.GetScreenWidth());
        const h = @as(i32, c.GetScreenHeight());
        // const fw: f32 = @floatFromInt(w);
        // const fh: f32 = @floatFromInt(h);
        // const now: f32 = @floatCast(c.GetTime());

        handle_fullscreen();

        c.BeginDrawing();
        defer c.EndDrawing();
        defer c.DrawFPS(10, 10);

        c.ClearBackground(c.RAYWHITE);
        draw_cent_text(
            "Press F11 or Alt+Enter to toggle fullscreen",
            @divFloor(w, 2),
            @divFloor(h, 2),
            20,
            c.DARKBROWN,
        );
    }
}
