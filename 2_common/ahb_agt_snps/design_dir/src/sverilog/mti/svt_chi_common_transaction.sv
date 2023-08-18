//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013-2020 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_CHI_COMMON_TRANSACTION_SV
`define GUARD_SVT_CHI_COMMON_TRANSACTION_SV

`include "svt_chi_defines.svi"

typedef class svt_chi_flit;
// =============================================================================
 /**
  * AMBA CHI Common Transaction for Protocol Layer transactions, Link Layer FLITs.
 */
class svt_chi_common_transaction extends `SVT_TRANSACTION_TYPE;

  /**
   @grouphdr chi_common_xact_dmt
   This group contains attributes which are used for Direct memory transfer feature.
   */

  /**
   @grouphdr chi_common_xact_cache_stashing
   This group contains attributes which are used for cache stashing feature.
   */

  /**
   @grouphdr chi_common_xact_ret_to_src
   This group contains attributes which are used for Return to Source feature.
   */

  /**
   @grouphdr chi_common_xact_do_not_go_to_sd
   This group contains attributes which are used for DoNotGoToSD feature.
   */

  /** @cond PRIVATE */
  /**
   @grouphdr chi_common_xact_dct
   This group contains attributes which are used for Direct cache transfer feature.
   */
  /** @endcond */

  /**
   @grouphdr chi_common_xact_dvm_extension
   This group contains attributes which are used for DVM Extensions feature.
   */

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  /**
   * This enum declaration is used to indicate the CHI Transaction type.<br>
   * Note that these are initiated by request message of the same name.<br>
   * This is also used for Opcode field of Request VC Flit.
   */
  typedef enum bit [(`SVT_CHI_REQ_VC_FLIT_OP_WIDTH-1):0] {
    READNOSNP           = `SVT_CHI_XACT_TYPE_READNOSNP,          /**<: Read-type transaction ReadNoSnp  */
    READONCE            = `SVT_CHI_XACT_TYPE_READONCE,           /**<: Read-type transaction ReadOnce  */
    READCLEAN           = `SVT_CHI_XACT_TYPE_READCLEAN,          /**<: Read-type transaction ReadClean  */
    READSHARED          = `SVT_CHI_XACT_TYPE_READSHARED,         /**<: Read-type transaction ReadShared */
    READUNIQUE          = `SVT_CHI_XACT_TYPE_READUNIQUE,         /**<: Read-type transaction ReadUnique  */
    CLEANUNIQUE         = `SVT_CHI_XACT_TYPE_CLEANUNIQUE,        /**<: Read-type transaction CleanUnique  */
    MAKEUNIQUE          = `SVT_CHI_XACT_TYPE_MAKEUNIQUE,         /**<: Read-type transaction MakeUnique  */
    WRITEBACKFULL       = `SVT_CHI_XACT_TYPE_WRITEBACKFULL,      /**<: CopyBack transaction WriteBackFull  */
    WRITEBACKPTL        = `SVT_CHI_XACT_TYPE_WRITEBACKPTL,       /**<: CopyBack transaction WriteBackPtl  */
    WRITEEVICTFULL      = `SVT_CHI_XACT_TYPE_WRITEEVICTFULL,     /**<: CopyBack transaction WriteEvictFull  */
    WRITECLEANFULL      = `SVT_CHI_XACT_TYPE_WRITECLEANFULL,     /**<: CopyBack transaction WriteCleanFull  */
    WRITECLEANPTL       = `SVT_CHI_XACT_TYPE_WRITECLEANPTL,      /**<: CopyBack transaction WriteCleanPtl  */
    EVICT               = `SVT_CHI_XACT_TYPE_EVICT,              /**<: CopyBack transaction Evict  */
    WRITENOSNPFULL      = `SVT_CHI_XACT_TYPE_WRITENOSNPFULL,     /**<: Write-type transaction WriteNoSnpFull  */
    WRITENOSNPPTL       = `SVT_CHI_XACT_TYPE_WRITENOSNPPTL,      /**<: Write-type transaction WriteNoSnpPtl  */
    WRITEUNIQUEFULL     = `SVT_CHI_XACT_TYPE_WRITEUNIQUEFULL,    /**<: Write-type transaction WriteUniqueFull  */
    WRITEUNIQUEPTL      = `SVT_CHI_XACT_TYPE_WRITEUNIQUEPTL,     /**<: Write-type transaction WriteUniquePtl  */
    CLEANSHARED         = `SVT_CHI_XACT_TYPE_CLEANSHARED,        /**<: Cache maintenance transaction CleanShared  */
    CLEANINVALID        = `SVT_CHI_XACT_TYPE_CLEANINVALID,       /**<: Cache maintenance transaction CleanInvalid  */
    MAKEINVALID         = `SVT_CHI_XACT_TYPE_MAKEINVALID,        /**<: Cache maintenance transaction MakeInvalid  */
    EOBARRIER           = `SVT_CHI_XACT_TYPE_EOBARRIER,          /**<: Barrier transaction EOBarrier  */
    ECBARRIER           = `SVT_CHI_XACT_TYPE_ECBARRIER,          /**<: Barrier transaction ECBarrier  */
    DVMOP               = `SVT_CHI_XACT_TYPE_DVMOP,              /**<: DVM transaction DVMOp  */
    PCRDRETURN          = `SVT_CHI_XACT_TYPE_PCRDRETURN,         /**<: Protocol credit return PCrdReturn  */
    REQLINKFLIT         = `SVT_CHI_XACT_TYPE_REQLINKFLIT         /**<: Link Flit for Request VC. Used by svt_chi_flit transaction. */
  `ifdef SVT_CHI_ISSUE_B_ENABLE
    , READSPEC               = `SVT_CHI_XACT_TYPE_READSPEC,            /**<:Read-type transaction ReadSpec */
      WRITEUNIQUEFULLSTASH   = `SVT_CHI_XACT_TYPE_WRITEUNIQUEFULLSTASH,/**<:Stash transaction WriteUniqueFullStash */
      WRITEUNIQUEPTLSTASH    = `SVT_CHI_XACT_TYPE_WRITEUNIQUEPTLSTASH, /**<:Stash transaction WriteUniquePtlStash */
      STASHONCEUNIQUE        = `SVT_CHI_XACT_TYPE_STASHONCEUNIQUE,     /**<:Stash transaction StashOnceUnique */
      STASHONCESHARED        = `SVT_CHI_XACT_TYPE_STASHONCESHARED,     /**<:Stash transaction StashOnceShared */
      READONCECLEANINVALID   = `SVT_CHI_XACT_TYPE_READONCECLEANINVALID,/**<:Deallocating transaction ReadOnceCleanInvalid */
      READONCEMAKEINVALID    = `SVT_CHI_XACT_TYPE_READONCEMAKEINVALID, /**<:Deallocating transaction ReadOnceMakeInvalid */
      READNOTSHAREDDIRTY     = `SVT_CHI_XACT_TYPE_READNOTSHAREDDIRTY,  /**<:Read-type transaction ReadNotSharedDirty */
      CLEANSHAREDPERSIST     = `SVT_CHI_XACT_TYPE_CLEANSHAREDPERSIST,  /**<CleanSharedPersist transaction */
      ATOMICSTORE_ADD        = `SVT_CHI_XACT_TYPE_ATOMICSTORE_ADD,     /**<Atomic transactions AtomicStore Add */
      ATOMICSTORE_CLR        = `SVT_CHI_XACT_TYPE_ATOMICSTORE_CLR,     /**<Atomic transactions AtomicStore Clr */
      ATOMICSTORE_EOR        = `SVT_CHI_XACT_TYPE_ATOMICSTORE_EOR,     /**<Atomic transactions AtomicStore Eor */
      ATOMICSTORE_SET        = `SVT_CHI_XACT_TYPE_ATOMICSTORE_SET,     /**<Atomic transactions AtomicStore Set */
      ATOMICSTORE_SMAX       = `SVT_CHI_XACT_TYPE_ATOMICSTORE_SMAX,    /**<Atomic transactions AtomicStore Smax */
      ATOMICSTORE_SMIN       = `SVT_CHI_XACT_TYPE_ATOMICSTORE_SMIN,    /**<Atomic transactions AtomicStore Smin */
      ATOMICSTORE_UMAX       = `SVT_CHI_XACT_TYPE_ATOMICSTORE_UMAX,    /**<Atomic transactions AtomicStore Umax */
      ATOMICSTORE_UMIN       = `SVT_CHI_XACT_TYPE_ATOMICSTORE_UMIN,    /**<Atomic transactions AtomicStore Umin */
      ATOMICLOAD_ADD         = `SVT_CHI_XACT_TYPE_ATOMICLOAD_ADD,      /**<Atomic transactions AtomicLoad Add */
      ATOMICLOAD_CLR         = `SVT_CHI_XACT_TYPE_ATOMICLOAD_CLR,      /**<Atomic transactions AtomicLoad Clr */
      ATOMICLOAD_EOR         = `SVT_CHI_XACT_TYPE_ATOMICLOAD_EOR,      /**<Atomic transactions AtomicLoad Eor */
      ATOMICLOAD_SET         = `SVT_CHI_XACT_TYPE_ATOMICLOAD_SET,      /**<Atomic transactions AtomicLoad Set */
      ATOMICLOAD_SMAX        = `SVT_CHI_XACT_TYPE_ATOMICLOAD_SMAX,     /**<Atomic transactions AtomicLoad Smax */
      ATOMICLOAD_SMIN        = `SVT_CHI_XACT_TYPE_ATOMICLOAD_SMIN,     /**<Atomic transactions AtomicLoad Smin */
      ATOMICLOAD_UMAX        = `SVT_CHI_XACT_TYPE_ATOMICLOAD_UMAX,     /**<Atomic transactions AtomicLoad Umax */
      ATOMICLOAD_UMIN        = `SVT_CHI_XACT_TYPE_ATOMICLOAD_UMIN,     /**<Atomic transactions AtomicLoad Umin */
      ATOMICSWAP             = `SVT_CHI_XACT_TYPE_ATOMICSWAP,          /**<Atomic transactions AtomicSwap */
      ATOMICCOMPARE          = `SVT_CHI_XACT_TYPE_ATOMICCOMPARE,       /**<Atomic transactions AtomicCompare */
      PREFETCHTGT            = `SVT_CHI_XACT_TYPE_PREFETCHTGT          /**<PrefetchTgt transaction */
  `endif //  `ifdef SVT_CHI_ISSUE_B_ENABLE
  `ifdef SVT_CHI_ISSUE_C_ENABLE
    , READNOSNPSEP           = `SVT_CHI_XACT_TYPE_READNOSNPSEP /**<ReadNoSnpSep Transaction */
  `endif
  `ifdef SVT_CHI_ISSUE_D_ENABLE
    , CLEANSHAREDPERSISTSEP  = `SVT_CHI_XACT_TYPE_CLEANSHAREDPERSISTSEP /**<CleanSharedPersistSep Transaction */
  `endif
  `ifdef SVT_CHI_ISSUE_E_ENABLE
    , MAKEREADUNIQUE             = `SVT_CHI_XACT_TYPE_MAKEREADUNIQUE
    , WRITEEVICTOREVICT          = `SVT_CHI_XACT_TYPE_WRITEEVICTOREVICT
    , WRITEUNIQUEZERO            = `SVT_CHI_XACT_TYPE_WRITEUNIQUEZERO
    , WRITENOSNPZERO             = `SVT_CHI_XACT_TYPE_WRITENOSNPZERO
    , STASHONCESEPSHARED         = `SVT_CHI_XACT_TYPE_STASHONCESEPSHARED
    , STASHONCESEPUNIQUE         = `SVT_CHI_XACT_TYPE_STASHONCESEPUNIQUE
    , READPREFERUNIQUE           = `SVT_CHI_XACT_TYPE_READPREFERUNIQUE
    , WRITENOSNPFULL_CLEANSHARED  = `SVT_CHI_XACT_TYPE_WRITENOSNPFULL_CLEANSHARED
    , WRITENOSNPFULL_CLEANINVALID = `SVT_CHI_XACT_TYPE_WRITENOSNPFULL_CLEANINVALID
    , WRITENOSNPFULL_CLEANSHAREDPERSISTSEP      = `SVT_CHI_XACT_TYPE_WRITENOSNPFULL_CLEANSHAREDPERSISTSEP
    , WRITEUNIQUEFULL_CLEANSHARED = `SVT_CHI_XACT_TYPE_WRITEUNIQUEFULL_CLEANSHARED
    , WRITEUNIQUEFULL_CLEANSHAREDPERSISTSEP     = `SVT_CHI_XACT_TYPE_WRITEUNIQUEFULL_CLEANSHAREDPERSISTSEP
    , WRITEBACKFULL_CLEANSHARED   = `SVT_CHI_XACT_TYPE_WRITEBACKFULL_CLEANSHARED
    , WRITEBACKFULL_CLEANINVALID  = `SVT_CHI_XACT_TYPE_WRITEBACKFULL_CLEANINVALID
    , WRITEBACKFULL_CLEANSHAREDPERSISTSEP       = `SVT_CHI_XACT_TYPE_WRITEBACKFULL_CLEANSHAREDPERSISTSEP
    , WRITECLEANFULL_CLEANSHARED  = `SVT_CHI_XACT_TYPE_WRITECLEANFULL_CLEANSHARED
    , WRITECLEANFULL_CLEANSHAREDPERSISTSEP      = `SVT_CHI_XACT_TYPE_WRITECLEANFULL_CLEANSHAREDPERSISTSEP
    , WRITENOSNPPTL_CLEANSHARED   = `SVT_CHI_XACT_TYPE_WRITENOSNPPTL_CLEANSHARED
    , WRITENOSNPPTL_CLEANINVALID  = `SVT_CHI_XACT_TYPE_WRITENOSNPPTL_CLEANINVALID
    , WRITENOSNPPTL_CLEANSHAREDPERSISTSEP       = `SVT_CHI_XACT_TYPE_WRITENOSNPPTL_CLEANSHAREDPERSISTSEP
    , WRITEUNIQUEPTL_CLEANSHARED  = `SVT_CHI_XACT_TYPE_WRITEUNIQUEPTL_CLEANSHARED
    , WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP      = `SVT_CHI_XACT_TYPE_WRITEUNIQUEPTL_CLEANSHAREDPERSISTSEP
  `endif
  } xact_type_enum;

  /**
   * This enum declaration is used to indicate the CHI Snoop Message Request type.<br>
   * This is also used for Opcode field of Snoop VC Flit.
   */
  typedef enum bit [(`SVT_CHI_SNP_VC_FLIT_OP_WIDTH-1):0] {
    SNPSHARED           = `SVT_CHI_SNP_REQ_MSG_TYPE_SNPSHARED,           /**<: Snoop request type SnpShared */
    SNPCLEAN            = `SVT_CHI_SNP_REQ_MSG_TYPE_SNPCLEAN,            /**<: Snoop request type SnpClean */
    SNPONCE             = `SVT_CHI_SNP_REQ_MSG_TYPE_SNPONCE,             /**<: Snoop request type SnpOnce */
    SNPUNIQUE           = `SVT_CHI_SNP_REQ_MSG_TYPE_SNPUNIQUE,           /**<: Snoop request type SnpUnique */
    SNPCLEANSHARED      = `SVT_CHI_SNP_REQ_MSG_TYPE_SNPCLEANSHARED,      /**<: Snoop request type SnpCleanShared */
    SNPCLEANINVALID     = `SVT_CHI_SNP_REQ_MSG_TYPE_SNPCLEANINVALID,     /**<: Snoop request type SnpCleanInvalid */
    SNPMAKEINVALID      = `SVT_CHI_SNP_REQ_MSG_TYPE_SNPMAKEINVALID,      /**<: Snoop request type SnpMakeInvalid */
    SNPDVMOP            = `SVT_CHI_SNP_REQ_MSG_TYPE_SNPDVMOP,            /**<: Snoop request type SnpDVMOp */
    SNPLINKFLIT         = `SVT_CHI_SNP_REQ_MSG_TYPE_SNPLINKFLIT          /**<: Link Flit for Snoop VC. Used by svt_chi_flit transaction. */
   `ifdef SVT_CHI_ISSUE_B_ENABLE
    ,SNPNOTSHAREDDIRTY   = `SVT_CHI_SNP_REQ_MSG_TYPE_SNPNOTSHAREDDIRTY,    /**<: Snoop request type SnpNotSharedDirty  */
     SNPUNIQUESTASH      = `SVT_CHI_SNP_REQ_MSG_TYPE_SNPUNIQUESTASH,       /**<: Snoop request type SnpUniqueStash */
     SNPMAKEINVALIDSTASH = `SVT_CHI_SNP_REQ_MSG_TYPE_SNPMAKEINVALIDSTASH,  /**<: Snoop request type SnpMakeInvalidStash */
     SNPSTASHUNIQUE      = `SVT_CHI_SNP_REQ_MSG_TYPE_SNPSTASHUNIQUE,       /**<: Snoop request type SnpStashUnique */
     SNPSTASHSHARED      = `SVT_CHI_SNP_REQ_MSG_TYPE_SNPSTASHSHARED,       /**<: Snoop request type SnpStashShared */
     SNPSHAREDFWD        = `SVT_CHI_SNP_REQ_MSG_TYPE_SNPSHAREDFWD,         /**<: Snoop request type SnpSharedFwd */
     SNPCLEANFWD         = `SVT_CHI_SNP_REQ_MSG_TYPE_SNPCLEANFWD,          /**<: Snoop request type SnpCleanFwd */
     SNPONCEFWD          = `SVT_CHI_SNP_REQ_MSG_TYPE_SNPONCEFWD,           /**<: Snoop request type SnpOnceFwd */
     SNPNOTSHAREDDIRTYFWD= `SVT_CHI_SNP_REQ_MSG_TYPE_SNPNOTSHAREDDIRTYFWD, /**<: Snoop request type SnpNotSharedDirtyFwd */
     SNPUNIQUEFWD        = `SVT_CHI_SNP_REQ_MSG_TYPE_SNPUNIQUEFWD          /**<: Snoop request type SnpUniqueFwd */
   `endif
   `ifdef SVT_CHI_ISSUE_E_ENABLE
     ,SNPQUERY           = `SVT_CHI_SNP_REQ_MSG_TYPE_SNPQUERY
     ,SNPPREFERUNIQUE    = `SVT_CHI_SNP_REQ_MSG_TYPE_SNPPREFERUNIQUE
     ,SNPPREFERUNIQUEFWD = `SVT_CHI_SNP_REQ_MSG_TYPE_SNPPREFERUNIQUEFWD
   `endif
  } snp_req_msg_type_enum;

  /** This enum declaration is used to indicate the CHI Response Flit Opcode type. */
  typedef enum bit [(`SVT_CHI_RSP_VC_FLIT_OP_WIDTH-1):0] {
    SNPRESP             = `SVT_CHI_RSP_VC_FLIT_OP_SNPRESP,       /**<: Snoop response message type SnpResp */
    COMP                = `SVT_CHI_RSP_VC_FLIT_OP_COMP,          /**<: Completion response message Comp */
    COMPDBIDRESP        = `SVT_CHI_RSP_VC_FLIT_OP_COMPDBIDRESP,  /**<: Completion response message CompDBIDResp */
    COMPACK             = `SVT_CHI_RSP_VC_FLIT_OP_COMPACK,       /**<: Misc. response message type CompAck  */
    RETRYACK            = `SVT_CHI_RSP_VC_FLIT_OP_RETRYACK,      /**<: Misc. response message type RetryAck */
    DBIDRESP            = `SVT_CHI_RSP_VC_FLIT_OP_DBIDRESP,      /**<: Misc. response message type DBIDResp */
    PCRDGRANT           = `SVT_CHI_RSP_VC_FLIT_OP_PCRDGRANT,     /**<: Misc. response message type PcrdGrant */
    READRECEIPT         = `SVT_CHI_RSP_VC_FLIT_OP_READRECEIPT,   /**<: Misc. response message type CompAck */
    RSPLINKFLIT         = `SVT_CHI_RSP_VC_FLIT_OP_RSPLINKFLIT    /**<: Opcode for Resp Link Flit */
    `ifdef SVT_CHI_ISSUE_B_ENABLE
    , SNPRESPFWDED      = `SVT_CHI_RSP_VC_FLIT_OP_SNPRESPFWDED   /**<: Snoop response message type SnpRespFwded */
    `endif
    `ifdef SVT_CHI_ISSUE_C_ENABLE
    , RESPSEPDATA       = `SVT_CHI_RSP_VC_FLIT_OP_RESPSEPDATA    /**<: Snoop response message type RespSepData */
    `endif
    `ifdef SVT_CHI_ISSUE_D_ENABLE
    , PERSIST           = `SVT_CHI_RSP_VC_FLIT_OP_PERSIST        /**<: Misc. response message type Persist */
    , COMPPERSIST       = `SVT_CHI_RSP_VC_FLIT_OP_COMPPERSIST    /**<: Misc. response message type CompPersist */
    `endif
    `ifdef SVT_CHI_ISSUE_E_ENABLE
    , TAGMATCH          = `SVT_CHI_RSP_VC_FLIT_OP_TAGMATCH
    , DBIDRESPORD       = `SVT_CHI_RSP_VC_FLIT_OP_DBIDRESPORD
    , STASHDONE         = `SVT_CHI_RSP_VC_FLIT_OP_STASHDONE
    , COMPSTASHDONE     = `SVT_CHI_RSP_VC_FLIT_OP_COMPSTASHDONE
    , COMPCMO           = `SVT_CHI_RSP_VC_FLIT_OP_COMPCMO
    `endif
  } rsp_msg_type_enum;

  /** This enum declaration is used to indicate the CHI Data VC Flit Opcode type. */
  typedef enum bit [(`SVT_CHI_DAT_VC_FLIT_OP_WIDTH-1):0] {
    SNPRESPDATA         = `SVT_CHI_DAT_VC_FLIT_OP_SNPRESPDATA,           /**<: Snoop response message type SnpRespData */
    SNPRESPDATAPTL      = `SVT_CHI_DAT_VC_FLIT_OP_SNPRESPDATAPTL,        /**<: Snoop response message type SnpRespDataPtl */
    COPYBACKWRDATA      = `SVT_CHI_DAT_VC_FLIT_OP_COPYBACKWRDATA,        /**<: Write-data response message type CopyBackWrData */
    NONCOPYBACKWRDATA   = `SVT_CHI_DAT_VC_FLIT_OP_NONCOPYBACKWRDATA,     /**<: Write-data response message type NonCopyBackWrData */
    COMPDATA            = `SVT_CHI_DAT_VC_FLIT_OP_COMPDATA,              /**<: Completion response message CompData */
    DATLINKFLIT         = `SVT_CHI_DAT_VC_FLIT_OP_DATLINKFLIT            /**<: Opcode for Data Link Flit */
    `ifdef SVT_CHI_ISSUE_B_ENABLE
    , SNPRESPDATAFWDED  = `SVT_CHI_DAT_VC_FLIT_OP_SNPRESPDATAFWDED,      /**<: Snoop response message type SnpRespDataFwded */
      WRITEDATACANCEL   = `SVT_CHI_DAT_VC_FLIT_OP_WRITEDATACANCEL        /**<: WriteDataCancel response */
    `endif
    `ifdef SVT_CHI_ISSUE_C_ENABLE
    , DATASEPRESP       = `SVT_CHI_DAT_VC_FLIT_OP_DATASEPRESP,           /**<: Data response message type DataSepResp */
      NCBWRDATACOMPACK  = `SVT_CHI_DAT_VC_FLIT_OP_NCBWRDATACOMPACK       /**<: Data response message type NCBWrDataCompAck */
    `endif
  } dat_msg_type_enum;

  /** This enum declaration is used to indicate the type of the Flit. */
  typedef enum  {
    REQ = `SVT_CHI_REQ_FLIT, /**<: Request VC Flit type */
    RSP = `SVT_CHI_RSP_FLIT, /**<: Response VC Flit type */
    SNP = `SVT_CHI_SNP_FLIT, /**<: Snoop VC Flit type */
    DAT = `SVT_CHI_DAT_FLIT  /**<: Data VC Flit type */
  } flit_type_enum;

  /** This enum declaration is used for data size. */
  typedef enum bit [(`SVT_CHI_SIZE_WIDTH-1):0] {
    SIZE_1BYTE       = `SVT_CHI_DATA_SIZE_1BYTE,      /**<: Data size of 1 Byte */
    SIZE_2BYTE       = `SVT_CHI_DATA_SIZE_2BYTE,      /**<: Data size of 2 Byte */
    SIZE_4BYTE       = `SVT_CHI_DATA_SIZE_4BYTE,      /**<: Data size of 4 Byte */
    SIZE_8BYTE       = `SVT_CHI_DATA_SIZE_8BYTE,      /**<: Data size of 8 Byte */
    SIZE_16BYTE      = `SVT_CHI_DATA_SIZE_16BYTE,     /**<: Data size of 16 Byte */
    SIZE_32BYTE      = `SVT_CHI_DATA_SIZE_32BYTE,     /**<: Data size of 32 Byte */
    SIZE_64BYTE      = `SVT_CHI_DATA_SIZE_64BYTE      /**<: Data size of 64 Byte */
  } data_size_enum;

  /** This enum declaration is used for ordering type field definition. */
  typedef enum bit [(`SVT_CHI_ORDER_WIDTH-1):0] {
    NO_ORDERING_REQUIRED        = `SVT_CHI_NO_ORDERING_REQUIRED,         /**<: No ordering required */
    `ifdef SVT_CHI_ISSUE_B_ENABLE
    REQ_ACCEPTED                = `SVT_CHI_REQUEST_ACCEPTED,             /**<: Request Accepted */
    `endif
    REQ_ORDERING_REQUIRED       = `SVT_CHI_REQ_ORDERING_REQUIRED,        /**<: Request ordering required */
    REQ_EP_ORDERING_REQUIRED    = `SVT_CHI_REQ_EP_ORDERING_REQUIRED      /**<: Both request and endpoint ordering required */
  } order_type_enum;

  /** This enum declaration is used for Protocol credit types. */
  typedef enum bit [(`SVT_CHI_P_CRD_TYPE_WIDTH-1):0] {
    TYPE0       = `SVT_CHI_P_CRD_TYPE0,  /**<: Protocol Credit type 0 */
    TYPE1       = `SVT_CHI_P_CRD_TYPE1,  /**<: Protocol Credit type 1 */
    TYPE2       = `SVT_CHI_P_CRD_TYPE2,  /**<: Protocol Credit type 2 */
    TYPE3       = `SVT_CHI_P_CRD_TYPE3   /**<: Protocol Credit type 3 */
   `ifdef SVT_CHI_ISSUE_B_ENABLE
    , TYPE4     = `SVT_CHI_P_CRD_TYPE4,  /**<: Protocol Credit type 4 */
    TYPE5       = `SVT_CHI_P_CRD_TYPE5,  /**<: Protocol Credit type 5 */
    TYPE6       = `SVT_CHI_P_CRD_TYPE6,  /**<: Protocol Credit type 6 */
    TYPE7       = `SVT_CHI_P_CRD_TYPE7,  /**<: Protocol Credit type 7 */
    TYPE8       = `SVT_CHI_P_CRD_TYPE8,  /**<: Protocol Credit type 8 */
    TYPE9       = `SVT_CHI_P_CRD_TYPE9,  /**<: Protocol Credit type 9 */
    TYPE10      = `SVT_CHI_P_CRD_TYPE10,  /**<: Protocol Credit type 10 */
    TYPE11      = `SVT_CHI_P_CRD_TYPE11,  /**<: Protocol Credit type 11 */
    TYPE12      = `SVT_CHI_P_CRD_TYPE12,  /**<: Protocol Credit type 12 */
    TYPE13      = `SVT_CHI_P_CRD_TYPE13,  /**<: Protocol Credit type 13 */
    TYPE14      = `SVT_CHI_P_CRD_TYPE14,  /**<: Protocol Credit type 14 */
    TYPE15      = `SVT_CHI_P_CRD_TYPE15   /**<: Protocol Credit type 15 */
  `endif
  } p_crd_type_enum;

  /** This enum declaration is used for attribute Memory Type. */
  typedef enum bit {
    DEVICE      = `SVT_CHI_MEM_TYPE_DEVICE,      /**<: Device memory type */
    NORMAL      = `SVT_CHI_MEM_TYPE_NORMAL       /**<: NOrmal memory type */
  } mem_attr_mem_type_enum;

  /** This enum declaration is used for attribute Snoop domain type. */
  typedef enum bit {
    INNER       = `SVT_CHI_SNP_DOMAIN_INNER,     /**<: Inner snoop domain */
    OUTER       = `SVT_CHI_SNP_DOMAIN_OUTER      /**<: Outer snoop domain */
  } snp_attr_snp_domain_type_enum;

  /** This enum declaration is used for attribute Response error status. */
  typedef enum bit [(`SVT_CHI_RESP_ERR_STATUS_WIDTH-1):0] {
    NORMAL_OKAY         = `SVT_CHI_RESP_ERR_STATUS_NORMAL_OKAY,          /**<: Normal Okay indicates if a normal access has been successful. Can also indicate an exclusive access failure. */
    EXCLUSIVE_OKAY      = `SVT_CHI_RESP_ERR_STATUS_EXCLUSIVE_OKAY,       /**<: Exclusive Okay indicates that either the read or write portion of an exclusive access has been successful. */
    DATA_ERROR          = `SVT_CHI_RESP_ERR_STATUS_DATA_ERROR,           /**<: Data Error */
    NON_DATA_ERROR      = `SVT_CHI_RESP_ERR_STATUS_NON_DATA_ERROR        /**<: Non-Data Error */
  } resp_err_status_enum;

  /** This enum declaration is used for cache state type. */
  typedef enum  {
    I   = `SVT_CHI_CACHE_STATE_I,        /**<: Invalid state */
    SC  = `SVT_CHI_CACHE_STATE_SC,       /**<: SharedClean state */
    SD  = `SVT_CHI_CACHE_STATE_SD,       /**<: SharedDirty state */
    UC  = `SVT_CHI_CACHE_STATE_UC,       /**<: UniqueClean state */
    UD  = `SVT_CHI_CACHE_STATE_UD,       /**<: UniqueDirty state */
    UCE = `SVT_CHI_CACHE_STATE_UCE,      /**<: UniqueClean empty state */
    UDP = `SVT_CHI_CACHE_STATE_UDP       /**<: UniqueDirty partial state */
  } cache_state_enum;

  `ifdef SVT_CHI_ISSUE_E_ENABLE
  /** This enum declaration is used for Tag state type. */
  typedef enum  {
    TAG_STATE_INVALID,
    TAG_STATE_CLEAN,
    TAG_STATE_DIRTY
  } tag_state_enum;
  `endif

  /** This enum declaration is used for CCID representation. */
  typedef enum bit [(`SVT_CHI_CCID_WIDTH-1):0] {
    CCID_DATA_127_DOWN_TO_0       = `SVT_CHI_CCID_DATA_127_DOWN_TO_0,      /**<: 128 bit chunk of data[127:0] is critical. */
    CCID_DATA_255_DOWN_TO_128     = `SVT_CHI_CCID_DATA_255_DOWN_TO_128,    /**<: 128 bit chunk of data[255:128] is critical. */
    CCID_DATA_383_DOWN_TO_256     = `SVT_CHI_CCID_DATA_383_DOWN_TO_256,    /**<: 128 bit chunk of data[383:256] is critical. */
    CCID_DATA_511_DOWN_TO_384     = `SVT_CHI_CCID_DATA_511_DOWN_TO_384     /**<: 128 bit chunk of data[511:384] is critical. */
  } ccid_enum;

  /** This enum declaration is used for DVM Message Field Encoding representation. */
  typedef enum bit [(`SVT_CHI_DVM_MSG_TYPE_WIDTH-1):0] {
    DVM_MSG_TYPE_TLB_INVALIDATE     = `SVT_CHI_DVM_MSG_TYPE_WIDTH'b000,     /**<: DVM message type TLB Invalidate. */
    DVM_MSG_TYPE_BTB_INVALIDATE     = `SVT_CHI_DVM_MSG_TYPE_WIDTH'b001,             /**<: DVM message type BTB Invalidate. */
    DVM_MSG_TYPE_PHY_ICACHE_INVALIDATE          = `SVT_CHI_DVM_MSG_TYPE_WIDTH'b010,             /**<: DVM message type Phys Icache Invalidate. */
    DVM_MSG_TYPE_VIRT_ICACHE_INVALIDATE         = `SVT_CHI_DVM_MSG_TYPE_WIDTH'b011,             /**<: DVM message type Virtual Icache Invalidate. */
    DVM_MSG_TYPE_SYNC                           = `SVT_CHI_DVM_MSG_TYPE_WIDTH'b100              /**<: DVM message type Sync. */
  } dvm_message_type_enum;

  /**
   * This enum declaration is used to specify the DBID Value transmitted
   * for the following flits by the RN, SN agents in active mode. <br>
   * Following are details with possible DBID values described: <br>
   *  RSP Flits: Note that the following details are applicable only when
   *  svt_chi_system_configuration::chi_version is set to svt_chi_system_configuration::VERSION_3_0.
   *  - SnpResp, RetryAck, ReadReceipt: Zeros OR TxnID of originating Request. For SnpResp, originating request is the Snoop request.
   *  - CompAck: Zeros OR TxnID of the Response(DBID received for originating Request)
   *  .
   *  DAT Flits:
   *  - SnpRespData, SnpRespDataPtl, CopyBackWriteData, NonCopyBackWriteData: Zeros OR TxnID of originating Request. For SnpRespData*, originating request is the Snoop request.
   *  .
   */
  typedef enum {
    ZEROS,  /**<: DBID value for the above described flits will be transmitted as zeros. */
    TXN_ID  /**<: DBID value for the above described flits will be transmitted as either TxnID of originating request or TxnID of response whichever is applicable as per above details. */
  } dbid_policy_enum;

  /**
   *  Enum to represent TXREQFLITV delay reference event
   */
  typedef enum {
    TXREQFLITPEND_VALID    =  `SVT_CHI_TXREQFLITPEND_VALID_REF
  } reference_event_for_txreqflitv_delay_enum;

  /**
   *  Enum to represent TXDATFLITV delay reference event
   */
  typedef enum {
    TXDATFLITPEND_VALID     =  `SVT_CHI_TXDATFLITPEND_VALID_REF
  } reference_event_for_txdatflitv_delay_enum;

  /**
   *  Enum to represent TXSNPFLITV delay reference event
   */
  typedef enum {
    TXSNPFLITPEND_VALID     =  `SVT_CHI_TXSNPFLITPEND_VALID_REF
  } reference_event_for_txsnpflitv_delay_enum;

  /**
   *  Enum to represent TXRSPFLITV delay reference event
   */
  typedef enum {
    TXRSPFLITPEND_VALID     =  `SVT_CHI_TXRSPFLITPEND_VALID_REF
  } reference_event_for_txrspflitv_delay_enum;

  /**
   *  Enum to represent TXREQFLITPEND delay reference event
   */
  typedef enum {
    REQ_FLIT_AND_LCRD_AVAILABLE_AT_LINK_LAYER /**<: Flit and corresponding L-credit are available at link layer */
  } reference_event_for_txreqflitpend_delay_enum;

  /**
   *  Enum to represent first TXDATFLITPEND delay reference event
   */
  typedef enum {
    FIRST_DAT_FLIT_AND_LCRD_AVAILABLE_AT_LINK_LAYER  /**<: Flit and corresponding L-credit are available at link layer */
  } reference_event_for_first_txdatflitpend_delay_enum;

  /**
   *  Enum to represent next TXDATFLITPEND delay reference event
   */
  typedef enum {
    NEXT_DAT_FLIT_AND_LCRD_AVAILABLE_AT_LINK_LAYER  /**<: Flit and corresponding L-credit are available at link layer */
  } reference_event_for_next_txdatflitpend_delay_enum;

  /**
   *  Enum to represent TXRSPFLITPEND delay reference event
   */
  typedef enum {
    RSP_FLIT_AND_LCRD_AVAILABLE_AT_LINK_LAYER   /**<: Flit and corresponding L-credit are available at link layer */
  } reference_event_for_txrspflitpend_delay_enum;

  /** @cond PRIVATE */
  /**
   *  Enum to represent RXDATLCRDV delay reference event
   */
  typedef enum {
    RXDATLCRDV_REF_PREV_RXDATFLITV_VALID   =  `SVT_CHI_PREV_RXDATFLITV_VALID_REF
  } reference_event_for_rxdatlcrdv_delay_enum;

  /**
   *  Enum to represent RXSNPLCRDV delay reference event
   */
  typedef enum {
    RXSNPFLITV_VALID       =  `SVT_CHI_RXSNPFLITV_VALID_REF
  } reference_event_for_rxsnplcrdv_delay_enum;

  /**
   *  Enum to represent RXRSPLCRDV delay reference event
   */
  typedef enum {
    RXRSPFLITV_VALID       =  `SVT_CHI_RXRSPFLITV_VALID_REF
  } reference_event_for_rxrsplcrdv_delay_enum;

  /** @endcond */

  /**
   * Enum to represent the status of an exclusive access
   * Following are  the possible status types:
   * - EXCL_ACCESS_INITIAL   : Initial state of the transaction before it is processed by RN
   * - EXCL_ACCESS_PASS      : CHI exclusive access is successful
   * - EXCL_ACCESS_FAIL      : CHI exclusive access is failed
   * .
   *
   */
  typedef enum {
    EXCL_ACCESS_INITIAL  = `SVT_CHI_COHERENT_EXCL_ACCESS_INITIAL,
    EXCL_ACCESS_PASS     = `SVT_CHI_COHERENT_EXCL_ACCESS_PASS,
    EXCL_ACCESS_FAIL     = `SVT_CHI_COHERENT_EXCL_ACCESS_FAIL
  } excl_access_status_enum;

  /**
   * Enum to represent the status of RN exclusive monitor, which indicates the cause of failure of an exclusive store
   * Following are  the possible status types:
   * - EXCL_MON_INVALID      : RN exclusive monitor does not monitor the exclusive access on the cache line associated with the transaction
   * - EXCL_MON_SET          : RN exclusive monitor is set for exclusive access on the cache line associated with the transaction
   * - EXCL_MON_RESET        : RN exclusive monitor is reset for exclusive access on the cache line associated with the transaction
   * .
   *
   */
  typedef enum {
    EXCL_MON_INVALID  = `SVT_CHI_EXCL_MON_INVALID,
    EXCL_MON_SET      = `SVT_CHI_EXCL_MON_SET,
    EXCL_MON_RESET    = `SVT_CHI_EXCL_MON_RESET
  } excl_mon_status_enum;

  /**
    * Enum to represent the condition under which exclusive transaction is dropped. It also indicate why the exclusive monitor needs to be reset.
    * Following are the possible status types:
    * - EXCL_MON_FAILURE_COND_DEFAULT_VALUE_XACT_DROPPED   : Default value.
    * - EXCL_MON_RESET_ACCESS_FAIL_XACT_DROPPED            : set if the exclusive transaction is dropped as the excl_mon_status is reset and the exclusive_access_status is failed.
    * - EXCL_MON_SET_ACCESS_FAIL_XACT_DROPPED              : set if the exclusive transaction is dropped as the excl_mon_status is set and the exclusive_access_status is failed as unexpected INVALID cache line status encountered
    * - EXCL_MON_SET_ACCESS_PASS_XACT_DROPPED              : set if the exclusive transaction is dropped as when RN has a cacheline for which CU is generated, excl_mon is set for the same cacheline address and the cacheline state is unique, which means this is a RN speculative transaction to a cacheline present in it's own cache. In such scenario, do a silent write into the cache and drop the transaction. Need not issue this transaction.
    * - EXCL_MON_RESET_SNOOP_INVALIDATION_XACT_DROPPED                  : set to indicate that exclusive sequence needs to restart as the exclusively monitored RN cache has been invalidated by the incoming invalidating snoop request from different lpid or due to the normal coherent store[CU] transactions.
    * - EXCL_MON_RESET_STORE_WITHOUT_LOAD_XACT_DROPPED     : set if the exclusive transaction is dropped as the excl_mon_status is invalid and exclusive_access_status is failed. this occurs when store without load is issued by the RN.
    * - EXCL_MON_INVALID_MAX_EXCL_ACCESS_XACT_DROPPED     : set if the exclusive transaction is dropped when the maximum number of active exclusive acessses exceeds `SVT_CHI_MAX_NUM_EXCLUSIVE_ACCESS.
    * .
    *
    */
  typedef enum {
    EXCL_MON_FAILURE_COND_DEFAULT_VALUE_XACT_DROPPED             = `SVT_CHI_EXCL_MON_FAILURE_COND_DEFAULT_VALUE_XACT_DROPPED,
    EXCL_MON_RESET_ACCESS_FAIL_XACT_DROPPED                      = `SVT_CHI_EXCL_MON_RESET_ACCESS_FAIL_XACT_DROPPED,
    EXCL_MON_SET_ACCESS_FAIL_XACT_DROPPED                        = `SVT_CHI_EXCL_MON_SET_ACCESS_FAIL_XACT_DROPPED,
    EXCL_MON_SET_ACCESS_PASS_XACT_DROPPED                        = `SVT_CHI_EXCL_MON_SET_ACCESS_PASS_XACT_DROPPED,
    EXCL_MON_RESET_SNOOP_INVALIDATION_XACT_DROPPED               = `SVT_CHI_EXCL_MON_RESET_SNOOP_INVALIDATION_XACT_DROPPED,
    EXCL_MON_RESET_STORE_WITHOUT_LOAD_XACT_DROPPED               = `SVT_CHI_EXCL_MON_RESET_STORE_WITHOUT_LOAD_XACT_DROPPED,
    EXCL_MON_INVALID_MAX_EXCL_ACCESS_XACT_DROPPED                = `SVT_CHI_EXCL_MON_INVALID_MAX_EXCL_ACCESS_XACT_DROPPED

  } excl_xact_drop_cond_enum;

  /**
   * Enum to represent the ByteEnable pattern for Write transactions and Snoop responses
   * with Data.
   * Following are the possible values:
   * - BE_ZEROS : Indicates that the BE value in the DAT flit transmitted are zeros
   * - BE_ONES  : Indicates that the BE value in the DAT flit transmitted are zeros
   * - BE_PARTIAL_DATA : Indicates that the BE value in the DAT flit transmitted are
   *                     neither all zeros or all ones but can be any random value
   * .
   */
  typedef enum bit [(`SVT_CHI_MAX_DATA_WIDTH-1):0] {
    BE_ZEROS   = 0,/**<: BE value in the DAT flit transmitted are zeros. */
    BE_ONES    = 1, /**<: BE value in the DAT flit transmitted are  ones. */
    BE_PARTIAL_DATA = 2 /**<: BE value in the DAT flit transmitted are neither zeros or ones but can be any random value. */
  } byte_enable_pattern_enum;

  /**
   * Enum to represent the write data pattern for Write transactions.
   * Following are the possible values:
   * - DATA_ZERO : Indicates that the data value in the DAT flit transmitted is zero
   * - DATA_NON_ZERO  : Indicates that the data value in the DAT flit transmitted is non-zero
   * .
   */
  typedef enum bit [(`SVT_CHI_MAX_DATA_WIDTH-1):0] {
    DATA_ZERO   = 0,      /**<: data value in the DAT flit transmitted is zero. */
    DATA_NON_ZERO    = 1  /**<: data value in the DAT flit transmitted is non-zero. */
  } data_pattern_enum;

`ifdef SVT_CHI_ISSUE_B_ENABLE
  typedef enum bit[(`SVT_CHI_DATA_SOURCE_WIDTH-1):0] {
    DATA_SOURCE_UNSUPPORTED =  0,
    DATA_SOURCE_IMPLEMENTATION_DEFINED_0 =  1,
    DATA_SOURCE_IMPLEMENTATION_DEFINED_1 =  2,
    DATA_SOURCE_IMPLEMENTATION_DEFINED_2 =  3,
    DATA_SOURCE_IMPLEMENTATION_DEFINED_3 =  4,
    DATA_SOURCE_IMPLEMENTATION_DEFINED_4 =  5,
    PREFETCHTGT_WAS_USEFUL =  6,
    PREFETCHTGT_WAS_NOT_USEFUL =  7
    `ifdef SVT_CHI_ISSUE_D_ENABLE
    , DATA_SOURCE_IMPLEMENTATION_DEFINED_8 =  8,
      DATA_SOURCE_IMPLEMENTATION_DEFINED_9 =  9,
      DATA_SOURCE_IMPLEMENTATION_DEFINED_10 =  10,
      DATA_SOURCE_IMPLEMENTATION_DEFINED_11 =  11,
      DATA_SOURCE_IMPLEMENTATION_DEFINED_12 =  12,
      DATA_SOURCE_IMPLEMENTATION_DEFINED_13 =  13,
      DATA_SOURCE_IMPLEMENTATION_DEFINED_14 =  14,
      DATA_SOURCE_IMPLEMENTATION_DEFINED_15 =  15
    `endif
  } data_source_enum;

  /**
   * Enum to represent the Endianness of the outbound NonCopyBack Write data sent in Atomic transactions.
   * Following are the possible values:
   * - LITTLE_ENDIAN : Indicates that the outbound Atomic Write data is in the Little Endian format
   * - BIG_ENDIAN    : Indicates that the outbound Atomic Write data is in the Big Endian format
   * .
   */
  typedef enum bit {
    LITTLE_ENDIAN       =  0,
    BIG_ENDIAN          =  1
  } endian_enum;


`endif

`ifdef SVT_CHI_ISSUE_E_ENABLE

  /**
   * Enum to represent the operation to be performed on the tags present in the corresponding DAT channel.
   * Following are the possible values:
   * - INVALID  : The tags are not valid.
   * - TRANSFER : The tags are clean. Tag Match does not need to be performed.
   * - UPDATE   : The Allocation Tag values have been updated and are dirty. The tags in memory should be updated.
   * - MATCH    : The Physical Tags in the write must be checked against the Allocation Tag values obtained from memory.
   * .
   */
  typedef enum bit[(`SVT_CHI_TAGOP_WIDTH-1):0]{
    TAG_INVALID  = 0,
    TAG_TRANSFER = 1,
    TAG_UPDATE   = 2,
    TAG_FETCH_MATCH = 3
  } tag_op_enum;
`endif

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to CHI node configuration, available for use by constraints. */
  svt_chi_node_configuration cfg = null;

  /**
   * Variable that holds the object_num of this transaction. VIP assigns a
   * unique number to each transaction it generates from analysis port. This
   * number is also used by the debug port of the VIP, so that transaction
   * number can be displayed in waveform. This helps in ease of
   * debug as it helps to corelate the transaction displayed in log file and
   * in the waveform.
   */
  int object_num = -1;

  /**
   * This field defines the Target ID associated with the transaction.<br>
   * This is the unique physical node ID of the destination port on
   * the interconnect network, to which the transaction is targeted.<br>
   * The Network Layer identifies the Target ID. This field is automatically
   * populated by the VIP in active and passive mode. In active mode, the rand_mode
   * is turned OFF by default. <br>
   * However, when svt_chi_node_configuration::random_tgt_id_enable = 1,
   * the rand_mode is turned ON for this field in case of active RN. Please refer
   * to this configuration attribute description for more details.
   */
  rand bit [(`SVT_CHI_TGT_ID_WIDTH-1):0] tgt_id = 0;

  /**
   * This field defines the Source ID associated with the transaction.<br> This
   * is the unique physical node ID of the source port on the interconnect
   * network, from which the transaction is sent. This field is automatically
   * populated by the VIP in active and passive mode. In active mode, the rand_mode
   * is turned OFF by default. <br>
   * However, when svt_chi_node_configuration::random_src_id_enable = 1,
   * the rand_mode is turned ON for this field in case of active RN. Please refer
   * to this configuration attribute description for more details.
   */
  rand bit [(`SVT_CHI_SRC_ID_WIDTH-1):0] src_id = 0;

`ifdef SVT_CHI_ISSUE_B_ENABLE
  /**
   * @groupname chi_common_xact_dmt
   * The field is applicable only in ReadNoSnp from HN-F to SN-F and is used for Direct Memory Transfer.
   * Identifies the node to which SN-F needs to send CompData response.
   * The value in this field can be either the NID of Home or the Transaction requester.
   * The field is inapplicable in all other requests
   */
  rand bit [(`SVT_CHI_RETURN_NID_WIDTH-1):0] return_nid = 0;

  /**
   * @groupname chi_common_xact_dct
   * The field is applicable only in Forward type Snoops.
   * Identifies the requester to which CompData response can be forwarded.
   * It must be the NID of the Transaction requester.
   * The field is inapplicable in all other snoop requests
   */
  rand bit [(`SVT_CHI_FORWARD_NID_WIDTH-1):0] fwd_nid = 0;

  /**
   * @groupname chi_common_xact_dmt
   * This field Indicates the node Id of the HN
   */
  bit [(`SVT_CHI_HOME_NID_WIDTH-1):0] home_nid = 0;

  /**
   * This field Indicates the DataSource value
   */
  rand data_source_enum data_source = DATA_SOURCE_UNSUPPORTED;

  /** This field indicates the Trace Tag Value*/
  rand bit trace_tag = 0;

  /**
   * @groupname chi_common_xact_cache_stashing
   * This field indicates the node ID of the stash target.
   * Applicable only in stash type requests.
   */
  rand bit[(`SVT_CHI_STASH_NID_WIDTH-1):0] stash_nid = 0;

  /**
   * @groupname chi_common_xact_cache_stashing
   * This field indicates the stash_nid field has a valid Stash target value.
   * Applicable only in stash type requests.
   */
  rand bit stash_nid_valid = 0;

  /**
   * @groupname chi_common_xact_cache_stashing
   * This field  indicates the ID of the logical processor at the Stash target.
   * Applicable only in stash type requests.
   */
  rand bit[(`SVT_CHI_STASH_LPID_WIDTH-1):0] stash_lpid = 0;

  /**
   * @groupname chi_common_xact_cache_stashing
   * This field indicates that the Stash_lpid field value must be
   * considered as the Stash target.
   * Applicable only in stash type requests.
   */
  rand bit stash_lpid_valid = 0;

  `endif

  /**
   * This attribute is set to 1 by the driver after consuming the sequence item
   * from the sequencer. This is required to distinguish if transaction being
   * referred/processed by driver is received through sequencer or is the same
   * one that is just available at monitor.
   *
   */
  bit is_consumed_from_seqr = 0;

 /** @cond PRIVATE */
 /**
    * This flag is set when the address is aligned to the data size.
    */
  bit is_address_aligned_to_datasize = 1'b0;
 /** @endcond */

  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------
  /**
   * This field defines the Transaction ID associated with the transaction.<br>
   * Every new transaction, except a Link Flit from a given source node will have a unique ID. <br>
   * For a Link Flit, this is always set to a value of 0, indicating L-Credit return.
   */
  rand bit [(`SVT_CHI_TXN_ID_WIDTH-1):0] txn_id = 0;

`ifdef SVT_CHI_ISSUE_B_ENABLE
  /**
   * @groupname chi_common_xact_dvm_extension
   * This foeld indicates the final state os the cache line.
   * This corresponds to fwd_state[1:0] attribute.
   */
  bit [(`SVT_CHI_VMID_EXT_WIDTH-1):0] vmid_ext = 0;

  /**
   * @groupname chi_common_xact_dmt
   * The field is applicable only in ReadNoSnp from HN-F to SN-F.
   * Identifies the value SN-F must use in TxnID field of the CompData response.
   * It can be either the TxnID generated by Home for this transaction or the TxnID in Request packet from the Transaction requester.
   * The field is inapplicable in all other requests
   */
  rand bit [(`SVT_CHI_RETURN_TXN_ID_WIDTH-1):0] return_txn_id = 0;

  /**
   * @groupname chi_common_xact_ret_to_src
   * This field indicates if the Snoopee must return a copy of the line to the Home node. <br>
   * Can be set only for SnpShared(Fwd), SnpClean(Fwd), SnpOnce, SnpUnique and SnpNotSharedDirty(Fwd). <br>
   * Applicable for both Fwd and non-Fwd Snoop types. <br>
   * The CHI ICN VIP doesn't support setting of ret_to_src field to 1 for both Fwd and non-Fwd Snoop types. <br>
   * From CHI ISSUE_E or later:
   * - For both Fwd and non-Fwd type snoops, ret_to_src is considered as a hint by the snoopee when initial_cache_line_state is SC.
   * - The behaviour of this rule can be controlled by the configuration parameter fwd_data_from_sc_state_when_rettosrc_set in svt_node_configuration for Active RN.
   * - fwd_data_from_sc_state_when_rettosrc_set in svt_node_configuration is defined only when SVT_CHI_ISSUE_E_ENABLE macro is defined.
   * - Currently this rule is supported only for non-Fwd type snoops.
   * .
   */
  rand bit ret_to_src = 0;

  /**
   * @groupname chi_common_xact_do_not_go_to_sd
   * Do not transition to SD is a modifier on Non-invalidating snoops.
   * It indicates if the Snoopee is permitted to have a final cache state of SD. <br>
   * This field is applicable in the following Snoop Requests:
   * SnpOnce, SnpClean, SnpShared, SnpNotSharedDirty, SnpOnceFwd, SnpCleanFwd, SnpSharedFwd and SnpNotSharedDirtyFwd.
   */
  rand bit do_not_go_to_sd = 0;

  /**
   * @groupname chi_common_xact_dct
   * The field is applicable only in Forward type Snoops.
   * Identifies the value to be used in the TxnID of CompData response forwarded to the Transition requester.
   * It must be the TxnID value in the request from the Transaction requester.
   * The field is inapplicable in all other snoop requests
   */
  rand bit [(`SVT_CHI_FORWARD_TXN_ID_WIDTH-1):0] fwd_txn_id = 0;

  /**
   * @groupname chi_common_xact_dct
   * This field indicates the pass dirty attribute of the response.<br>
   * This corresponds to fwd_state[2] attribute
   * Indicates that the data included in the response message sent to Requester is Dirty with respect to memory
   * and that the responsibility of writing back the cache line is being passed to the Requester.
   */
  rand bit fwd_state_pass_dirty = 0;

  /**
   * @groupname chi_common_xact_dct
   * This foeld indicates the final state os the cache line.
   * This corresponds to fwd_state[1:0] attribute.
   */
   rand cache_state_enum fwd_state_final_state = I;

`endif

  /**
   * This field defines Quality of Service priority level for the transaction,
   * with acending values indicating higher priority levels.<br>
   * This field is used by the transaction end points(source and destination nodes) and
   * the interconnect to manage QoS priority levels across different transaction types.
   * - CHI transaction: This reflects the qos value of the REQ flit. All subsequent Tx flits
   *   from active agent associated to this transaction will have same qos value as that of
   *   the REQ flit.
   * - CHI snoop transaction: This reflects the qos value of the SNP flit. All subseqent Tx flits
   *   from active RN agent associated to this transaction will have same qos value as that of
   *   the SNP flit.
   * .
   */
  rand bit [(`SVT_CHI_QOS_WIDTH-1):0] qos = 0;

  /**
   * This field defines the address associated with the transaction.<br>
   * - For Request transactions and Request flits: addr[(`SVT_CHI_MAX_ADDR_WIDTH-1):0]
   *   represent the address.
   *   + For DVM transactions, only addr[40:0] must be programmed by the users.
   *     In case of CHI-E or later revisions, the higher order address bits such as addr[41] and addr[42]
   *     will be internally set by the VIP based on the programmed value of fields such as dvm_range and dvm_num.
   *   .
   * - For Snoop transactions and Snoop flits: addr[(`SVT_CHI_MAX_ADDR_WIDTH-1):3] represents
   *   the `SVT_CHI_SNP_ADDR_WIDTH bit wide snoop address.
   *   + addr[(`SVT_CHI_MAX_ADDR_WIDTH-1):6] specifies the aligned address of the 64 Byte cache
   *     line, while Addr[5:4] indicates the critical 16B chunk within the cache line.
   *   + addr[3] is meaningful only for DVMOp snoop, for other snoops, addr[3] must be zero.
   *   .
   * .
   */
  rand bit [(`SVT_CHI_MAX_ADDR_WIDTH-1):0] addr = 0;

`ifdef SVT_CHI_ISSUE_E_ENABLE
  /**
   * This field defines the Range for DVM TLBI operations.
   * - Only applicable for DVM operations initiated by CHI-E or later nodes with svt_chi_node_configuration::dvm_version_support set to
   * DEFAULT_SPEC_VERSION/DVM_v8_4 or greater.
   * - Can be set to 1 only for DVM TLBI operations that are Invalidate by VA or IPA. Must be set to zero for all other DVM transactions
   * - When applicable, this field will represent the value of addr[41] in the DVM TLBI request, or, in case of DVM Snoops, addr[41] of the SnpDVMOp Part1 payload.
   *   - In case of active RN, any value programmed in addr[41] of a DVM transaction request will be overwritten with this field.
   *   .
   * - In case of DVM TLBI Snoops, the bit corresponding to FwdNID[0] in the Snoop part 1 payload is repurposed to represent the Range field.
   * .
   * This field can only be set for DVM TLBI (addr[13:11] == 3'b000) and Snoop DVM TLBI transactions, that are invalidate by VA or IPA, and must be zero for all other DVM operations.
   */
  rand bit [(`SVT_CHI_DVM_RANGE_WIDTH-1):0] dvm_range = 0;

  /**
   * This field defines the Num field for range based DVM TLBI operations.
   * - Only applicable for Range based DVM TLBI operations initiated by CHI-E or later nodes with svt_chi_node_configuration::dvm_version_support set to
   * DEFAULT_SPEC_VERSION/DVM_v8_4 or greater.
   * - When applicable, this field will represent the value of {addr[42],data[3:0]} in the DVM TLBI transaction.
   *   - In case of active RN, any value programmed in addr[42] and data[3:0] will be overwritten with this field for Range based DVM TLBI transactions.
   *   .
   * - In case of DVM TLBI Snoops, the bits corresponding to FwdNID[4:0] in the Snoop part 2 payload are repurposed to represent the Num field.
   * .
   * This field can only be set for Range based DVM TLBI (addr[13:11] == 3'b000) and Snoop DVM TLBI transactions and must be zero for all other DVM operations.
   */
  rand bit [(`SVT_CHI_DVM_NUM_WIDTH-1):0] dvm_num = 0;

  /**
   * This field defines the Scale field for range based DVM TLBI operations.
   * - Only applicable for Range based DVM TLBI operations initiated by CHI-E or later nodes with svt_chi_node_configuration::dvm_version_support set to
   * DEFAULT_SPEC_VERSION/DVM_v8_4 or greater.
   * - When applicable, this field will represent the value of data[5:4] in the DVM TLBI transaction.
   *   - In case of active RN, any value programmed in data[5:4] will be overwritten with this field for Range based DVM TLBI transactions.
   *   - In case of ICN full slave, any value programmed in data[5:4] of a Range based TLBI SnpDVMOp transaction request will be overwritten with this field.
   *   .
   * .
   * This field can only be set for Range based DVM TLBI (addr[13:11] == 3'b000) and Snoop DVM TLBI transactions and must be zero for all other DVM operations.
   */
  rand bit [(`SVT_CHI_DVM_SCALE_WIDTH-1):0] dvm_scale = 0;

  /**
   * This field defines the TTL field for DVM TLBI operations with Level Hint as well as range based DVM TLBI operations.
   * - Only applicable for DVM TLBI operations that are invalidate by VA or IPA and are initiated by CHI-E or later nodes with svt_chi_node_configuration::dvm_version_support set to
   * DEFAULT_SPEC_VERSION/DVM_v8_4 or greater.
   * - When applicable, this field will represent the value of data[7:6] in the DVM TLBI transaction.
   *   - In case of active RN, any value programmed in data[7:6] will be overwritten with this field for DVM TLBI transactions with VA Valid asserted.
   *   - In case of ICN full slave, any value programmed in data[7:6] of a TLBI SnpDVMOp transaction request with VA Valid asserted will be overwritten with this field.
   *   .
   * .
   * This field can only be set for DVM TLBI (addr[13:11] == 3'b000) and Snoop DVM TLBI transactions, that are invalidate by VA or IPA, and must be zero for all other DVM operations.
   */
  rand bit [(`SVT_CHI_DVM_TTL_WIDTH-1):0] dvm_ttl = 0;

  /**
   * This field defines the TG field for DVM TLBI operations with Level Hint as well as range based DVM TLBI operations.
   * - Only applicable for Range based DVM TLBI operations that are invalidate by VA or IPA and are initiated by CHI-E or later nodes with svt_chi_node_configuration::dvm_version_support set to
   * DEFAULT_SPEC_VERSION/DVM_v8_4 or greater.
   * - When applicable, this field will represent the value of data[9:8] in the DVM TLBI transaction.
   *   - In case of active RN, any value programmed in data[9:8] will be overwritten with this field for DVM TLBI transactions with VA Valid asserted.
   *   - In case of ICN full slave, any value programmed in data[9:8] of a TLBI SnpDVMOp transaction request with VA Valid asserted will be overwritten with this field.
   *   .
   * .
   * This field can only be set for DVM TLBI (addr[13:11] == 3'b000) and Snoop DVM TLBI transactions, that are invalidate by VA or IPA, and must be zero for all other DVM operations.
   */
  rand bit [(`SVT_CHI_DVM_TG_WIDTH-1):0] dvm_tg = 0;

  /**
   * This field defines the Replacement value in SLCRepHint .
   * - This corresponds to SLCRepHint[2:1] attribute.
   * - When svt_chi_node_configuration:slcrephint_mode=SLC_REP_HINT_SPEC_RECOMMENDED 
   * - This feild should be populated according to the spec recommendation as follows.
   *    - 3’b000           No recommendation (default) 
   *    - 3’b100           Most likely to be used again 
   *    - 3’b101           More likely to be used again 
   *    - 3’b110           Somewhat likely to be used again 
   *    - 3’b111           Least likely to be used again 
   *    - 3’b001-3’b011    Reserved 
   *    .
   * - When svt_chi_node_configuration:slcrephint_mode=SLC_REP_HINT_USER_DEFINED Encoding of this feild is implementation defined.
   * .
   */
  rand bit [`SVT_CHI_SLCREPLACEMENTHINT_REPLACEMENT_FIELD_WIDTH-1:0] slcrephint_replacement = 0;
 
  /**
   * This field defines the UnusedPrefetch value in SLCRepHint .
   *  - This corresponds to SLCRepHint[0] attribute.
   *  - Encoding of this field is as follows.
   * 
   *  - UnusedPrefetch   
   *    - 1 : The line was not used since being fetched.
   *    - 0 : The line may have been used since being fetched.
   *    .
   *  .
   */
  rand bit slcrephint_unusedprefetch = 0;
 
  /**
   * This field defines the reserved bits value in SLCRepHint .
   * - This corresponds to reserve bits of SLCRepHint attribute.
   * .
   */
  rand bit [(`SVT_CHI_MAX_SLCREPLACEMENTHINT_RESERVED_FIELD_WIDTH-1):0] slcrephint_reserved = 0;

`endif

  /**
   * This field defines the address.
   * The address is aligned to the cacheline size.
   * This should not be programmed by user.
   */
  rand bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0]  cachelinesize_aligned_addr = 0;

 /** @cond PRIVATE */
 /**
    * This field defines the address.
    * The address is aligned to the data width.
    * This should not be programmed by user.
    */
  rand bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0]  datasize_aligned_addr = 0;
  /** @endcond */

  /**
   * This field defines Non secure access mode.<br>
   * When set, it indicates a non-secure mode access. Otherwise, the access is done in secure mode.
   */
  rand bit is_non_secure_access = 0;

  /**
   * This field defines Protocol Credit Type.<br>
   * - In credit transfer transactions, this field indicates the type of
   * protocol credit being granted or returned.
   * - In the RetryAck transaction, it indicates the protocol credit type
   * that the sender must acquire before dispatching the corresponding request.
   * The retried request must be sent with the p_crd_type field appropriately set.
   * .
   *
   * The comonents that observe/receive RetryAck updates this attribute of the request transaction
   * to reflect the p_crd_type required to retry the transaction again. This is done along with
   * setting the req_status to RETRY before writing to analysis port.
   */
  rand p_crd_type_enum p_crd_type = TYPE0;

  /**
   * This field defines the Reserved Value defined by the user for Protocol Request VC Flit. <br>
   * Any value can be driven on this field.<br>
   * This field is not applicable when svt_chi_node_configuration::req_flit_rsvdc_width is set to zero.
   */
  rand bit [(`SVT_CHI_REQ_RSVDC_WIDTH-1):0] req_rsvdc = 0;

  /**
   * This field indicates the pass dirty attribute of the response.<br>
   * - This indicates that the data being returned in the case of ReadShared and
   * ReadUnique request types, is dirty with respect to memory and that the
   *  responsibility of writing back the line is being passed.
   * - In the case of MakeUnique the requester may own the line in UD state,
   * even though no data is transferred.
   * - In responses for all other request types this field must be set to zero.
   * .
   */
  rand bit resp_pass_dirty = 0;

  /**
   * This field indicates the current state of the cache line. <br>
   * For write data responses, this corresponds to resp[1:0] attribute and
   * indicates the current state of the data in the RN.
   * In case of Reads and dataless transactions at active RN, this field will indicate 
   * the cache line state at the point of reception of the CompData or RespSepData response.
   */
  rand cache_state_enum current_state = I;

  /**
   * This field indicates the final state of the cache line. <br>
   * For snoop responses, this corresponds to resp[1:0] attribute and
   * indicates the final state of the snooped target node. <br>
   * For completion responses, this corresponds to resp[1:0] attribute
   * and indicates the final state in the RN.
   */
  rand cache_state_enum final_state = I;

  /**
   * This field defines Data Buffer ID associated with Write transactions.<br>
   * In response to Write requests, the DBID is sent to the requestor, following which
   * the requestor sends the data associated with the Write requests along with the DBID.
   */
  rand bit [(`SVT_CHI_DBID_WIDTH-1):0] dbid = 0;

  /**
   * Defines a reference event from which the TXREQFLITV delay
   * should start.  Following are the different reference events:
   *
   * TXREQFLITPEND_VALID:
   * Reference event is TXREQFLITPEND.
   *
   */
  rand reference_event_for_txreqflitv_delay_enum reference_event_for_txreqflitv_delay = TXREQFLITPEND_VALID;

  /**
   * Defines the delay in number of cycles for TXREQFLITV signal.
   * The reference event for this delay is reference_event_for_txreqflitv_delay
   * Applicable for ACTIVE RN only.
   * Default value is 1.
   */
  rand int txreqflitv_delay = `SVT_CHI_MIN_TXREQFLITV_DELAY;

  /**
   * Defines a reference event from which the TXSNPFLITV delay
   * should start.  Following are the different reference events:
   *
   * TXSNPFLITPEND_VALID:
   * Reference event is TXSNPFLITPEND.
   *
   */
  rand reference_event_for_txsnpflitv_delay_enum reference_event_for_txsnpflitv_delay = TXSNPFLITPEND_VALID;

  /**
   * Defines the delay in number of cycles for TXSNPFLITV signal.
   * The reference event for this delay is reference_event_for_txsnpflitv_delay
   * Applicable only for ICN Full-Slave mode.
   * Default value is 1.
   */
  rand int txsnpflitv_delay = `SVT_CHI_MIN_TXSNPFLITV_DELAY;

  /**
   * Defines a reference event from which the TXDATFLITV
   * delay should start.  Following are the different reference events:
   *
   * TXDATFLITPEND_VALID:
   * Reference event is TXDATFLITPEND.
   */
  rand reference_event_for_txdatflitv_delay_enum reference_event_for_txdatflitv_delay = TXDATFLITPEND_VALID;

  /**
   * Defines the delay in number of cycles for TXDATFLITV signal.
   * The size of this array must be equal to the number of data VC flits associated.
   * The reference event for this delay is reference_event_for_txdatflitv_delay
   * Applicable for both ACTIVE RN and ICN Full-Slave mode. <br>
   * Active RN: In case of Fwd Type snoop transaction, size of this array still will be
   * equal to number of Forwarded data flits, as well as Snoop response data flits.
   * Same values will be applied to both types of DAT flits if applicable.
   */
  rand int txdatflitv_delay[];

  /**
    * Defines a reference event from which the TXRSPFLITV
    * delay should start.Following are the different reference events:
    *
    * TXRSPFLITPEND_VALID:
    * Reference event is TXRSPFLITPEND.
    */
   rand reference_event_for_txrspflitv_delay_enum reference_event_for_txrspflitv_delay = TXRSPFLITPEND_VALID;

  /**
   * Defines the delay in number of cycles for TXRSPFLITV signal.
   * The reference event for this delay is reference_event_for_txrspflitv_delay
   * Applicable for ACTIVE RN, ACTIVE SN and ICN Full-Slave mode.
   * Default value is 1.
   */
  rand int txrspflitv_delay = `SVT_CHI_MIN_TXRSPFLITV_DELAY;


  /**
   * Defines a reference event from which the TXREQFLITPEND delay
   * should start.  Following are the different reference events:
   *
   * REQ_FLIT_AND_LCRD_AVAILABLE_AT_LINK_LAYER:
   * Reference event is Availability of L-credits to transmit the REQ flit once the flit
   * is available at link layer.
   */
  rand reference_event_for_txreqflitpend_delay_enum reference_event_for_txreqflitpend_delay = REQ_FLIT_AND_LCRD_AVAILABLE_AT_LINK_LAYER;

  /**
   * - Defines the delay in number of cycles for TXREQFLITPEND signal for the Protocol layer transaction.
   * - The reference event for this delay is reference_event_for_txreqflitpend_delay.
   * - Applicable for ACTIVE RN only when both the following attributes
   *   svt_chi_node_configuration::delays_enable and svt_chi_node_configuration::prot_layer_delays_enable
   *   are set to 1.
   * - Default value is 1.
   * - Type: Static.
   * .
   */
  rand int txreqflitpend_delay = `SVT_CHI_MIN_TXREQFLITPEND_DELAY;

  /**
   * Defines a reference event from which the first TXDATFLITPEND
   * delay should start.  Following are the different reference events:
   *
   * FIRST_DAT_FLIT_AND_LCRD_AVAILABLE_AT_LINK_LAYER:
   * Reference event is Availability of L-credits to transmit the DAT flit once the flit
   * is available at link layer.
   *
   */
  rand reference_event_for_first_txdatflitpend_delay_enum reference_event_for_first_txdatflitpend_delay = FIRST_DAT_FLIT_AND_LCRD_AVAILABLE_AT_LINK_LAYER;

  /**
   * Defines a reference event from which the next TXDATFLITPEND
   * delay should start.  Following are the different reference events:
   *
   * NEXT_DAT_FLIT_AND_LCRD_AVAILABLE_AT_LINK_LAYER:
   * Reference event is Availability of L-credits to transmit the DAT flit once the flit
   * is available at link layer.
   */
  rand reference_event_for_next_txdatflitpend_delay_enum reference_event_for_next_txdatflitpend_delay = NEXT_DAT_FLIT_AND_LCRD_AVAILABLE_AT_LINK_LAYER;

  /**
   * - Defines the delay in number of cycles for TXDATFLITPEND signal for the Protocol transaction and Snoop transaction.
   * - The size of this array must be equal to the number of data VC flits associated.
   * - The reference event for this delay is:
   *   - For txdatflitpend_delay[0] - #reference_event_for_first_txdatflitpend_delay
   *   - For remaining indices of txdatflitpend_delay - #reference_event_for_next_txdatflitpend_delay
   *   .
   * - Applicable for ACTIVE RN only when both the following attributes
   *   svt_chi_node_configuration::delays_enable and svt_chi_node_configuration::prot_layer_delays_enable
   *   are set to 1.
   * - Active RN: In case of Fwd Type snoop transaction, size of this array still will be
   *   equal to number of Forwarded data flits, as well as Snoop response data flits.
   *   Same values will be applied to both types of DAT flits if applicable.
   * - Type: Static.
   * .
   */
  rand int txdatflitpend_delay[];

  /**
    * Defines a reference event from which the TXRSPFLITPEND
    * delay should start.  Following are the different reference events:
    *
    * RSP_FLIT_AND_LCRD_AVAILABLE_AT_LINK_LAYER:
    * Reference event is Availability of L-credits to transmit the RSP flit once the flit
    * is available at link layer.
    */
   rand reference_event_for_txrspflitpend_delay_enum reference_event_for_txrspflitpend_delay = RSP_FLIT_AND_LCRD_AVAILABLE_AT_LINK_LAYER;

  /**
   * - Defines the delay in number of cycles for TXRSPFLITPEND signal for the Protocol transaction and Snoop transaction.
   * - The reference event for this delay is reference_event_for_txreqflitpend_delay.
   * - Applicable for ACTIVE RN, ACTIVE SN only when both the following attributes
   *   svt_chi_node_configuration::delays_enable and svt_chi_node_configuration::prot_layer_delays_enable
   *   are set to 1.
   * - Default value is 1.
   * - Type: Static.
   * .
   */
  rand int txrspflitpend_delay = `SVT_CHI_MIN_TXRSPFLITPEND_DELAY;

  /** @cond PRIVATE */
  /**
    * Defines a reference event from which the RXDATLCRDV delay
    * should start.  Following are the different reference events:
    *
    * If this is the first RXDATLCRDV, RXLA_RUN is used as a reference event.
    *
    * RXDATLCRDV_REF_PREV_RXDATFLITV_VALID:
    * Reference event is previous RXDATFLITV. It is used as a reference event
    * if it is not the first RXDATLCRDV.
    */
   rand reference_event_for_rxdatlcrdv_delay_enum reference_event_for_rxdatlcrdv_delay = RXDATLCRDV_REF_PREV_RXDATFLITV_VALID;

  /**
   * Defines the delay in number of cycles for RXDATLCRDV signal.
   * The size of this array must be equal to the number of data VC flits associated.
   * The reference event for this delay is reference_event_for_rxdatlcrdv_delay
   * Applicable for both ACTIVE RN and ACTIVE SN.
   */
  rand int rxdatlcrdv_delay[];

  /**
    * Defines a reference event from which the RXSNPLCRDV delay
    * should start.  Following are the different reference events:
    *
    * If this is the first RXSNPLCRDV, RXLA_RUN is used as a reference event.
    *
    * RXSNPFLITV_VALID:
    * Reference event is RXSNPFLITV.It is used as a reference event
    * if it is not the first RXSNPLCRDV.
    */
   rand reference_event_for_rxsnplcrdv_delay_enum reference_event_for_rxsnplcrdv_delay = RXSNPFLITV_VALID;

  /**
   * Defines the delay in number of cycles for RXSNPLCRDV signal.
   * The reference event for this delay is reference_event_for_rxsnplcrdv_delay
   * Applicable for ACTIVE RN only.
   * Default value is 1.
   */
  rand int rxsnplcrdv_delay = `SVT_CHI_MIN_RXSNPLCRDV_DELAY;

  /**
    * Defines a reference event from which the RXRSPLCRDV delay
    * should start.  Following are the different reference events:
    *
    * If this is the first RXRSPLCRDV, RXLA_RUN is used as a reference event.
    *
    * RXRSPFLITV_VALID:
    * Reference event is RXRSPFLITV.It is used as a reference event
    * if it is not the first RXRSPLCRDV.
    */
   rand reference_event_for_rxrsplcrdv_delay_enum reference_event_for_rxrsplcrdv_delay = RXRSPFLITV_VALID;

  /**
   * Defines the delay in number of cycles for RXRSPLCRDV signal.
   * The reference event for this delay is reference_event_for_rxrsplcrdv_delay
   * Applicable for ACTIVE RN only.
   * Default value is 1.
   */
  rand int rxrsplcrdv_delay = `SVT_CHI_MIN_RXRSPLCRDV_DELAY;
  /** @endcond */

 /**
   * This field defines Critical Chunk ID. This field indicates the
   * critical 128b(16B) chunk of data that is being requested. <br>
   * Critical chunk is the flit that contains the data byte whose
   * address matches the transaction address.
   */
  ccid_enum ccid = CCID_DATA_127_DOWN_TO_0;


  /** @cond PRIVATE */
  /** Represents status of the request. Following are the applicable states:
    * - INITIAL  : Request has not yet started
    * - ACTIVE   : Request has been sent, but no response has been received. If
    * a RETRY response was received, the transaction will come back to this
    * state when the request is retried.
    * - PARTIAL_ACCEPT : Atleast one response has been received, but not all
    * expected responses to the request have been received. For example, for a READ type
    * transaction where ordering is required, ReadReceipt is received, but
    * CompData is not received. Or, for a WRITE type transaction, DBID is received,
    * but Comp is not yet received.
    * - RETRY    : A retry ack was received for the response. When the request
    * is retried again, the status switches back to ACTIVE.
    * - CANCELLED: A request that got a RETRY ack was cancelled by sending back the
    * allocated credit through PCrdReturn message.
    * - ACCEPT   : All expected responses to the request, other than what is
    * expected on the data VC is received. For a READ type transaction, where
    * ordering is required, this means that both ReadReceipt and atleast one
    * data flit has been received. For a READ type transaction, where ordering
    * is not required, this means that atleast one data flit is received.  For
    * a WRITE/CopyBack type transaction, this means that Comp and DBID or
    * CompDBIDResp are received.
    * - ABORTED  : Request got aborted due to reset.
    * .
    */
  status_enum req_status = INITIAL;

  /** Represents status of messages received through DAT VC. Following are the
    * applicable states:
    * - INITIAL        : No data has been received/sent
    * - PARTIAL_ACCEPT : Atleast one data flit has been received/sent
    * - ACCEPT         : All data flits corresponding to the message are received/sent
    * - ABORTED        : All/some of the data flits got aborted due to reset
    * .
    */
  status_enum data_status = INITIAL;

  /** Represents status field for miscellaneous response messages. Currently
    * used for CompAck message. Following are the applicable states:
    * - INITIAL   : Response has not been received/sent.
    * - ACCEPT    : Response has been received
    * - ABORTED   : Response was aborted due to reset
    * .
    */
  status_enum resp_status = INITIAL;

  /** @endcond */

`ifdef SVT_CHI_ISSUE_B_ENABLE
  /** @cond PRIVATE */
  /** Represents status of Atomic Write messages received through DAT VC. Following are the
    * applicable states:
    * - INITIAL        : No data has been received/sent
    * - PARTIAL_ACCEPT : Atleast one data flit has been received/sent
    * - ACCEPT         : All data flits corresponding to the message are received/sent
    * - ABORTED        : All/some of the data flits got aborted due to reset
    * .
    */
  status_enum atomic_write_data_status = INITIAL;

  /** Represents status of Atomic Read data messages received through DAT VC. Following are the
    * applicable states:
    * - INITIAL        : No data has been received/sent
    * - PARTIAL_ACCEPT : Atleast one data flit has been received/sent
    * - ACCEPT         : All data flits corresponding to the message are received/sent
    * - ABORTED        : All/some of the data flits got aborted due to reset
    * .
    */
  status_enum atomic_returned_initial_data_status = INITIAL;
  /** @endcond */
`endif

   /**
     * Weight used to control distribution of zero delay within transaction generation.
     *
     * This controls the distribution of delays for the 'delay' fields
     * (e.g., txreqflitpend_delay).
     */
  int MIN_DELAY_wt = 100;

   /**
     * Weight used to control distribution of short delays within transaction generation.
     *
     * This controls the distribution of delays for the 'delay' fields
     * (e.g., txreqflitpend_delay).
     */
  int SHORT_DELAY_wt = 500;

  /**
    * Weight used to control distribution of long delays within transaction generation.
    *
    * This controls the distribution of delays for the 'delay' fields
    * (e.g., txreqflitpend_delay).
    */
  int LONG_DELAY_wt = 1;

  /**
    * String containing source and target information such as the ID, Index and interface type.
    */
  string source_target_info = "";

  /** @cond PRIVATE */
  /**
    * String containing the short handle display of the original CCIX transaction.
    * Applicable only in case of CCIX mapped CHI transactions
    */
  string original_ccix_xact_short_handle_str = "";

  /**
    * String containing the full display of the original CCIX transaction.
    * Applicable only in case of CCIX mapped CHI transactions
    */
  string original_ccix_xact_full_display_str = "";
  /** @endcond */

`ifdef SVT_CHI_ISSUE_D_ENABLE

  /**
   * Defines the deep field.
   */
  rand bit deep = 0;

  /**
   * Defines the PGroupID field.
   */
  rand bit [(`SVT_CHI_PGROUPID_WIDTH-1):0] pgroup_id = 0;

  /**
   * This field defines the partition ID value in MPAM.
   * This corresponds to MPAM[9:1] attribute.
   */
  rand bit [(`SVT_CHI_MAX_MPAM_PARTID_WIDTH-1):0] mpam_partid = 0;

  /**
   * This field defines the PerfMonGroup (Perfromance Monitor Group) value in MPAM.
   * This corresponds to MPAM[10] attribute.
   */
  rand bit [(`SVT_CHI_MAX_MPAM_PERFMONGROUP_WIDTH-1):0] mpam_perfmongroup = 0;

  /**
   * This field defines the MPAMNS value in MPAM.
   * This corresponds to MPAM[0] attribute.
   */
  rand bit [(`SVT_CHI_MPAM_NS_WIDTH-1):0] mpam_ns =0;
`endif

`ifdef SVT_CHI_ISSUE_E_ENABLE

  /**
    * Defines the groupidext field.
    * Represents the extended bits in PGroupID for Persistent CMO transactions.
    * Represents the extended bits in TagGroupID for Writes and atomics that require Tags to be matched.
    * This is a read only field and should not be programmed by the user.
    * This field will be populated by the VIP as follows:
    * - For Persistent CMO transactions: groupid_ext = pgroup_id[7:5]
    * - For Write transactions and Atomic transactions: groupid_ext = tag_group_id[7:5]
    * .
    */
  rand bit [(`SVT_CHI_GROUPIDEXT_WIDTH-1):0] groupid_ext = 0;

  /** Defines the tag_group_id field */
  rand bit [(`SVT_CHI_TAGGROUPID_WIDTH-1):0] tag_group_id = 0;

  /** Defines the stash_group_id field */
  rand bit [(`SVT_CHI_STASHGROUPID_WIDTH-1):0] stash_group_id = 0;

  /**
    * Defines the do_dwt field
    * - Only applicable in WriteNoSnpFull, WriteNoSnpPtl and Write requests combined with CMO or PCMO from Home to Slave.
    * - It is inapplicable and must be set to zero in all other requests.
    * - The bit shares the same field as SnpAttr.
    * .
    */
  rand bit do_dwt = 0;

`endif

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bIJoq0q0zCTtOdwM7z3Y5eRcO+zuCKtXAlX9QouYbcuc06stTM7kPPQZyCPW7mNV
bqYVHlYFa9P5R5pHCAd/c8JxXeiNb3GMd9GRTwUT8DfToSlwOEH7udhohRPytrJ/
SP1/auSN7hifOYrEKOIaJtgvaeukTv1T32iJJ8T63CU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 186       )
5ZHUXTEkuxFQ7WmCtHYOa/DzxfsAfaG1H2EILQD6g7yx9WKw3qBWCefkyM2CoQGO
1Vgcx/L/Ku0nRIqy7BsSFNRrl2jqRnoyHCXBXOOItikiPCrAqX/4DahgKlVlFKOg
4/1odOCgxogwAABtYxGtoP7qbipw0Qk4S6OlMWRsK/eaoj2W00qy2Y2hd6achIJo
mSaKtjPduMQHJQBzWf9dAJkbF6A7D3KFMTvxs/vMJYFLPc+5J88GtqpcaiBa3M+F
`pragma protect end_protected
`ifdef SVT_VMM_TECHNOLOGY
  local int my_inst_id;
  static protected int my_inst_count;
`endif
  //----------------------------------------------------------------------------
  // Constraints
  //----------------------------------------------------------------------------

  /**
   * Valid ranges constraints insure that the transaction settings are supported
   * by the chi components.
   */
  constraint valid_ranges {
   `ifdef SVT_CHI_ISSUE_B_ENABLE
     if(cfg.addr_width < `SVT_CHI_MAX_ADDR_WIDTH) {
       ((addr >> cfg.addr_width) == 0);
     }

     if(cfg.node_id_width < `SVT_CHI_MAX_NODE_ID_WIDTH) {
       ((src_id >> cfg.node_id_width) == 0);
       ((tgt_id >> cfg.node_id_width) == 0);
       ((home_nid >> cfg.node_id_width) == 0);
       ((fwd_nid >> cfg.node_id_width) == 0);
       ((return_nid >> cfg.node_id_width) == 0);
     }
   `endif
    foreach (rxdatlcrdv_delay[index]) {
      rxdatlcrdv_delay[index] inside {[`SVT_CHI_MIN_RXDATLCRDV_DELAY:`SVT_CHI_MAX_RXDATLCRDV_DELAY]};
    }
    rxsnplcrdv_delay inside {[`SVT_CHI_MIN_RXSNPLCRDV_DELAY:`SVT_CHI_MAX_RXSNPLCRDV_DELAY]};
    rxrsplcrdv_delay inside {[`SVT_CHI_MIN_RXRSPLCRDV_DELAY:`SVT_CHI_MAX_RXRSPLCRDV_DELAY]};
  }

  constraint chi_reasonable_flitpend_flitv_vc_delays
  {
    txreqflitpend_delay inside {[`SVT_CHI_MIN_TXREQFLITPEND_DELAY:`SVT_CHI_MAX_TXREQFLITPEND_DELAY]};
    txreqflitv_delay inside {[`SVT_CHI_MIN_TXREQFLITV_DELAY:`SVT_CHI_MAX_TXREQFLITV_DELAY]};
    txsnpflitv_delay inside {[`SVT_CHI_MIN_TXSNPFLITV_DELAY:`SVT_CHI_MAX_TXSNPFLITV_DELAY]};
    foreach (txdatflitpend_delay[index]) {
      txdatflitpend_delay[index] inside {[`SVT_CHI_MIN_TXDATFLITPEND_DELAY:`SVT_CHI_MAX_TXDATFLITPEND_DELAY]};
    }
    foreach (txdatflitv_delay[index]) {
      txdatflitv_delay[index] inside {[`SVT_CHI_MIN_TXDATFLITV_DELAY:`SVT_CHI_MAX_TXDATFLITV_DELAY]};
    }
    txrspflitpend_delay inside {[`SVT_CHI_MIN_TXRSPFLITPEND_DELAY:`SVT_CHI_MAX_TXRSPFLITPEND_DELAY]};
    txrspflitv_delay inside {[`SVT_CHI_MIN_TXRSPFLITV_DELAY:`SVT_CHI_MAX_TXRSPFLITV_DELAY]};

  }

  // ****************************************************************************
  //           Delay Reasonable Constraints
  // ****************************************************************************

  // Enforces a distribution based on the weights.

  constraint reasonable_txreqflitpend_delay {
   txreqflitpend_delay dist {
     `SVT_CHI_MIN_TXREQFLITPEND_DELAY := MIN_DELAY_wt,
     [`SVT_CHI_MIN_TXREQFLITPEND_DELAY:(`SVT_CHI_MAX_TXREQFLITPEND_DELAY >> 2)] :/ SHORT_DELAY_wt,
     [((`SVT_CHI_MAX_TXREQFLITPEND_DELAY >> 2)+1):`SVT_CHI_MAX_TXREQFLITPEND_DELAY] :/ LONG_DELAY_wt
   };
  }

  constraint reasonable_txreqflitv_delay {
   txreqflitv_delay dist {
     `SVT_CHI_MIN_TXREQFLITV_DELAY := MIN_DELAY_wt,
     [`SVT_CHI_MIN_TXREQFLITV_DELAY:(`SVT_CHI_MAX_TXREQFLITV_DELAY >> 2)] :/ SHORT_DELAY_wt,
     [((`SVT_CHI_MAX_TXREQFLITV_DELAY >> 2)+1):`SVT_CHI_MAX_TXREQFLITV_DELAY] :/ LONG_DELAY_wt
   };
  }

  constraint reasonable_txsnpflitv_delay {
   txsnpflitv_delay dist {
     `SVT_CHI_MIN_TXSNPFLITV_DELAY := MIN_DELAY_wt,
     [`SVT_CHI_MIN_TXSNPFLITV_DELAY:(`SVT_CHI_MAX_TXSNPFLITV_DELAY >> 2)] :/ SHORT_DELAY_wt,
     [((`SVT_CHI_MAX_TXSNPFLITV_DELAY >> 2)+1):`SVT_CHI_MAX_TXSNPFLITV_DELAY] :/ LONG_DELAY_wt
   };
  }

  constraint reasonable_txdatflitpend_delay {
    foreach (txdatflitpend_delay[idx]) {
      txdatflitpend_delay[idx] dist {
            `SVT_CHI_MIN_TXDATFLITPEND_DELAY := MIN_DELAY_wt,
            [`SVT_CHI_MIN_TXDATFLITPEND_DELAY:(`SVT_CHI_MAX_TXDATFLITPEND_DELAY >> 2)] :/ SHORT_DELAY_wt/2,
            [((`SVT_CHI_MAX_TXDATFLITPEND_DELAY >> 2)+1):`SVT_CHI_MAX_TXDATFLITPEND_DELAY] :/ LONG_DELAY_wt
      };
    }
  }

  constraint reasonable_txdatflitv_delay {
    foreach (txdatflitv_delay[idx]) {
      txdatflitv_delay[idx] dist {
            `SVT_CHI_MIN_TXDATFLITV_DELAY := MIN_DELAY_wt,
            [`SVT_CHI_MIN_TXDATFLITV_DELAY:(`SVT_CHI_MAX_TXDATFLITV_DELAY >> 2)] :/ SHORT_DELAY_wt/2,
            [((`SVT_CHI_MAX_TXDATFLITV_DELAY >> 2)+1):`SVT_CHI_MAX_TXDATFLITV_DELAY] :/ LONG_DELAY_wt
      };
    }
  }

  constraint reasonable_txrspflitpend_delay {
   txrspflitpend_delay dist {
     `SVT_CHI_MIN_TXRSPFLITPEND_DELAY := MIN_DELAY_wt,
     [`SVT_CHI_MIN_TXRSPFLITPEND_DELAY:(`SVT_CHI_MAX_TXRSPFLITPEND_DELAY >> 2)] :/ SHORT_DELAY_wt,
     [((`SVT_CHI_MAX_TXRSPFLITPEND_DELAY >> 2)+1):`SVT_CHI_MAX_TXRSPFLITPEND_DELAY] :/ LONG_DELAY_wt
   };
  }

  constraint reasonable_txrspflitv_delay {
   txrspflitv_delay dist {
     `SVT_CHI_MIN_TXRSPFLITV_DELAY := MIN_DELAY_wt,
     [`SVT_CHI_MIN_TXRSPFLITV_DELAY:(`SVT_CHI_MAX_TXRSPFLITV_DELAY >> 2)] :/ SHORT_DELAY_wt,
     [((`SVT_CHI_MAX_TXRSPFLITV_DELAY >> 2)+1):`SVT_CHI_MAX_TXRSPFLITV_DELAY] :/ LONG_DELAY_wt
   };
  }

  constraint reasonable_rxdatlcrdv_delay {
    foreach (rxdatlcrdv_delay[idx]) {
      rxdatlcrdv_delay[idx] dist {
            `SVT_CHI_MIN_RXDATLCRDV_DELAY := MIN_DELAY_wt,
            [`SVT_CHI_MIN_RXDATLCRDV_DELAY:(`SVT_CHI_MAX_RXDATLCRDV_DELAY >> 2)] :/ SHORT_DELAY_wt/2,
            [((`SVT_CHI_MAX_RXDATLCRDV_DELAY >> 2)+1):`SVT_CHI_MAX_RXDATLCRDV_DELAY] :/ LONG_DELAY_wt
      };
    }
  }

  constraint reasonable_rxsnplcrdv_delay {
   rxsnplcrdv_delay dist {
     `SVT_CHI_MIN_RXSNPLCRDV_DELAY := MIN_DELAY_wt,
     [`SVT_CHI_MIN_RXSNPLCRDV_DELAY:(`SVT_CHI_MAX_RXSNPLCRDV_DELAY >> 2)] :/ SHORT_DELAY_wt,
     [((`SVT_CHI_MAX_RXSNPLCRDV_DELAY >> 2)+1):`SVT_CHI_MAX_RXSNPLCRDV_DELAY] :/ LONG_DELAY_wt
   };
  }

  constraint reasonable_rxrsplcrdv_delay {
   rxrsplcrdv_delay dist {
     `SVT_CHI_MIN_RXRSPLCRDV_DELAY := MIN_DELAY_wt,
     [`SVT_CHI_MIN_RXRSPLCRDV_DELAY:(`SVT_CHI_MAX_RXRSPLCRDV_DELAY >> 2)] :/ SHORT_DELAY_wt,
     [((`SVT_CHI_MAX_RXRSPLCRDV_DELAY >> 2)+1):`SVT_CHI_MAX_RXRSPLCRDV_DELAY] :/ LONG_DELAY_wt
   };
  }

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_chi_common_transaction)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param log VMM Log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the transaction.
   */
  extern function new(string name = "svt_chi_common_transaction");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros
  //----------------------------------------------------------------------------
  `svt_data_member_begin(svt_chi_common_transaction)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_REFERENCE|`SVT_UVM_NOPACK, `SVT_HOW_REF)
  `svt_data_member_end(svt_chi_common_transaction)

  /** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   *
   * @param on_off Indicates whether constraint_mode for reasonable constraints
   * should be enabled (1) or disabled (0).
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);


  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_chi_common_transaction.
   */
  extern virtual function vmm_data do_allocate();
`endif


`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind.
   * Differences are placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`else
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs.
   *
   * @param rhs Object to be compared against.
   * @param comparer `SVT_XVM(comparer) instance used to accomplish the compare.
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`endif

  //----------------------------------------------------------------------------
  /**
   * Does a basic validation of this transaction object.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt.
   */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

  /** @endcond */

  /**
   * This method returns the timing information when a REQ Flit
   * completes at the transmitter. User can call this API to get
   * the corresponding simulation time when a REQ Flit completes
   * at the transmitter.
   *
   * req_flit_end_time - The simulation time when the REQ FLIT
   * completes, is captured in this member.
   *
   * Returns 1, if the REQ Flit exists, else return 0.
   */
   extern function bit get_req_timing_info(output real req_flit_end_time);

  /**
   * This method returns the timing information when a SNP Flit
   * completes at the transmitter. User can call this API to get
   * the corresponding simulation time when a SNP Flit completes
   * at the transmitter.
   *
   * snp_flit_end_time - The simulation time when the SNP FLIT
   * completes, is captured in this member.
   *
   * Returns 1, if the SNP Flit exists, else return 0.
   */
   extern function bit get_snp_timing_info(output real snp_flit_end_time);

  /**
   * This method returns the timing information when the DAT
   * Flits completes at the transmitter or receiver. User can
   * call this API to get the corresponding simulation time
   * when DAT Flits completes at the transmitter or receiver.
   *
   * dat_flit_end_time[] - The simulation time when each DAT FLIT
   * completes, is captured in this dynamic array.
   *
   * dat_msg_arr[] -This array stores all the DAT message types
   * for which the corresponding end time is stored dat_flit_end_time.
   *
   * Returns 1, if the DAT Flit exists, else return 0.
   */
   extern function bit get_dat_timing_info(output real dat_flit_end_time[],output svt_chi_common_transaction::dat_msg_type_enum dat_msg_arr[]);

   /**
    * This method returns the timing information when a particular RSP
    * Flit completes at the transmitter. User can call this API to get
    * the corresponding simulation time when RSP Flit completes at the
    * transmitter.
    *
    * tx_rsp_flit_end_time_arr[] - If get_all_info member is not set,
    * this array holds the simulation time when the response denoted
    * by tx_rsp_msg_type completes. If get_all_info member is set,
    * tx_rsp_msg_type member is ignored and the array is populated with
    * simulation time information corresponding to all “TX RSP” Flit
    * types.
    *
    * tx_rsp_msg_arr[] - This array is only populated if get_all_info
    * member is set. It stores all the "TX RSP" message types for which
    * the corresponding end time is stored in tx_rsp_flit_end_time_arr.
    * If get_all_info member is not set, this array will remain empty.
    *
    * tx_rsp_msg_type - Denotes the response message type for which the
    * the timing information needs to be extracted. If get_all_info is
    * set to 0 when calling this API, it is required for the user to pass
    * this argument. SNPRESP and COMPACK are valid TX response message types
    * applicable to RN node.COMP,DBIDRESP,COMPDBIDRESP,RETRYACK,PCRDGRANT
    * and READRECEIPTare valid TX response message types applicable to SN
    * node.
    *
    * get_all_info  This member is an input to this API. When set,
    * it extracts the timing information for all “TX RSP” Flit types
    * else it extract the timing information for the response denoted
    * by tx_rsp_msg_type member. Default value is 0.
    *
    * If get_all_info member is set to 0, then this method returns 1 if
    * the response denoted by tx_rsp_msg_type member exists, else returns 0.
    *
    * If get_all_info member is set to 1, then this method returns 1 if
    * any of the "TX RSP" Flit type exists, else returns 0.
    */
    extern function bit get_tx_rsp_timing_info(output real tx_rsp_flit_end_time_arr[], output svt_chi_common_transaction::rsp_msg_type_enum tx_rsp_msg_arr[],
                                               input svt_chi_common_transaction::rsp_msg_type_enum tx_rsp_msg_type = svt_chi_common_transaction::COMPACK, input bit get_all_info = 0);

   /**
    * This method returns the timing information when a particular RSP
    * Flit completes at the receiver. User can call this API to get
    * the corresponding simulation time when RSP Flit completes at the
    * receiver.
    *
    * rx_rsp_flit_end_time_arr[] -  If  get_all_info member is not set,
    * this array holds the simulation time when the response denoted
    * by rx_rsp_msg_type completes. If get_all_info member is set,
    * rx_rsp_msg_type member is ignored and the array is populated with
    * simulation time information corresponding to all “RX RSP” Flit
    * types.
    *
    * rx_rsp_msg_arr[] - This array is only populated if get_all_info
    * member is set. It stores all the "RX RSP" message types for which
    * the corresponding end time is stored in rx_rsp_flit_end_time_arr.
    * If get_all_info member is not set, this array will remain empty.
    *
    * rx_rsp_msg_type - Denotes the response message type for which the
    * the timing information needs to be extracted. If get_all_info is
    * set to 0 when calling this API, it is required for the user to pass
    * this argument.COMP,DBIDRESP,COMPDBIDRESP,RETRYACK,PCRDGRANT and
    * READRECEIPT are valid RX response message types applicable to RN
    * node. There is no valid RX response message type applicable to SN
    * node.
    *
    * get_all_info  This member is an input to this API. When set,
    * it extracts the timing information for all “RX RSP” Flit types
    * else it extract the timing information for the response denoted
    * by rx_rsp_msg_type member. Default value is 0.
    *
    * If get_all_info member is set to 0, then this method returns 1 if
    * the response denoted by rx_rsp_msg_type member exists, else returns 0.
    *
    * If get_all_info member is set to 1, then this method returns 1 if
    * any of the "RX RSP" Flit type exists, else returns 0.
    */
    extern function bit get_rx_rsp_timing_info(output real rx_rsp_flit_end_time_arr[], output svt_chi_common_transaction::rsp_msg_type_enum rx_rsp_msg_arr[],
                                               input svt_chi_common_transaction::rsp_msg_type_enum rx_rsp_msg_type = svt_chi_common_transaction::COMP, input bit get_all_info = 0);



`ifdef SVT_VMM_TECHNOLOGY
  /** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);

  /** @endcond */

`endif

  /** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /**
   * Returns a string (with no line feeds) that reports the essential contents
   * of the transaction generally necessary to uniquely identify that transaction.
   *
   * @param prefix (Optional: default = "") The string given in this argument
   * becomes the first item listed in the value returned. It is intended to be
   * used to identify the component (or other source) that requested this string.
   * This argument should be limited to 32 characters or less (to accommodate the
   * fixed column widths in the returned string). If more than 32 characters are
   * supplied, only the first 32 characters are used.
   * @param hdr_only (Optional: default = 0) If this argument is supplied, and
   * is '1', the function returns a 3-line table header string, which indicates
   * which transaction data appears in the subsequent columns. If this argument is
   * '1', the <b>prefix</b> argument becomes the column label for the first header
   * column (still subject to the 32 character limit).
   */
  extern virtual function string psdisplay_short(string prefix = "", bit hdr_only = 0);

  //----------------------------------------------------------------------------
  /**
   * Returns a concise string (32 characters or less) that gives a concise
   * description of the data transaction. Can be used to represent the currently
   * processed data transaction via a signal.
   */
  extern virtual function string psdisplay_concise();


  //----------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived from this
   * class. If the <b>prop_name</b> argument does not match a property of the class, or if the
   * <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1', with the value of the <b>prop_val</b>
   * argument assigned to the value of the specified property. However, If the property is a
   * sub-object, a reference to it is assigned to the <b>data_obj</b> (ref) argument.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val A <i>ref</i> argument used to return the current value of the property,
   * expressed as a 1024 bit quantity. When returning a string value each character
   * requires 8 bits so returned strings must be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @param data_obj If the property is not a sub-object, this argument is assigned to
   * <i>null</i>. If the property is a sub-object, a reference to it is assigned to
   * this (ref) argument. In that case, the <b>prop_val</b> argument is meaningless.
   * The component will then store the data object reference in its temporary data object array,
   * and return a handle to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of the component. The command testbench code must then use <i>that</i>
   * handle to access the properties of the sub-object.
   * @return A single bit representing whether or not a valid property was retrieved.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  //----------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow
   * command code to set the value of a single named property of a data class derived from
   * this class. This method cannot be used to set the value of a sub-object, since sub-object
   * construction is taken care of automatically by the command interface. If the <b>prop_name</b>
   * argument does not match a property of the class, or it matches a sub-object of the class,
   * or if the <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1'.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val The value to assign to the property, expressed as a 1024 bit quantity.
   * When assigning a string value each character requires 8 bits so assigned strings must
   * be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @return A single bit representing whether or not a valid property was set.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  //----------------------------------------------------------------------------
  /**
   * Simple utility used to convert string property value representation into its
   * equivalent 'bit [1023:0]' property value representation. Extended to support
   * encoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  //----------------------------------------------------------------------------
  /**
   * Simple utility used to convert 'bit [1023:0]' property value representation
   * into its equivalent string property value representation. Extended to support
   * decoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * This method returns a string for use in the XML object block which provides
   * basic information about the object. The packet extension adds direction
   * information to the object block description provided by the base class.
   *
   * @param uid Optional string indicating the 'type' of the object. If not provided
   * uses the type name for the class.
   * @param typ Optional string indicating the sub-type of the object. If not provided
   * or set to `SVT_DATA_UTIL_UNSPECIFIED the method assumes there is no sub-type.
   * @param parent_uid Optional string indicating the UID of the object's parent. If not provided
   * the method uses get_causal_ref() to obtain a handle to the parent and obtain a parent_uid.
   * If no causal reference found the method assumes there is no parent_uid. To cancel the
   * causal reference lookup completely the client can provide a parent_uid value of
   * `SVT_DATA_UTIL_UNSPECIFIED. If `SVT_DATA_UTIL_UNSPECIFIED is provided the method assumes
   * there is no parent_uid.
   * @param channel Optional string indicating an object channel. If not provided
   * or set to `SVT_DATA_UTIL_UNSPECIFIED the method assumes there is no channel.
   *
   * @return The requested object block description.
   */
  extern virtual function svt_pa_object_data get_pa_obj_data(string uid = "", string typ = "", string parent_uid = "", string channel = "");

  //----------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern ();

  /**
   * This method returns computed CCID vlaue as bit vector for this transaction.
   */
  extern virtual function bit [(`SVT_CHI_CCID_WIDTH-1):0] compute_ccid();

  /**
   * This method returns data_size of the transaction. This should be
   * implemented by the immediate derived classes.
   */
  extern virtual function bit [(`SVT_CHI_SIZE_WIDTH-1):0] get_data_size();

  /**
   * This method returns the data size of the transaction in bytes.
   */
  extern virtual function int get_data_size_in_bytes();

  /**
   * This method returns the computed number of dat flits required for this
   * transaction.
   */
  extern virtual function int compute_num_dat_flits();

  /**
   * This method returns the number of data bytes transmitted or received
   * on the DAT VC for this transaction.
   */
  extern virtual function int compute_num_data_bytes();

  /**
   * This method returns the computed dat flit number that contains critical
   * chunk of data.
   */
  extern virtual function int compute_cc_dat_flit_num();

  /**
   * This method returns the computed dat flit number that corresponds to the
   * transaction's address aligned to the data size of the transaction.
   */
  extern virtual function int compute_data_size_aligned_flit_num();

  /**
   * This method returns the computed critical chunk wrap first ordered dat flit
   * number corresponding to curr_flit_num.
   * @param curr_flit_num The current dat flit number of the transaction.
   */
  extern virtual function int compute_cc_wrap_first_order_flit_num(int curr_flit_num);

  /**
   * This method returns the computed data_id corresponding to the curr_flit_num.
   * If is_cc_wrap_first_order_flit_num is set to 1, it implies that the curr_flit_num
   * passed is already computed critical chunk wrap first ordered dat flit number.
   * If is_cc_wrap_first_order_flit_num is set to 0, it implies that the curr_flit_num
   * passed is not already computed critical chunk wrap first ordered dat flit number.
   * @param curr_flit_num Current dat flit number of the transaction.
   * @param is_cc_wrap_first_order_flit_num Indicates whether the curr_flit_num is already
   * computed critical chunk wrap first ordered dat flit number or not.
   */
  extern virtual function bit [(`SVT_CHI_DATA_ID_WIDTH-1):0] compute_data_id(int curr_flit_num, bit is_cc_wrap_first_order_flit_num = 1);

  /**
   * This method returns the computed dat flit number corresponding to
   * curr_flit_num when the node does not support critical chunk first wrap order.
   * @param curr_flit_num The current dat flit number of the transaction.
   */
  extern virtual function int compute_flit_num_without_ccf_wrap_order(int curr_flit_num);

  /**
   * This method returns the computed dat flit number corresponding to the curr_flit_num.
   * If the node configuration tx_ccf_wrap_order_enable is CCF_WRAP_ORDER_TRUE, dat flit number is computed by the
   * function compute_cc_wrap_first_order_flit_num.
   * If the node configuration tx_ccf_wrap_order_enable is CCF_WRAP_ORDER_FALSE, dat flit number is computed by the
   * function compute_flit_num_without_ccf_wrap_order.
   * @param curr_flit_num The current dat flit number of the transaction.
   */
  extern virtual function int compute_dat_flit_num(int curr_flit_num);


  /**
    * Returns cacheline aligned address corresponding to current transaction address
    */
  extern virtual function bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] get_cacheline_aligned_address();

  /**
    * Returns minimum byte address for the cacheline corresponding to current address
    */
  extern virtual function bit[`SVT_CHI_MAX_TAGGED_ADDR_WIDTH-1:0] get_min_byte_address (bit use_tagged_addr =0);

  /**
    * Returns maximum byte address for the cacheline corresponding to current address
    */
  extern virtual function bit[`SVT_CHI_MAX_TAGGED_ADDR_WIDTH-1:0] get_max_byte_address (bit use_tagged_addr =0);

  /**
    * Checks if the given address range overlaps with the address range of this transaction
    * @param min_addr The minimum address of the address range be checked
    * @param max_addr The maximum address of the address range be checked
    * @return Returns 1 if there is an address overlap, else returns 0.
    */
  extern function bit is_address_overlap(bit[`SVT_CHI_MAX_TAGGED_ADDR_WIDTH-1:0] min_addr, bit[`SVT_CHI_MAX_TAGGED_ADDR_WIDTH-1:0] max_addr,bit use_tagged_addr =0);

  /** Returns address concatenated with tagged attributes which require independent address space.
    * the tag bit is indicates the memory access will be secure or non-secure.
    * hence bit will be used to provide unique address spaces for secure and non-secure transactions.
    *
    * @param      use_arg_addr Indicates that address passed through argument "arg_addr" will be used instead of
    *                      transaction address "addr", when set to '1'. If set to '0' then transaction address
    *                      "this.addr" will be used for tagging.
    * @param      arg_addr Address that needs to be tagged when use_arg_addr is set to '1'
    * @param      tagged_address_enable when address needs to be tagged, tagged_address_enable is set to '1'
    * @param      cfg svt_chi_node_configuration is required to see if secure and non-secure address space is enabled or not.
    * @return     Returns address tagged with address attribute of corresponding port
    */
  extern function bit[`SVT_CHI_MAX_TAGGED_ADDR_WIDTH-1:0] get_tagged_addr(bit use_arg_addr=0, bit[`SVT_CHI_MAX_ADDR_WIDTH-1:0] arg_addr = 0, bit tagged_address_enable=0,  svt_chi_node_configuration cfg = null);
  /** Returns the cacheline address based on the taged address */
