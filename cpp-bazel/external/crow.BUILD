cc_library(
    name = "crow",
    hdrs = glob(["include/**"]),
    includes = ["include"],
    linkopts = ["-pthread"],
    visibility = ["//visibility:public"],
    deps = [
        "@boost//:algorithm",
        "@boost//:asio",
        "@boost//:optional",
    ],
)
