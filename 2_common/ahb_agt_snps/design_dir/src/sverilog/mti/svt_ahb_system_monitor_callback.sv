
`ifndef GUARD_SVT_AHB_SYSTEM_MONITOR_CALLBACK_SV
`define GUARD_SVT_AHB_SYSTEM_MONITOR_CALLBACK_SV
/**
  * AHB System monitor callback class contains the callback methods called by the 
  * AHB system monitor component.
  */
`ifdef SVT_VMM_TECHNOLOGY
class svt_ahb_system_monitor_callback extends svt_xactor_callbacks;
`else
class svt_ahb_system_monitor_callback extends svt_callback;  
`endif

  //----------------------------------------------------------------------------
  /** CONSTUCTOR: Create a new callback instance */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new();
`else
  extern function new(string name = "svt_ahb_system_monitor_callback");
`endif

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
TmTH399d628Rvc3vPKZT0ABO6+pNvca8a0MsmF74sUtr9t7Pkawl7r6HZqhJxhMB
ciDRDQqPRTwCUqowM+JzTC3r1I9ASGwEnhdAOhIaKVsnJZJEnFpWVfYGnAOGBeb6
d/KADDPvL1qFATeI+wB4/tlBtcTgkvXR1niegK01M94=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1861      )
I47QK7D/oZGoEVrD5APfuDZmB7HcF9FhQYIjjo3LN7YV2GMOn67JOUpKoEhOm7ng
026LXAdDeq1ZUFUeqGDXwY5w488NjY5sUWKwttm+95P20FrKrcZrO9elCjmEr3CQ
7X+xmpuy2ubxMrddJXxRFRzk4M7Q9NYx5sJLxOTmP6iuHvv1fBjN1Vd/1ZMF1y6q
lYBIIX45CFd8DESc+zA3o5VVEsYZgWpsH0NNAJHJvy8rZPjncdzz6Zu3fO+BXBsb
T7K0N3qxyi0qs/VHEmUK4Rash+Ud3tS0UfYz64cA4l5gIyBGlVPM772F3YyaSH+K
/w1Wp+uN+LoCcn0frRmgaT2fEZk3HE1d2Vvh9p6de/EVPNQbiHOPSp7tsWegfyl4
7HO3XK0b8B9xZPWnBKNDmznKgV4IMSHXafxxMYnFJ31C32pq8sT1LGHEVi0vZ1Un
Xl8zvQ81kJTE8ZOuJIxNX2sO/6c3WKqqyt0+Ld5TGZiNVZuvm/O65ZwYlM4PTCfo
C2kv1HPgh63Kv9w4D1mNnJnb22pkWXg3cnn9754cuXCa0pbFOeZMCjzbPVFJrKDh
i2nAYi1b3IIhNUjpY037FDzUWTmaMtHgFTYS/dD88l8WWpiTgBo7gZ3Da2E90ZNx
URE7c5z+yJLjZs9Gf+S3oOWQBLES4m1xtzfuhXL7ElqeI+yRMqShOVXgyqa9car9
vEX0CqyqjamDAcyLqxByefrJDCrbUtxJ/xjjvW8DkJWBmHKpgIU7Gu45wWfD7MOW
ja+k0rpSsH95jkd8x4rapSEJCv8p6koZ0hKgASOrKzjWS8dnt7nxHvfAMyssI9R7
HZu4z16LvJ7VPdTYKd+BWtfYjKs1H+nk/RP36Jjj8cSYXKwd0O4wODeAWmfr0DeW
t0G6S+9OlXRT7JjKVYW25/wDtciOQPt0O/Wq13NR83EVXkLdoGgrhHra/kA/r7Tf
Yw0bZrBP/P1ogmHpILUdAf8mKKgxdfF4Ko5W61AL2tB5c7AbteQuHH6UHdFmfyhr
Y8OuL+gHmo6M7tinNmAFJkxkxSovgPLHMEe8yvgGpjhQJUbxGbptA68jQJUfA75X
CIE/UUOjxkM4FXVJVkVlhtg/363EO1dqApLT/hJd1KAHXb8qaMnuPIS6OldxvAda
vhsvKVaFI+tye2gc+sBFgViVj2Zp7kC1HECDvveCj3mqp0ItKtmCIvkD/zb1pu12
CT6GCrKjg1nl6y56IOBl6wLPPoZtnyIXbybLfAzLkFrGLrkvs0va9A6WHfNNo5/D
xA9yKTevVah4q5YLAqm7yYEIuMpXojtPvZsMWgFqHVb3o5vMgmFGOMgURSeOoiGI
Z6U+H2ZSx3DGYTJWTxJBO7OMCAom2CocfFwdvj//CUsN8NXm/kUH1Vy6CHVQyO8M
EYoKS2BhdCMOSAqLAb9Ic0xfUf/+6UvOqrT4M/NPueW2QDYeg6lxxXpvD3iYFK/R
X3SdvD06VFmQAm1qaoSRslzhwb7yc/Qw1Rdo07Vsjt7LQVn/OZjqBCSGjwR1V9X6
f7+zz5cHXJJ0RoedsXtN5gDmSnP1bAlBoTxSCGVGyNrKZpw3GSm/yXNt0C3+IYuL
hPSYnAuCt9Y5VjaLGmnO91TpkS3JWO2N9/JD7IlWTb3WJ3D3zhTYJ2iCQWDixMOz
wt+kA59nb5UTWX0g6qvd2ff/yicJDezQvzBqY5qszRz8iQ3tTp+a+4+ZBXTLcwJj
PN+S30Qysd/kfdkCFI5ok+aTv82sepyIVbRp7v4MuibyvAHbodhVgqk3lNQFquvM
C/5n4ook+vBQlx7FCP3H1SV11WTwnHwAmaDE7CC1tbFEtxrORkxYpTQ3QPdQ7Okb
JH4aMcIvpCtRMgENp61uNxS7Eu38LWLrJH8sOtYwmslxsQlIZUNKIEAy4AWqyrfz
WFq37XnIZg0t58naf+0Mw1yrJ6DeK4vCF3uGAIy2JIoHMBYMQy3CHxO2G/St2Equ
6lmAXyAkD5Bw1QREVVqTGW0/66b/fcG49H1rv+xfaJeHJlFc/0tCGWb/YorJPxl8
ZLEd/SDSMj502MermrhUaGaiklrmYbRFB1SzsXT+JF+sr7Q56Ed734VH9tKWlnw4
3zd3SGGt3/QOePFMAyKhs0GZExe6u1Ooi5TSvDSjlQAbjOT2Hj7nqCXKf1uO5IO+
Khl4rPHmLVzHem5WQvFmLWBSLg5cIFkvencSGvjBMmvg5rkumnyMJU7/CbfjCQ0n
bEr4jzA61nwtyxH5zOBpzVxo4rbx0Yla9LYhAMQ4qf4GmGuIH5SGlIzBqnLSDiWZ
7kf1vL4NHJhyj9aokV+Wi4xU3puWc0kM/2Ay9dsmaFFV6qecXsnlksLQ71nZzRv+
ep/A0jqpmieoghM3GJ/nsPqChSmzShyKeNN0ROSYOb57ajRPwogsErbDiSLaiexF
kgZjP/gbQ5sE5vPVTtyvlG8175BPMW0c+SFDfErqX9zo0xZNjZkGgRtNGQfxNgiK
`pragma protect end_protected
endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
izfKSL6aSkVXgozrK3AKi20MpiNrmh+Xer/eZNcIGgxK8cwSnhv/h4+Soid0b792
ll/jeFboLItLklhoWylvCNNjdJ96pO2tBlIsV8jo4jth/3JDKk46h5PkpTvuu2lK
mpo9oo64W9RWRvOYRalB/eC/TSVuLiPoIYzVhlKOwXY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2265      )
CRGWt89+CQM/If3+CzHSQrTihqLBu8IZfe8gHClATF8tbeUJvTPad/62GH/bHyNV
CAYeUdRqoVxuHFbS9YZpVttyW/I8lDV8sGqHWvRQqHS5nKrOXk+f4v3hLUWRaMJw
kBaFS992JachDZwaTA0SQRDoEwBBRSU5N1RVbnudJXuwd/pEZsiZgeNKR3IUmAX7
F/BudlSa4RC9UmGCyeEmJQ77haB21B/g1YIHAu0yFl/0tggnurBzeG54zqUwcpC4
LxqzjwfZMFVJua8/amFvifWwCQVaBiwBikXZVKPdxbAHV3sLXmW0bGYjqKgNIXZZ
xYfevXXI0ryR0w9cXnxcBBhaKYVKGcTpe+xNWD9mYaCIdvo3zY9I8qQSMuRgzxNr
A86N9t38r1bpKPMbSkntc9uljPFlgGZ6f2oPuIXzISVu+VIQ73NNK4HF+kTLEEV/
AP4g8NYpteC578LcHP1YkDzCPT/CInV8feUJlIDhM+XxY5U1m4GCQ0xPAqMNw7ex
aKT9et0gz86wAPWYpBsHzKIajquS75TvIyaJJXtpwfA=
`pragma protect end_protected

`endif // GUARD_SVT_AHB_SYSTEM_MONITOR_CALLBACK_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
BDmoO02BLgvPv7oWZapdA6AzFbIauhXn8wYpJRSpJFgxVjbMJ2KUXwjAFiMnGjPr
7fvHTeki2amM2Ewv3XppmteMyoZHhhj4ug4q/tdSpVnLPItfHLgHUWTbFLuZASgw
/ZIRoOcMGgfA1tfhAvwULXjWF9x6tK01Gk1J0QMXGv0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2348      )
ImM/liY7qcPMXUCpa2MT9uIU8GM6O+PmelkpnPkrxc9JRtN1quVq+qLa9F00f8QQ
RD5UkugCfYAMfYL1Zn/iezHeaccarH0WsOPJC2UvAlyc+7hHyKB3lp1/2u53gPvV
`pragma protect end_protected
