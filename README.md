I was using this: 
[link to linux on javascript](https://bellard.org/jslinux/vm.html?cpu=riscv64&url=buildroot-riscv64.cfg&mem=256)
to run the code. The man who created this is a Legend. I used gcc to compile the assembly code. The flags are simply `gcc assembly -o executable`. You can write a C program and then get the assembly to use as a template by doing `gcc -S -O1 -o assembly.s cprogram.c`. You can upload your code (faster than trying to use vi/vim if you don't use terminal-based text editors). You upload it by using the button that has an upward-facing arrow that's below the terminal window.


But actually [Fedora](https://bellard.org/jslinux/vm.html?cpu=riscv64&url=fedora33-riscv.cfg&mem=256) might be better. The other one is faster but fedora's got vim and I think a package manager that's usable, maybe.

Now, there's another project called [rars](https://github.com/TheThirdOne/rars) that's written in Java so one should be able to run it on almost any computer. This is a fuller IDE that's got auto-completion suggestions and a nice GUI. The kind person who decided this would be their summer project is my hero.

The code here is assembly for 32-bit RISC-V IMFDN (hopefully that's correct. Only sure about the 32-bit part). I chose to use `.s` as an extension because it reminds me of a professor whose lectures I enjoyed a lot. Back when we learned MIPS using MARS. I remember he was hoping a project like RARS would be made. He never introduced himself, but I'm pretty sure his name was Thomas riordan.

To run the commands that take arguments from the terminal:
```
java -jar rars_IDE_FILENAME.jar assemblyFileWrittenByYou.s nc pa Some arguments
```
