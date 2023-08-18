
`ifndef GUARD_SVT_AHB_SLAVE_MONITOR_SYSTEM_CHECKER_CALLBACK_SV
`define GUARD_SVT_AHB_SLAVE_MONITOR_SYSTEM_CHECKER_CALLBACK_SV
// =============================================================================
/**
 * The svt_ahb_slave_monitor_system_checker_callback class is extended from the
 * #svt_ahb_slave_monitor_callback class in order to put transactions into a fifo
 * that connects to the system level checker 
 */

class svt_ahb_slave_monitor_system_checker_callback extends svt_ahb_slave_monitor_callback;

  svt_ahb_slave_configuration cfg;

  `ifdef SVT_UVM_TECHNOLOGY
  /** Fifo into which transactions of type svt_ahb_slave_transaction are put */ 
  uvm_tlm_fifo#(svt_ahb_transaction) ahb_slave_transaction_fifo;

  /** Fifo into which transactions of type svt_ahb_slave_transaction are put - Used by AMBA System Monitor */ 
  uvm_tlm_fifo#(svt_ahb_transaction) amba_ahb_slave_transaction_fifo;

  `elsif SVT_OVM_TECHNOLOGY
  /** Fifo into which transactions of type svt_ahb_slave_transaction are put */ 
  tlm_fifo#(svt_ahb_transaction) ahb_slave_transaction_fifo;

  /** Fifo into which transactions of type svt_ahb_slave_transaction are put - Used by AMBA System Monitor */ 
  tlm_fifo#(svt_ahb_transaction) amba_ahb_slave_transaction_fifo;

  `else
  vmm_log log;
  /** Channel through which checker gets transactions initiated from slave to bus */
  svt_ahb_transaction_channel ahb_slave_transaction_fifo;
  /** Channel through which checker gets transactions initiated from slave to bus - Used by AMBA System Monitor */
  svt_ahb_transaction_channel amba_ahb_slave_transaction_fifo;
  `endif

  // -----------------------------------------------------------------------------
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
BFRLwlXHclYYNEP36rEg2OCI7TVo3J+6/uLor5awoUsa1Te1jBBw0VUj6n1ns7Cf
EnWnYZVLMcoTIBqMg3gMCImqBVRDRZEUhfH8QBo7mnVJMlNb8J8Czs2pVnR0u3qT
DvmMwY23jdOi8Qf0FnkkWLZqJgy7t6lXD4eF/bT8ZNKNE1k0vqjJ4A==
//pragma protect end_key_block
//pragma protect digest_block
p9vR06b5MTHG71WPGH3rVpyrfWQ=
//pragma protect end_digest_block
//pragma protect data_block
JV4YCK5hd50uL5UBlhd7YahuKNi//AY2/Nh0kGawIz4dLturl6r/9jmpDv5BySPg
4B9ncEZgrmmYaIU90YUbjIW59q1St5lBDfUSZf0cYwa0uURzO62xaeuePVQwOq7c
O9JFYS7ACq/5Y2JBU6yQ/tVPHtS7CQ2y14AVq3OxKOFTOMU7pkOKvEiPceFi7UYw
Cgn6L5uz1eNTBOzQT4/QHWqNnHTt7TYXFgA5BjwkwNrVv4knXRLCfzer+viYKLuC
w58JeADGmVR/wXR8SJP5nY2lhe5XChApWUVFDp4/kyM3lcJCJmFRpciweB+qBlzd
z/nQbn9aArZ1IXqxmNJEr9hWYtcCzSAhRl6Id1awBN4hbqpbr4sIqQycoM9e62wS
Y1Qx6EqmcHUGENOIoCu9LYOSH3PfIWUzuA9fEj0mKtT3/Ammep3FcEKa8rO6IYGP
j20mBN0mroM4FMhBXpff+avuucoDM3CZH18qYEGXSJzcYlpWHSiuuw9/NCzbioyY
Tctd1RXUEpMqW/xCKDgA96xD8xm1ZBLVtm7UztlqbswRpWtxG85ex6zcHZvuN4B/
s+7tVFw0Z5ZFFSRCg0O3viJld7JM/XeCRQUpwAMkNfrZeUNDcX9x3rWb5aNFRR/o
uSw3speXAaOvwj11gSKiW5KA7BqS+9KGcCGNmRpYa89V5RrS/TLIlwEAYr4HATg3
sZiIkgbqlGG2geHtsPOYTWa/N5UwWpwDggkfBMUoK6uQqBoVumuYfcLZMgvanIkj
n1dtPT7D33nMqhiiAUXR6K9My6MPur6/wSD1LosxqMgyZF9T4eNB4paf2ynBz2Y0
8MAMwHDDlinjJSl4dhQG7FeqWiA/tnoVvxiRvjbwha5yUpGAjt7w5ALNqiUVZjk1
0LFT+YcawGHS5gjgmtl7JQ==
//pragma protect end_data_block
//pragma protect digest_block
rEVs48j/4I15IIDnI83aIucOFKc=
//pragma protect end_digest_block
//pragma protect end_protected

  // -----------------------------------------------------------------------------

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
xu7cTQUbuHVt7Ax5+t0OLDGxmSX1vWk2PAT2IW02SMCtipKp7OoVliuafJw7wrR5
pkRt/NiVkrhQErT70EuBFX78V0RwJLvgYesr3RJnQVYA+ELwDslPQcYdqMJtcUs9
u6Sxg6bfFUKjozkUEkHlr1tu1xwxn0NrrF1utayt+D4hH4w7iseklA==
//pragma protect end_key_block
//pragma protect digest_block
N04TpfworIC+NpQ2CsueEIRTEcQ=
//pragma protect end_digest_block
//pragma protect data_block
y54xXFMc3Bakc7TNWIkyvLQkSU7QrQCtdaVHnFa2RL3Gv1kGbuK26z5xBal1aYmR
VAVhVMx1d/ZDVkvKQSk2FtaCV3bUnFkyyz2y/THJt8u2+CROxHtWheiLM92xh1hi
uyr0qxtZ+pdOhtbmoHQARr6C/nsw6C57Qrc8F+BCYQeIRmHpoYeEsUgWqAcAWM+d
noP3KHvZSaxV4FQxBzMKeQLVT99v8zbeyO9hLzbEp2NDUu5PDQr6Vm+sAOoPBwLM
VPo9mQ4Qj1/Et7+UrfotgrH7e42CagEP1TKGSvZmphvc1/TOTYXYguLBCWFxxaig
vHrxTPy8m3LEXMHcaWcoPUBh4ujYp8rGmJVFQtddxJ8S9texGVX964Xx+djkiWIy
N94BohT3zZLF1NE7hjWTn54zWGzMHKP2uduIXlI4ntIWpQh47pSxvyDkowYgWB6x
SO18Pw+UU1GXz87kvVyEnV8UXgLy+13JXkU6FQTcTdRJcLWefvbNFMG7Ui7bQ/wn
q6PIZwV23BYl43jWnRCDRvcHzNSSUvJ0E3tUd2jhICivjkMPPrZPRG3Gq75kh7hS
Cja4EFfeC533HY7nr7XE01uCL2L0h2YYTmk55F1sLMrZxNTvMCIUhYoYtiyBE5s/
OlEEx0Oxr8xzqXEsQuPw2GwLLogW446PnRJ0qbpgCoR0krBaHeVIkzqrBIK+Iduf
UKTQD1wf+sSj6LDizeez2GcT56q72DC5SwJ7TevixFc4jL0gZ9e9cJwzPpqihEcw
EaQa3HyFMNvZWQWorUMptJCmpbseBLuCCTd8BknXbA9tumD7j5Ay4BsgrUSdLQIJ
h8asDYIUCQZ7j+8Crgf65fOT8IRbHjcnLW8SBsrFfpz6cuYQK2zxz9FMn2sZMtfb
QmnERwQDSXUh4APIQoBQuY2EUXykLDZXB8SDtyu9auA+ofM9BTV7ZWj0w6MOTkdj
YyOSLlO3M5WpO0lvxRapOm34LuL3pZnksIe25CE+H0rh4AanrXO9QOMS1jIKgFN7
QklvBOfukiB4/v1AXJ6siubOAJTDYA0lZ7zGFGZxPFdJau82wQ/G3MEvgpFlbV5D
tHXu8bHfHGNh0cFa0FALCgsb3iFJ4nOQET+TwxjfY2XOFBIoE6xYLPIQ+Gj2r29A
grTgpEhOS36URyjPWAK2HyPU6mDIAiLMKJHrQPgNjqJfPIXSC/MAfGGvNBmawMAl
gWKdIGrspHZ8kN1a3r7ekO7SBkcpF1lLeC4kDuXwMySY0DUiwoxObIUxZa4HNwG9
PEf2Vmoc28TwFNFFar3f7eBnF7iNFoTyFzexPsQpoI6UtxeAosKSTkGcQM4OEQAE
7oOLFVMNpn67y0eK8rNV85v0ACABeyJTqQTp/0SHCp0zGldF5Zgh34e+mgB6PjDn
+0TqGkPa1tVcitaAhcfR8JCf+mxDwPJcEx1I4KaAuMxdKFMksaGTJklLYQIp0j6t
XN3enJ5no5xXuAM4f0l8ZS30Fk3osp3eo6cXT3dpcpYjdv/X9H7d3ANHHs8UPWJ1
HP2fjkeF81riQwBWPRZWOpq5/AlR5JgrmymFy5sqElKYMtLK+0SfSMlIt48hfB00
2g47e/AVBOYuMm1YecI8ym1WUVzU01obNVwhoTM48NGR5eTEXKK/+b4zPZiCau95
QAWCbhvz79HWfj4/txHI6MSvRIWO4pgKEdrAXH6LghlToGV+3jZsQkFbvFJr3w+7

//pragma protect end_data_block
//pragma protect digest_block
SA0jJV8Kqr9LcihGZFYcYTGOAe0=
//pragma protect end_digest_block
//pragma protect end_protected


  // -----------------------------------------------------------------------------

endclass : svt_ahb_slave_monitor_system_checker_callback

// =============================================================================
`endif // GUARD_SVT_AHB_SLAVE_MONITOR_SYSTEM_CHECKER_CALLBACK_SV
