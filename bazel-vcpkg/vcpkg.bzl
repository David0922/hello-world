# # buildifier: disable=module-docstring
# load("@rules_cc//cc:defs.bzl", "cc_library")

# def _vcpkg_impl(ctx):
#     vcpkg_installed = ctx.attr.vcpkg_installed
#     pkg_config_path = vcpkg_installed + "/lib/pkgconfig"

#     all_pkg_f = ctx.actions.declare_file("all_pkg.txt")
#     cflags_f = ctx.actions.declare_file("cflags.txt")
#     linker_flags_f = ctx.actions.declare_file("linker_flags.txt")

#     ctx.actions.run_shell(
#         outputs = [all_pkg_f],
#         command = "ls {} | cut -d . -f 1".format(pkg_config_path),
#     )
#     ctx.actions.run_shell(
#         outputs = [cflags_f],
#         command = "PKG_CONFIG_PATH={} pkg-config --cflags {}".format(pkg_config_path, all_pkg),
#     )
#     ctx.actions.run_shell(
#         outputs = [linker_flags_f],
#         command = "PKG_CONFIG_PATH={} pkg-config --libs {}".format(pkg_config_path, all_pkg),
#     )

#     print(all_pkg_f)
#     print(cflags)
#     print(linker_flags)

#     return cc_library(
#         name = ctx.label.name,
#         srcs = ctx.label.srcs,
#         hdrs = ctx.label.hdrs,
#         cxxopts = [cflags],
#         includes = ctx.label.includes,
#         linkopts = [linker_flags],
#         visibility = ["//visibility:public"],
#     )

# vcpkg = rule(
#     implementation = _vcpkg_impl,
#     attrs = {
#         "srcs": attr.label_list(allow_files = [".a"]),
#         "hdrs": attr.label_list(allow_files = True),
#         "includes": attr.label_list(allow_files = True),
#         "vcpkg_installed": attr.string(),
#     },
# )
