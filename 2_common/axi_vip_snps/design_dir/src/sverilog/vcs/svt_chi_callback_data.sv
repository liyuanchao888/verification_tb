//=======================================================================
// COPYRIGHT (C) 2010-2018 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_CALLBACK_DATA_SV
`define GUARD_SVT_CHI_CALLBACK_DATA_SV

/**
 * Base class for callback data object. 
 * The data object of this class will be used as argument to newly aaded callbacks in CHI VIP.
 */
class svt_chi_callback_data extends `SVT_DATA_TYPE;

  `ifdef SVT_VMM_TECHNOLOGY
    `vmm_typename(svt_chi_callback_data)
    local static vmm_log shared_log = new("svt_chi_callback_data", "class" );
  `endif

//----------------------------------------------------------------------------
`ifndef SVT_VMM_TECHNOLOGY
  /**
   * CONSTUCTOR: Create a new callback data instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the callback data 
   */
  extern function new(string name = "svt_chi_callback_data");
`else
  `svt_vmm_data_new(svt_chi_callback_data)
  /**
   * CONSTUCTOR: Create a new callback data instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param log Instance name of the vmm_log 
   */
  extern function new (vmm_log log = null);
`endif // !`ifndef SVT_VMM_TECHNOLOGY

endclass
`protected
J9c?8?J,-U8[/fD6HICW)VWH.@_\BXDP/7=8efCf@D]f1V-+_3C5&)Z9>O:TS>(B
=K8YW^0D?aUAVI6(d[BT>D]Y=/:K3cJ5[8M2FM//b-0I#Rdd#bSG/=@07<e]<B(T
ZN[VTFR\Rg0)5NfLe2[?>Ybb<[2aHf<BSgAP)2<GXC-,1AXA4__N-7JZ=75VaU@_
FUa949[FGXNUfLZ35g:F&UN&8U_/P:-/(,+\0P(?8:INO.CGfUAMYf@H3_EE>AD>
c#d)c@+S[.a-ONQ7BeYaW?9^?.#&+UZ.7<_e#35QT\;@@Q>@:5KH-XGO_C[gfY>N
/^-@N5L0B8R[1(gM].NV>[eS8_4(R4Xe-)\.]&HI#FR]BH#>adcM;V:\>SBEGcYL
D5#9AAS1FcGW9-E8KfNX_4PC3d#f[SSYb^1>bN:.cF>g]>Y-IC_1KH:\I$
`endprotected


`endif // GUARD_SVT_CHI_CALLBACK_DATA_SV 
