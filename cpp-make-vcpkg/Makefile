ifeq ($(shell uname),Linux)
	VCPKG_INSTALLED = ./vcpkg_installed/x64-linux
endif

ifeq ($(shell uname),Darwin)
	VCPKG_INSTALLED = ./vcpkg_installed/arm64-osx
endif

PKG_CONFIG_PATH = $(VCPKG_INSTALLED)/lib/pkgconfig
ALL_PKG := $(shell ls $(PKG_CONFIG_PATH) | cut -d . -f 1)
PKG_CONFIG = PKG_CONFIG_PATH=$(PKG_CONFIG_PATH) pkg-config
PKG_FLAGS := $(shell $(PKG_CONFIG) --cflags --libs $(ALL_PKG)) -isystem $(VCPKG_INSTALLED)/include

CC = clang++
CC_FLAGS = $(PKG_FLAGS) -pedantic -Wall -Wextra -std=c++20 -pthread -static -Wl,--as-needed

PROTOC = $(VCPKG_INSTALLED)/tools/protobuf/protoc
GRPC_CC_PLUGIN = $(VCPKG_INSTALLED)/tools/grpc/grpc_cpp_plugin
PROTO_PATH = ./protos

OUT_PATH = ./build

$(shell mkdir -p $(OUT_PATH))

all: client server

client: proto
	$(CC) src/client.cc -I. -L$(OUT_PATH) -l:calculator.pb.a -l:calculator.grpc.pb.a $(CC_FLAGS) -o $(OUT_PATH)/client

server: proto
	$(CC) src/server.cc -I. -L$(OUT_PATH) -l:calculator.pb.a -l:calculator.grpc.pb.a $(CC_FLAGS) -o $(OUT_PATH)/server

proto: gen_proto
	$(CC) -c -fPIC -Wno-unused-command-line-argument $(OUT_PATH)/calculator.pb.cc $(PKG_FLAGS) -o $(OUT_PATH)/calculator.pb.o
	$(CC) -c -fPIC -Wno-unused-command-line-argument $(OUT_PATH)/calculator.grpc.pb.cc $(PKG_FLAGS) -o $(OUT_PATH)/calculator.grpc.pb.o
	ar rcs $(OUT_PATH)/calculator.pb.a $(OUT_PATH)/calculator.pb.o
	ar rcs $(OUT_PATH)/calculator.grpc.pb.a $(OUT_PATH)/calculator.pb.o $(OUT_PATH)/calculator.grpc.pb.o

gen_proto:
	$(PROTOC) --proto_path=$(PROTO_PATH) --cpp_out=$(OUT_PATH) $(PROTO_PATH)/*.proto
	$(PROTOC) --proto_path=$(PROTO_PATH) --grpc_out=$(OUT_PATH) --plugin=protoc-gen-grpc=$(GRPC_CC_PLUGIN) $(PROTO_PATH)/*.proto

clean:
	rm -rf $(OUT_PATH)
