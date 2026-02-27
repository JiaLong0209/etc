
# Logiops 

```bash

systemctl status logid 
sudo systemctl restart logid

sudo logid -v

```
## MX Ergo S

Button:

*  CID  | reprog? | fn key? | mouse key? | gesture support?
*  0x50 |         |         | YES        |                  |
*  0x51 |         |         | YES        |                  | 
*  0x52 | YES     |         | YES        | YES              | Middle Click
*  0x53 | YES     |         | YES        | YES              | Back Button
*  0x56 | YES     |         | YES        | YES              | Forward Button
*  0x5b | YES     |         | YES        | YES              | Left tilt 
*  0x5d | YES     |         | YES        | YES              | Right tilt
*  0xd7 | YES     |         |            | YES              | 
*  0xfd | YES     |         | YES        | YES              | Precision Mode Button

/etc/logid.cfg 

```bash
devices: (
{
    name: "MX Ergo S";
    dpi: 500;

    hi-res-scroll:
    {
        hires: false;
        invert: false;
        target: false;
    };

    // 3. Button Remapping (Optional)
    // Based on your debug output, here are the likely identities of your buttons:
    // 0x52: Middle Click
    // 0x53: Back Button
    // 0x56: Forward Button
    // 0xd7: Precision Mode Button (The small button near the trackball)
    buttons: (
        // 1. Back Button (CID 0x53) -> Left Click
        {
            cid: 0x53;
            action:
            {
                type: "Keypress";
                keys: ["BTN_LEFT"];
            };
        },

        // 2. Forward Button (CID 0x56) -> Enter Key
        {
            cid: 0x56;
            action:
            {
                type: "Keypress";
                keys: ["KEY_ENTER"];
            };
        },

 

        // 3. Precision Button (Force Firmware Override)
        {
            cid: 0xfd;
            action:
            {
                type: "ChangeDPI";
                sensor: 0;
                dpis: [600, 300]; 
                inc: 0;
            };
            reprog: true;       // <--- CRITICAL: Tells hardware to stop using internal logi
c
            // mode: "OnRelease";  // <--- CRITICAL: Prevents "hold" behavior glitches
        }
    );
}

```
