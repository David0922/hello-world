## install dependencies

```bash
vcpkg --disable-metrics install --recurse
```

## update vcpkg baseline

```bash
vcpkg --disable-metrics x-update-baseline
```

## show package versions

```bash
vcpkg --disable-metrics list
```

## format C++ & protobuf

```bash
find . -path ./vcpkg_installed -prune -o -type f \( -name '*.cc' -o -name '*.h' -o -iname '*.proto' \) -exec clang-format -i {} +
```
