const std = @import("std");
const c = @cImport({
    @cInclude("curl/curl.h");
});

pub fn main() !void {
    // based on https://curl.se/libcurl/c/simple.html

    const curl: ?*anyopaque = c.curl_easy_init();
    defer _ = c.curl_easy_cleanup(curl);

    if (curl != null) {
        _ = c.curl_easy_setopt(curl, c.CURLOPT_URL, "https://example.com");
        _ = c.curl_easy_setopt(curl, c.CURLOPT_FOLLOWLOCATION, @intCast(i32, 1));

        var res: c_uint = c.curl_easy_perform(curl);
        if (res != c.CURLE_OK) {
            std.debug.print("curl_easy_perform() failed", .{});
        }
    }
}
