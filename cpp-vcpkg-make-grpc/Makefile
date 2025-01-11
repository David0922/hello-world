CC = clang++
CXX_STANDARD = -std=c++20

ifeq ($(shell uname),Darwin)
	VCPKG_INSTALLED = ./vcpkg_installed/arm64-osx

	PKG_INCLUDE = $(VCPKG_INSTALLED)/include
	PKG_LIBS := $(shell ls $(VCPKG_INSTALLED)/lib | grep '\.a$$' | sed 's/lib/-l/' | sed 's/\.a//')
	PKG_FLAGS = $(CXX_STANDARD) -I$(PKG_INCLUDE) -L$(VCPKG_INSTALLED)/lib $(PKG_LIBS) -pthread -isystem $(PKG_INCLUDE)

	CC_FLAGS = $(CXX_STANDARD) $(PKG_FLAGS) -pedantic -Wall -Wextra -framework CoreFoundation
endif

ifeq ($(shell uname),Linux)
	VCPKG_INSTALLED = ./vcpkg_installed/x64-linux

	PKG_CONFIG_PATH = $(VCPKG_INSTALLED)/lib/pkgconfig
	ALL_PKG := $(shell ls $(PKG_CONFIG_PATH) | cut -d . -f 1)
	PKG_CONFIG = PKG_CONFIG_PATH=$(PKG_CONFIG_PATH) pkg-config
	PKG_FLAGS := $(shell $(PKG_CONFIG) --cflags --libs $(ALL_PKG)) -isystem $(VCPKG_INSTALLED)/include

	CC_FLAGS = $(CXX_STANDARD) $(PKG_FLAGS) -pedantic -Wall -Wextra -pthread -static -Wl,--as-needed
endif

PROTOC = $(VCPKG_INSTALLED)/tools/protobuf/protoc
GRPC_CC_PLUGIN = $(VCPKG_INSTALLED)/tools/grpc/grpc_cpp_plugin
PROTO_PATH = ./protos

OUT_PATH = ./build

$(shell mkdir -p $(OUT_PATH))

all: client server

client: proto
	$(CC) src/client.cc -I. -L$(OUT_PATH) -lcalculator.pb -lcalculator.grpc.pb $(CC_FLAGS) -o $(OUT_PATH)/client

server: proto
	$(CC) src/server.cc -I. -L$(OUT_PATH) -lcalculator.pb -lcalculator.grpc.pb $(CC_FLAGS) -o $(OUT_PATH)/server

proto: gen_proto
	$(CC) -c -fPIC -Wno-unused-command-line-argument $(OUT_PATH)/calculator.pb.cc $(PKG_FLAGS) -o $(OUT_PATH)/calculator.pb.o
	$(CC) -c -fPIC -Wno-unused-command-line-argument $(OUT_PATH)/calculator.grpc.pb.cc $(PKG_FLAGS) -o $(OUT_PATH)/calculator.grpc.pb.o
	ar rcs $(OUT_PATH)/libcalculator.pb.a $(OUT_PATH)/calculator.pb.o
	ar rcs $(OUT_PATH)/libcalculator.grpc.pb.a $(OUT_PATH)/calculator.pb.o $(OUT_PATH)/calculator.grpc.pb.o

gen_proto:
	$(PROTOC) --proto_path=$(PROTO_PATH) --cpp_out=$(OUT_PATH) $(PROTO_PATH)/*.proto
	$(PROTOC) --proto_path=$(PROTO_PATH) --grpc_out=$(OUT_PATH) --plugin=protoc-gen-grpc=$(GRPC_CC_PLUGIN) $(PROTO_PATH)/*.proto

clean:
	rm -rf $(OUT_PATH)