//  extern function bit[`SVT_CHI_MAX_TAGGED_ADDR_WIDTH-1:0] cacheline_addr(bit use_tagged_addr = 0);

  /** Returns 1 if the DVM msg type is Sync */
  extern virtual function bit is_dvm_msg_type_sync();

  /** Indicates whether the DVM address is Virtual address or Physical address */
  extern function bit is_dvm_virtual_addr_valid();

  /**
   * This method returns the DVM address.
   */
  extern virtual function bit [(`SVT_CHI_MAX_ADDR_WIDTH-1):0] get_dvm_addr();

  /**
   * This method returns the implementation queue concise display
   */
  extern virtual function string psdisplay_concise_implementation_queue();

  /**
   * Returns the matched flits of the required flit type as a queue.
   */
  extern virtual function int get_matched_flits(flit_type_enum required_flit_type, output svt_chi_flit matched_flits[$]);

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * This method can be used to obtain a unique identifier for a data object.
   *
   * @return Unique identifier for the object.
   */
  extern virtual function string get_uid();
`endif

  /**
   * Returns a string containing source and target info.
   */
  extern virtual function void get_source_target_info(string transaction_type = "coherent");

  /**
   * Returns 1 if the transaction type is either DVM or Barrier
   */
  extern virtual function bit is_dvm_barrier_type_xact();

  /**
   * Utility method which can be used to wait for the end of the all the items
   * in the implementation queue.
   */
  extern virtual task wait_end_all_implementation_items();

  /**
   * This function sets the field datasize_aligned_addr and updates the flag
   * is_address_aligned_to_datasize by comparing the addr and datasize_aligned_addr.
   */
  extern virtual function void set_datasize_aligned_addr();

`ifdef SVT_CHI_ISSUE_B_ENABLE
  /**
   * This function is used to convert the provided 64bit Datacheck to 8bit Poison value.
   */
  extern function void convert_datacheck_to_poison (input bit[(`SVT_CHI_MAX_DATACHECK_WIDTH-1):0] datacheck_passed,output bit [(`SVT_CHI_MAX_POISON_WIDTH-1):0] converted_poison);

  /**
   * This function is used to mask the datacheck value for the bytes having poison value set.
   */
  extern function bit [(`SVT_CHI_MAX_DATACHECK_WIDTH-1):0] get_parity_check_mask_based_on_poison (input bit[(`SVT_CHI_MAX_DATACHECK_WIDTH-1):0] datacheck_passed,input bit [(`SVT_CHI_MAX_POISON_WIDTH-1):0] poison_passed);
