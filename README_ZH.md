# CLS Proxy for Ubuntu

`sudo apt install libthrift-dev thrift-compiler protobuf-compiler-grpc libgrpc++-dev`

https://stackoverflow.com/questions/56794557/why-there-is-no-precompiled-c-library-for-grpc

https://ubuntu.pkgs.org/24.04/ubuntu-universe-amd64/libgrpc-dev_1.51.1-4.1build5_amd64.deb.html
https://ubuntu.pkgs.org/22.04/ubuntu-universe-amd64/libgrpc-dev_1.30.2-3build6_amd64.deb.html
用24.04！

# CLS Proxy for MSYS2-UCRT64

参考自[Wiki](https://github.com/CLSFramework/cross-language-soccer-framework/wiki/Soccer-Simulation-Proxy)

## 环境配置

在MSYS2-UCRT64环境下测试成功。环境部署教程：
- 安装make等基本构建工具`pacman -S base-devel`
- 安装编译器工具链`pacman -S mingw-w64-ucrt-x86_64-toolchain`
- 安装autoconf、automake、libtool构建工具`pacman -S mingw-w64-ucrt-x86_64-autotools`
- 安装cmake构建工具`mingw-w64-ucrt-x86_64-cmake`

## 构建

本项目的依赖是这两个
```sh
pacman -S mingw-w64-ucrt-x86_64-grpc \
          mingw-w64-ucrt-x86_64-thrift
```

然后就可以使用cmake构建了
```sh
rm -r build
cmake -S . -B build -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release
cmake --build build -j
```

但是，如果因为GRPC版本不匹配而报错，应当删除`src/grpc-generated`下的`service.pb.cc`和`service.pb.h`重新生成（原文写错了，写成了`src/grpc`目录下的）。

由于我们的GRPC是安装版的，所以`C:\msys64\ucrt64\bin\protoc.exe`和`C:\msys64\ucrt64\bin\grpc_cpp_plugin.exe`可以直接被访问到，所以命令会简单点
```sh
protoc --proto_path=. --cpp_out=../../src/grpc-generated/ --grpc_out=../../src/grpc-generated/ --plugin=protoc-gen-grpc=grpc_cpp_plugin service.proto
```

## 直接执行

To run the Soccer Simulation Proxy, you can use the following command: (You should run the Soccer Simulation Server and a PlayMaker Server before running the Soccer Simulation Proxy)
```sh
cd build/bin
./start.sh
```

在Powershell内执行，还需要环境变量，添加msys2的路径到PATH
```powershell
$env:Path = "C:\msys64\ucrt64\bin;C:\msys64\usr\bin;$env:Path"
```

## 发布后执行

发布可以把需要的DLL都集中到软件目录内，便于在其他平台运行
- Windows发布用`cmake --install build --prefix dist/windows`
- Linux发布用`cmake --install build --prefix dist/linux`

发布后，可以把`dist/windows/bin`或`dist/linux/bin`取出来，放在别处运行。