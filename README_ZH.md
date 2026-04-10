# CLS Proxy 在 Ubuntu 24.04 上的依赖

这种东西应该已经装好了`sudo apt show build-essential cmake`

- https://stackoverflow.com/questions/56794557/why-there-is-no-precompiled-c-library-for-grpc
- https://ubuntu.pkgs.org/24.04/ubuntu-universe-amd64/libgrpc-dev_1.51.1-4.1build5_amd64.deb.html
- https://ubuntu.pkgs.org/22.04/ubuntu-universe-amd64/libgrpc-dev_1.30.2-3build6_amd64.deb.html

本项目的依赖在Ubuntu 24.04下才能发现CMake包，否则需要手动编译库。安装这几个包

`sudo apt install thrift-compiler protobuf-compiler-grpc libgrpc++-dev libthrift-dev`

# CLS Proxy 在 MSYS2-UCRT64 上的依赖

参考自[Wiki](https://github.com/CLSFramework/cross-language-soccer-framework/wiki/Soccer-Simulation-Proxy)

在MSYS2-UCRT64环境下测试成功。环境部署教程：
- 安装make等基本构建工具`pacman -S base-devel`
- 安装编译器工具链`pacman -S mingw-w64-ucrt-x86_64-toolchain`
- 安装autoconf、automake、libtool构建工具`pacman -S mingw-w64-ucrt-x86_64-autotools`
- 安装cmake构建工具`mingw-w64-ucrt-x86_64-cmake`

本项目的依赖是这两个
```sh
pacman -S mingw-w64-ucrt-x86_64-grpc \
          mingw-w64-ucrt-x86_64-thrift
```

# CLS Proxy 正式构建

然后就可以使用cmake构建了。项目比较大，直接用`-j`参数会卡死
```sh
rm -r build
cmake -S . -B build -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release
cmake --build build -j16
```

但是，如果因为GRPC版本不匹配而报错，应当删除`src/grpc-generated`下的`service.pb.cc`和`service.pb.h`（原文写错了，写成了`src/grpc`目录下的）重新生成。由于我们的GRPC是安装版的，所以`C:\msys64\ucrt64\bin\protoc.exe`和`C:\msys64\ucrt64\bin\grpc_cpp_plugin.exe`可以直接被访问到，所以命令会简单点
```sh
protoc --proto_path=. --cpp_out=../../src/grpc-generated/ --grpc_out=../../src/grpc-generated/ --plugin=protoc-gen-grpc=grpc_cpp_plugin service.proto
```

## 临时直接运行

To run the Soccer Simulation Proxy, you can use the following command: (You should run the Soccer Simulation Server and a PlayMaker Server before running the Soccer Simulation Proxy)
```sh
cd build/bin
./start.sh
```

在Powershell内执行，还需要环境变量，添加msys2的路径到PATH
```powershell
$env:Path = "C:\msys64\ucrt64\bin;C:\msys64\usr\bin;$env:Path"
```

# CLS Proxy Appimage 打包发布

官方使用 Appimage 格式打包，注意请保持github访问通畅

```sh
utils/app-image/create_app_images.sh
cp -r utils/app-image/soccer-simulation-proxy release
```