`endif
   /** @endcond */
  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_chi_common_transaction)
  `vmm_class_factory(svt_chi_common_transaction)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EuCfyBuBksSc8Xc8sPq01Y1bKf/wxlzZdI6BuTl/RVRVw/2TFyS0ksHLX+sdRl/j
nTw7qEtK0GWRZ/Xy8kJcaA1RCfcosY7p3Bc/VuzfV6b5R7S7NAnfA96t2M+Kiu/N
A2/QD0nu2ooW+KKQQj2jtrOcCj/CTj/5O9cJVx4Sk5Q=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2621      )
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
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
kkt/D+TV57YjJW7B61TrnzeyZs8fOxbnKG2uKRZpktXk4JfCJltVcW9fYdhwfvEe
uODKaQVEd+pzNRhBCjn4XyiirScKT4hkLmK1sx9UwO8nyfcVzRtqaC9P6KA1jxwa
ZRVS83WzpUcd+EXub3elxjnQb7OY6i0wogljTVISQEs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2906      )
8t5LRPlkirwev8q9AKp0PnThNoNlihjZ1TacQWmpXtIcqeJdXqrHFIJ+uBiwGZJ4
fih3XUYPHhZo3AGddkoJWY5B2E00ktAz7VODDALg4X30/5tmQnh8dUvv8U+kFVPR
xwsbKfyEiVFGJQdMGgWUtfNX6GKMXbhkZ6SsU2DQ8Sl/WGl72YofxOwNTMgeqC4N
cNqiAwPGPYEjQgDQ1SE7h1VjByMXG6wplrZs1Sqas/u6FsivQ8myNdtxjqLAdaSq
G5GwaMGlqtfh7+F4nztHkCBmPFnRLXDcA0wqpOaMkgC/WlNKx0FEJ9hcKdFGY2Y3
hGBTvIsNHfEF8ms0+o5trIR6GUWohtbt2VZxoZPmLpimScwBazh+Tf/iiYDcd7qb
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lSk8NbShOvXNmZLlKd+fxuTaHUJLXrS8px1jgXpcKkduAW9gRXQbBhNxmcyF/F3Z
wSHul7l1fgicq68d47Ni2B9q5Phry2r3Ki96fl/kIn+7SNl52ZzIa/4VBZurc89N
58WiNjL8+TWh2cAuwer5Zobs+qmOrctVPspkPh4ficI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5069      )
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
j0Q8T2C7qX+PgtEeCXd2BQ==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DWO6DVpHjidcIY0iIwCuUo+LN76a5wThOwKXszIGgr9E4KxNJi37VCvm1pxONv6y
hd9JMDS29a8cPnzVhuNZkgVTPvEFqqOrjn0iSguYM7pbVrjfUlsXzORM1J4uFEiA
egY0RpVvBCoKPKr7MlO63MdjAKm1M/YOxjKeqVsaAaU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 91767     )
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
I4MRbmSNbcckHxtu4eS/wA==
`pragma protect end_protected

`endif // GUARD_SVT_CHI_COMMON_TRANSACTION_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
g8pAxpdQICllSric5G/iTpWejSIMJxG4JEnhe8K+QqMYajBaI0l/Qp23zKHVNHsK
XXG4AC9CCniewICjUuLMk8SS1A6CzBm/E8AyDVcO/UKOiHYroTyqy9LNXIlAhX6s
pvmuDcfw2NhVr6+7Ft7E8Brxm0vmAy8phJWmbLdWcEg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 91850     )
kYWIvQGrHRbRws77Alno2UgFBbSNHOpM/t0sQrVF1xZpF8RJqQOHN3XdnMEzhpJl
bzkMxcwwW3e1zEmWe0P7iMo2AdsMV/PYSqaPUM8nl+NqOcgotKiabG17xlL0eVIG
`pragma protect end_protected
