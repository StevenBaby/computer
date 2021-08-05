# Ubuntu 配置 bochs 的方法

## 安装 bochs

执行命令：

    sudo apt install bochs
    sudo apt install bochs-x

其中最重要的是 `bochs-x` 这个包，包括了 gui 插件。

## 配置 Bochs

执行命令：

    bochs

选择 `4. Save options to...`

然后输入文件名 `bochsrc` 直接保存

选择 `7. Quit now` 退出 bochs

然后创建虚拟磁盘，输入命令

    bximage -hd -mode="flat" -size=60 -q master.img

这样就可以创建一个 16M 的硬盘。

输出的最下面输出了以下内容：

```text
The following line should appear in your bochsrc:
  ata0-master: type=disk, path="master.img", mode=flat
```

也就是说要将上面这样代码写到 `bochsrc` 中，

然后将 `display_library: x` 改成 `display_library: x, options="gui_debug"` 以支持 GUI 的调试方式。

将 `boot: floppy` 改成 `boot: disk`，以支持从硬盘启动。

## 编辑代码

输入命令：

    touch hello.asm

然后使用文本编辑起写入如下内容：

```s
mov ax, 0xb800
mov ds, ax; 将代码段设置为 0xb800

mov byte [0], 'T'; 修改屏幕第一个字符为 T

; 下面阻塞停下来
halt:
    jmp halt

times 510 - ($ - $$) db 0 ; 用 0 填充满 510 个字节
db 0x55, 0xaa; 主引导扇区最后两个字节必须是 0x55aa
```

安装 `nasm` 汇编器：

    sudo apt install nasm

然后汇编成二进制代码：

    nasm -f bin hello.asm -o hello.bin

然后将主引导扇区写入硬盘：

    dd if=hello.bin of=master.img bs=512 count=1 conv=notrunc

启动 `bochs` 测试环境：

    bochs -q

## 参考资料

- [修改ubuntu 18.04的sources.list源为阿里或清华镜像的方法_Linux_脚本之家 (jb51.net)](https://www.jb51.net/article/193933.htm)
- [x86 汇编语言 - 01 配置开发环境 (ccyg.studio)](http://blog.ccyg.studio/article/eedcc300-35f4-4174-9622-c336aa8d7881/)
- <https://packages.debian.org/unstable/bochs-x>
