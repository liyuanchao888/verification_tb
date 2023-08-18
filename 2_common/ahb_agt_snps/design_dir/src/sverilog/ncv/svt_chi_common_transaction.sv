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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
CHk6WFg2SL+I/IgBQg0QCBi2/4W2cfLyvW9KWvxUwUx0I7ryXwHEcMgN8ZqlZ5Kf
Ywlnyp7Y+aHT1Q1Pj1MD60Nz9xEvK5ajFBxT460DADGsmAVTi5/jZBNHRuYLU//k
feyG/1n78V1Hqna3LPhi7ApeT7ll5rQnEs4Tw4S53EtB52fbBPSC2A==
//pragma protect end_key_block
//pragma protect digest_block
xnjeev1Wm64B1JAGV7Zi5xPMm+A=
//pragma protect end_digest_block
//pragma protect data_block
ADKlCviSOxb5XPHpaCI9Xep5ixBKiwwzxNfJidBO/05QOQu6VmP/fPVsgOIinyav
QavD2RlqtNvRNDuKbe6w7EsQQOfzlGlPTc21IIW8r1AlP9AkgKS1wfTbamqkhVu/
4srT7ngHs8SEMXrmpezjdCetJn0Mb33tKFWdkRtPRpwHkdM/f4sL9RB32MB4eypq
ThW3RUTAKiPn/rYAjHoEe86cBm5G/JhMyH74DVD8YnAmDV3q9cvSuG6Cp6oi4geI
zW7rDXbcxILNWD03vQrF8f/b/dyrQTsUspQFwzUbIHsYctEFbxZ5NWDNuJErAquc
jFcmY33puXul6E47yFqmEA+KQ5QCmmkQEnG3PK/tOTprNXBFVP9bSjvDM4egkLbM
auwMS9eXTlfTP/SrxeOKvD3oR0REO5Bh90Xh5/VghSNRp+4ePybVMph6Lnk1lD8r
4vWJMgB4y/pTxVguQpYMtw==
//pragma protect end_data_block
//pragma protect digest_block
D6X4Z6NC3wwWli7gWsmgmepKaeI=
//pragma protect end_digest_block
//pragma protect end_protected
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
N5qG9n7JlKL/6bg0X97is98zuUKCQ5cv/k7GLmAj911WvIlCSVU2fUZwwDcm2iX4
RHos3If68f5BM53PGoW/Vk7+10bZhhR1wzjTp1x6MFP92N2LdvEIeqlrL1D10X3X
TKum8qCAn46f1tatX/dt1Bvq+SpvdawuDwctGQAP7PR/SRoXgVUGWQ==
//pragma protect end_key_block
//pragma protect digest_block
fR7lgbhi/b2qk5Seayb8CMrf49k=
//pragma protect end_digest_block
//pragma protect data_block
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
DNPSyLJi4DqGLG8EoGWJEg==
//pragma protect end_data_block
//pragma protect digest_block
zpbEtu5VzGpftbRJoxblnfnF+nM=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
571/eWDVJKEYPi6DbmzPukLdFxfHeFrWMRnjgBpmh7w2l9+hmWBv4RZs0QpHrzMW
qu1x49PYPweA9N0Ny++o+tjKQdsJYNTlvVbohhRkzndUM9W0Zo8VtBxUq1YmitYG
mnZ4RKTArVuscN8x1gQ16Zjg6zG4gtoekj6i78n5jCBkScK1Jw0YCA==
//pragma protect end_key_block
//pragma protect digest_block
LTUx9xfay+IRFT0exEYzyiEe9Xg=
//pragma protect end_digest_block
//pragma protect data_block
51kNhe0/4Pwc/rR8TyS22X50VsTzP3ioo05aG0O5warmdfpYX9wTHwLvqd2YhVk2
iVqUqibcyZ0aBgdvue7N/gBSaBtLxBBkdqXGwYYIceIB2R5VEfbJtRKoa+8hY+ws
4Ihh3sZZqA8O6WizFQ6Y40NuUCcEBXIUaUk8n82xWXyWCtiAI51al5PLaugb0QwI
tahP7WEqEgQWMDeI4pwaJc12qr+61hBiU9ERvwpaks5vUftz8Uyu2oAHw2aJJFjX
LQHFKS51YwLxh19M4dGuPe7EcTcTWrcik6kyU6ySVvkhxO0VYsnZg9x17C6eC5Ic
pLZrbSvHGWEJwe1Wr/46qfKiZtwrbpZDG2ojsfhf3ezNtD8wdScoMiWalaKlduld
Oq7iwbmtJycMeYSIb28bTnVQj9VT9iulvcntkavmUv9G6YJ1T0LAbnH4JQkGZZpQ
FrZLerWTexhS2K24jRCSjUo2pn1VJuIgwIZ/eUdWoBiSQSbW6A1LDw37mwVaeWu8
+mElavfW0D2jq62+kth+skJFeSnKv5q7XzDLntenrJJWegWWRkwmteO0JnK60AHh
dgiFCvtHIeFZvEfa/cN3WChhA2ZClbahfe0ridMYjx4=
//pragma protect end_data_block
//pragma protect digest_block
RrafKUGCNETRNLRbsc5t7+2yOr4=
//pragma protect end_digest_block
//pragma protect end_protected
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
wPNefP9JUn/ej33GpqY8ossx4vXaZfdkhj3HQjh/dadyI//xOA19YigYVIe9yo9a
nBsYLwO4+o6bDTfK3H3F3fFeCpM4UkHbKwJF2NnAAO6FotGx5BDcXvcNjNtQ2EIw
yDEnyRWJ+v9d1lwJNJOKIVBZ/tV6lITVHCZFjkB6Ee1YmrF8mYLKpA==
//pragma protect end_key_block
//pragma protect digest_block
PEcHWKfj+VP+ckMUsnIV5xXB6Vo=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
CAOX36Cg198NjcRPnS01vLWrqFk=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
/pSfstXTb+wR20m7Z7S1CjEJcbSmrRtEFq69/RgaTplB95uq5F57YehyRdZh6GRZ
gYuAsLks/JRV3VyV8kjuiHZCB0BjjkVbAB7UV3CkhNnc2idaiVOk6XkVTFbt+PwZ
byPy41lN0P4DtvpY/Tzl9jiJJ2N09mCVCfxbddVBuQsOelwHU/qbhg==
//pragma protect end_key_block
//pragma protect digest_block
GPDnuSsvOjibph0itlztUjwGxTM=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
kQgwzgWioda/ppHqP99QoDly7es=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CHI_COMMON_TRANSACTION_SV

