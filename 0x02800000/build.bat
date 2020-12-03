bin2s rocketlauncher.bin > rocketlauncher.S
arm-none-eabi-gcc -march=armv4t -mthumb -mthumb-interwork -s -c rocketlauncher.S
arm-none-eabi-gcc -march=armv4t -mthumb -mthumb-interwork -s -c armShit.S
arm-none-eabi-ld -o a.elf -S -T a.ld rocketlauncher.o armShit.o
arm-none-eabi-objdump -x a.elf
arm-none-eabi-objcopy a.elf -Obinary -S rocketlauncher_out.bin
del a.elf
del a.s
del armShit.o
del rocketlauncher.o
del rocketlauncher.S
pause