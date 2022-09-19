# myrouter

> scripts to install and config transparent proxy on my router, a UBNT erx.
> 
> As far as I am concered, erx is a valid family-router choice. It's small  enough to fit in my enclosure. I don't need a dream machine or dream machine pro as they are really overkill. Nor do I need more LAN interfaces than 3. The erx is cheap and did its job well.

## proxy client

As [shadowsocks](https://github.com/shadowsocks/shadowsocks) is a bit outdated and could be recognized by GFW, I switched to [trojan](https://github.com/trojan-gfw/trojan) years ago. I have been using trojan clients on my devices since then and it's steady as rock.

Recently I bought a new android TV and willing to enjoy some Netflix or Youtube TV, but they are all blocked by GFW. I used to run [shadowsocks TV](https://play.google.com/store/apps/details?id=com.github.shadowsocks.tv) on my previous android TV, but the project was not maintained and cannot be installed on my new TV.

The problem is that, erx uses MIPS cpu (mipsel), and `trojan` is not yet compiled on that platform. I either need to compile `trojan` on erx (not possible due to the limitation of 256MB RAM and 256 MB storage)
