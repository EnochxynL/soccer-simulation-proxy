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
mkdir build
cd build
cmake -G "Unix Makefiles" ..
make -j
```

但是，如果因为GRPC版本不匹配而报错，应当删除`src/grpc-generated`下的`service.pb.cc`和`service.pb.h`重新生成（原文写错了，写成了`src/grpc`目录下的）。

由于我们的GRPC是安装版的，所以`C:\msys64\ucrt64\bin\protoc.exe`和`C:\msys64\ucrt64\bin\grpc_cpp_plugin.exe`可以直接被访问到，所以命令会简单点
```sh
protoc --proto_path=. --cpp_out=../../src/grpc-generated/ --grpc_out=../../src/grpc-generated/ --plugin=protoc-gen-grpc=grpc_cpp_plugin service.proto
```

To run the Soccer Simulation Proxy, you can use the following command: (You should run the Soccer Simulation Server and a PlayMaker Server before running the Soccer Simulation Proxy)
```sh
cd build/bin
./start.sh
```

很遗憾，虽然我生成了.ps1脚本，但是很多运行库在MSYS2内部，Powershell发现不了，所以无法运行
