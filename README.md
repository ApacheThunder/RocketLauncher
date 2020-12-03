# RocketLauncher
RocketLauncher exploit for Nintendo DSi (Obsolete. Please use Unlaunch instead)

This source has been released for documentation purposes. Assistance will not be provided to those who wish to compile and use this.

RocketLauncher was an exploit involving the DS Cart Whitelist file and a modified rom stored on a DS flashcart. 
(An Acekard2i was used for testing/developing this project).

A few people are credited with helping build this up. I was mostly responsible for figuring out the offsets to use in the DS Cart White list
and sorting out where to put the payload in the rom file.

In this source the payload was stored at 0xA3C0. You may need to store this else where depending on the space constraints of the flashcart you intend to use.

The goal of the exploit is to use the 3rd section of the DS Cart white list (the section used to blacklist flashcarts ironically. :P ) to cause a overflow
into ram. The original exploit could be used to take over either CPU. But originally we took over arm7 as it was easier. The cart reads occured from arm7 so
unlike most other exploits this one actually took place from arm7 rather then arm9. The overflow places our payload at a specific offset in ram. I believe
this was the exception vector/interrupt vector that the Arm7 jumps to if an exception occurs which occurs immedietely after it finishes reading the cart data.

There is no bounds checks on the size of the data requested to be read using details from the 3rd section of the DS Cart White list.

I used a quirk with Acekard 2i to cause my payload to appear at that specific area in ram. Acekard2i wraps and repeats it's entire flash contents if you
try to read beyond the limit of it's internal storage dedeicated to the rom. At one point I was able to store the payload in the first rom while using the 2nd
rom to trigger the exploit. (Acekard 2i has 2 roms. One it shows DS/DS Lite consoles, and the second one used for DSi and 3DS)

Unfortunately details beyond this are hazy due to how long it has been since I last worked on this. I can't help much beyond what I've managed to remember about it here.

If you want to attempt to set this up yourself be sure to have a reliable nand dump/restore app for the DSi. It is highly recommended you not attempt to use this unless you
have a nand modded DSi as it is possible to cause a brick if something goes wrong with flashing a modified nand dump back to the DSi. I am not responsible for anyone who bricks their
console trying to use this. Use Unlaunch instead you are intending to hack your console. This source was provided only for educational purposes.

Firmware 1.4 is required to use this. That was the only version of DSi system firmware that this exploit worked on. The exploit is not region specific. It is known to work
on the 3 main regaions. USA, Europe, and Japan. Korean/Chinease firmwares may be different and have not been tested.

A snippet of a typical entry for section 3 of DS Cart White list will be provided to give you an idea on how it was setup. Knowledge on how the DS Cart White list file is setup
is required to know how to set this up. Please refer to NoCash'es documentation of DS/DSi specs here if you need to know the details on that: http://problemkaputt.de/gbatek.htm

RocketLauncher_Universal_Blowfish.bin: 
This is the blowfish table. I overwrote the section for blowfish for the custom rom stored in AceKard 2i so I can use my one game code and not borrow an existing one.
The blowfish key for the second rom was stored at 0x80000 on Acekard 2i. This is where you'd write this file's contents to.
If you don't know how to set this up you'll need to use an existing rom Acekard 2i used as the spoof rom (the second section of it's internal flash) for DSi/3DS.

RocketLauncher_Payload.bin:
The compiled payload before being placed in either the first or second rom of AceKard2i.

CartWhiteListEntries.bin:
The entire final section in DS Cart White list file (the entire file will not be provided for copyright reasons. Don't want Nintendo's ninjas to come get me. :P )
The entry for RocketLauncher's rom was added here. The entire section is provided. If you remove/add entries to it you will need to update the offsets used for the RocketLauncher entry as the file size of the DS Cart White list file can cuase the overflow to land at a different ram offset.
I may have had other custom entries in the white list at the time. You'll probably still need to fix the rom read size info in the RocketLauncher entry to correct it.
No$GBA emulator will be useful in helping you determine where it should end up.

backup.bin:
This is the complete backup of AceKard 2i with RocketLaunch rom installed. I don't know if this is up to date to the last build I made so may not work with
the provided DS Cart White list entry. You may have to adjust the DS Cart White list entry to make the version found in this backup work.
This is mainly provided to give you an idea on where the payload was stored in the Acekard2i's internal storage.

Oh also, the RocketLauncher rom used to trigger the exploit has the autoboot flag in the NTR header set. This makes the DSi autoboot the cart when inserted.

This is the ONLY way this exploit works. It's theoretically possible to trigger this exploit by trying to boot the rom from System Menu but would be difficult due to changes in ram contents/offsets while system menu is running.
So this was only attempted from autoboot which was a much more consistant environment to trigger the exploit from.

The 0x0280000 folder contains code that modifies the final payload. This is setup so that when executed from that specific arm7 ram address, it makes arm7 jump to
a specific address after writing the actual payload to that address. Only the minimum code for making the arm7 jump is stored at the final address the overflow lands on.

The compiled payload from the main source try is copied here then the build.bat file is run to append the payload with the code for making the arm7 jump to a copy of it at 0x2800000.
At least that's what I recalled. As I've said it's been awhile since I've worked on it. From what I remember the jump address info is stored at 0x0380D000 in ram.

The 0x280000 jump location is stored here. When the overflow overwrites it with this info and finishes arm7 triggers exception/interrupt and reads this address and jumps to it.
That is the core of how our code gets executed. So basically you need to build the Acekard2i rom and store it in a specific place on Acekard 2i and make sure the DS Cart White list is setup correctly
so that when it overflows that the correct data ends up at 0x0380D000. ;)


Credits to those who helped work on this project:

Stuckpixel
Normmatt
Gericom
Shutterbug2000
NoCash dev behind No$GBA. (He helped research what was going on with this exploit for me after I first discovered it.)

If there was someone I forgot, let me know and I'll add them.


