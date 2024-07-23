const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib_lua = b.addStaticLibrary(.{
        .name = "lua",
        .target = target,
        .optimize = optimize,
    });
    lib_lua.linkLibC();
    lib_lua.addIncludePath(b.path(""));
    lib_lua.addCSourceFiles(.{
        .root = b.path(""),
        .files = &.{
            "lapi.c",
            "lcode.c",
            "lctype.c",
            "ldebug.c",
            "ldo.c",
            "ldump.c",
            "lfunc.c",
            "lgc.c",
            "llex.c",
            "lmem.c",
            "lobject.c",
            "lopcodes.c",
            "lparser.c",
            "lstate.c",
            "lstring.c",
            "ltable.c",
            "ltm.c",
            "lundump.c",
            "lvm.c",
            "lzio.c",
            "lauxlib.c",
            "lbaselib.c",
            "lcorolib.c",
            "ldblib.c",
            "liolib.c",
            "lmathlib.c",
            "loadlib.c",
            "loslib.c",
            "lstrlib.c",
            "ltablib.c",
            "lutf8lib.c",
            "linit.c",
        },
    });
    b.installArtifact(lib_lua);

    const exe_lua = b.addExecutable(.{
        .name = "lua",
        .target = target,
        .optimize = optimize,
    });
    exe_lua.addCSourceFile(.{ .file = b.path("lua.c") });
    exe_lua.linkLibC();
    exe_lua.linkSystemLibrary("m");
    exe_lua.linkLibrary(lib_lua);
    b.installArtifact(exe_lua);

    // const exe_luac = b.addExecutable(.{
    //     .name = "luac",
    //     .target = target,
    //     .optimize = optimize,
    // });
    // exe_luac.addCSourceFile(.{ .file = b.path("./lua"), .flags = CFLAGS });
    // exe_luac.linkLibC();
    // exe_luac.linkSystemLibrary("m");
    // exe_luac.linkLibrary(lib_lua);
    // b.installArtifact(exe_luac);
}
