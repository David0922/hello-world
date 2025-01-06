cc_binary(
    name = "cpp_grpc_server",
    srcs = ["main.cc"],
    # linkopts = ["-static"],
    # linkshared = True,
    deps = [
        # "//:vcpkg",
        "//protos:calc_cc_grpc",
        "@com_google_absl//absl/strings:str_format",
    ],
)
