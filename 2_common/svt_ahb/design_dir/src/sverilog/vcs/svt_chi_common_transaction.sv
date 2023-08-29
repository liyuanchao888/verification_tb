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
`protected
AMC]68JK8+L-)Y9P73UR2SS^DQI5&W\\P-_TX]4>^S;639/QMFfO+)7gATATF>+?
>IUYdUXG80&-/$
`endprotected

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

`protected
/-^5V);fQSQKg#<U27gFC6fEZEgc=4,2c2WJP^-NG5[e?J\A9fLY-)XEf(eDeF3C
-?d^01AF3R5P<E0UJNPd#+QbV^U=D&RT?1@;OELRe8X0@E7J[:g3YH[L2(\.c?)3
-]Le[TI-fHP]X1G3f#;7_X;7:TH+C7:0MA+^C+G&)gRMM,)=202B#c?_f_WD,8)#
@-]#]H,V46L=.H2V4M?38:F0?EN@be)[U(RB(0ac5^?2Ic&7I=XS)?U8P1K[@+]\
^UEVQ,(>8>VM2(EeZ@@2,O4I^H#EVZbS2]GT\\K[5Q1BIB9&>d[9b75TEQAX>9^3
T?9(/.97gZg)c:P2I6P(fV\dW>?/bUbXA[<bA1C[9E(+A9NG3;)3(?S?DO7Z(7AQ
PeV_G8LEK3Y7RG\(:.0+/2L/U::W[,1aJ)Uc>XR3LYLPQU_RB6W;YVXd)cH>?UBU
GK&2bM5RE0BJ87>.bN?LH[c5[53PJ8;V=DI18MH6b[&U&T8T52eM/#?Vg^E_bJ.:
Qa+HC@U#L8:XFeW<XOfUUIXcP0Ga1,eca<XD]e]@L<2f(5[>\)CQa5E<CM:f,?-U
/LWU^f+L5gcb]B&1PfW(Z_?E+-CJ774,0.3.-9-M+TD5+-O4GCE-.#]JBfT1b:./
f_DC&e,N4P8d)A_64)Q?SIa=:R0^-D473HJ@^C_3g4;6?2[Y0PFb2Y#AcNF+L3N2
9@W]1L<@c5a[eKLJ?f#4+Y.ff^I3C578&Gab?JC<9<UMY3TJ.5N_/\gG/R_@TI)7
PFFI0aA\-d+2,2I=F>@^32:<R/)])H2b^1YKIVfb,GR]PFR>N;:6E3/.26E2DGQ1
1(EPE,Qb-8L&]G+.=I?LGFfRI;&B=FET70=KSdPOVg@a7_#H#c526Q6HVIR.U?.J
/HJIM1,bG2:WaE7?b=ALUQ7:(XeI9T.-Y)Ld3[S0f0cB0)Sb<#EMQ<6M(fA;<K^L
Cc,>W)T+@A.^#\gXcAWK,83J/Q6>,J,(RN-;]]B,+agD&ePg]:;)4E]9.O<aD0Yc
,RgB\^Y@?.fFJ6;K--_1VVGFC.9OZ&9_^gS#J]bbN5d)@_JRDK#DX__g00?@6#Z1
g.[IR;5,.;46]d?(0Q@fV9#K:-QTX&,<3?]VD4>7S>dM_>BPX7JGM(AU#b/S/]O7
aeY?R5FFT\f\+=)d.YT#^89UQ9,5)0&OeV;7PCa,)GMFY>0CMU?7gP<=LM]&;/BW
;K==:OI)5g:Me.G0\8YbB]c:=_#?>5c3@?7\Fc]NO@1[d?YBca8<0A\]S@V.77b9
3KAJf-S#.8T&#C[>.YaQPT&12?ZPV+PGYL?&?7J-1H;Gc4:]d.(M).&A&cJa4W3g
\81PEbK)3@0A4V(:(\V<1Nd-Zf8P)eXJ:;JELJBU7FeP(9ATY?e_2CcRAd).&+@&
C7J9-/P#JDeWOeT=CWL8#N[8+NSE/U1Q::;6?c?7AFa.:8P[3IV8F,Q]7FZ;M+3H
,@53[S+Fa<DPVXY\&(.F\_2BL+@:T??:1I5_fSgXFd_BR-NC4PV]=e7KSfN--\@S
G9HQ(HQOUNPMZQ5ZaJPBPM-Oc=7/VA82Z]R6NP./QNPe6.PNH#R#@AQN1L63-NBW
Q\GaQ,aeDD(bSZG1FO+T=Qe\>=dARa+d1AC?>4?48#R&949/_;a,]_=b<&4#K7g=
KA;6a,WHRBa;<DV(=T)\ZQ04V<O\:>^/REI0)ZQ>.X.C@b1<1ICR7&O014KYK9A^
@+;349^M^I6BL,GMX,(5WN8ZJ>?/VGFb5K90[5:W^:L7TDHO<Gg0bJBOdEE8<P/K
/=61LbJV7Q?76Qb:+gJ&3Ac),>Oc/<9c@E=VL-TKFEIY;,G)TW&_#eEP74CIL.._
^DFN+DT.f(Cb,C1Ee-4>dRJFBdT3]c\4_>?9PN-/0XfUKLQL6[<4N>QRMb=>9U_/
OZ4AW-#&I,Eb3Y5Oc8M6=3U.AC&]0NCc(>VbD^]6GH9QA-:J8.D(:NPAcO5_UO^C
HFG\P_7/<D72R1H??MgX4B_0]FV[\R,B8C9\_=U]cC^HQ;(1b^P=GJCY^ZP+PLUe
)G,K+5[>6JU[8R>>QM8c[FDDPP;6GQ;]2,ZL)cA351[WUe_Ia#f=C7#+/HUV<1gF
+5^e(9TX4RD/9S+^60DW6S2MA,MY_?ASS,B<W:#V65N-I618RD<5J/\2bU8G&XdO
c/\,=K;UbZc#;@Y_T_JCT1_N399f==FG6(,]]8^YOFL9)?J4)71V&c/=WJ_R?4&:
<N,UGC[7_:\-WDV<e7\&d_P6ZH=XDWBU08QX=?D8L.fZaMHF@W)\\;6fR-AcC\cL
0a-Hc+IGcU)C0Me>KU]ZKaASK.O+;\.f9)-_Q+Ze2dR,=2JD0Ff8>CKgMgA#:/Y_
\>]Cf/TPf3.L^fQ/@C-Q]35HOH7P2&Y8a&=ddI7_I++SedROB7Y8PNA2]Y?&_RVR
C]UH^2Yd)]g>/:CX#6DeN:>5W]OHNS<VB#&c/^+&TZ\)Y#D)9]SG@VC7b73AV,F6
c\_?<?&]2L/8];1NbG:-deHS_Zd8<Z0(W5gX>-;_RD1EVe_/[ZL=9gJU5&HbOBf<
9WW=C0EP]PL(DVa4b-Tg?]Y_FCBICX794#&WIN=5U]O-,KCceX-(UE,[-?.Wb#31
_Y/7&6-WSTNFSB+dN8HRX:dEOH:+)IL?71/#3Ca9@&VFH93,>I/6&8S&&1g,NJ^,
?RUE<gXE?c-(1@S;Z#>8YdO;[^<65U#^7b_KXMSA8@YO:UeYSWaJbN?K3);?(]WT
Y)DCL-GH[(,()$
`endprotected


//vcs_vip_protect
`protected
OPJ+&V9aB6H34J\9>/&I)@/3E&^)D31X(P1Ve+NaHFB)^+4FH@e47(^/&Xe1f8;7
V.E=BOTQ?0fDSJb^4.WZ+>I-V?_\,93EIe,U&d0YTCe.3-5F:aKB-:T#3-GBSU8U
cNR0:Ca>&.0.CW&H]N^M.#M3ZJ9J-gIH^J#8KR?G1-R-3TE,XTVPDI3;)=7\I?Me
b[AW(>&H:66Z3AQ6F;==d_6&a<KC^9X><]K&&3OOPMRB<)P\DL1De-Wf3Z<>=;;^
BbS6fI_UWFL<)-)2VgRe0W7_<IZeI&#K@)TG;,^<[0.&g40+VYV4U]E\;]W&K@O1
CW#b&Z4TEN74WTZ/06c.0[7_3$
`endprotected

`protected
G1e1VE<_9,<>La2eWYOEC:G[[N[1Na:g[g)dM098R?@Y7>0fJ5.+0)3<9cecb@6A
eDBYbK9=<90MNJ_BQ>\@FJd[Z&.OSC:M/\Q3ZJM69+EaA6U]U;5:-GB@+_.M=Z)I
PXE_1>b\:C/6e,/DNS<HPA#YN0c6-T5Md,ZF96c^fQ(:X(^2\)@C;C8Lc8C.bfHcW$
`endprotected


//vcs_vip_protect
`protected
e-XL_V:e468FY7]VUF3BL+NHe.7ZI86dJK1#/FH.&_^cVY,+0^>F5(I/RS(:K,,_
=a1Y=eb4Y>Q)2_&G;e;];F^FLQ8A&4^g9Y?/a.2>:JE-#+adVaRC;HfY/&/+LY<c
OZ(g5ZQOA[N>D_a/@FcW0D@G:[MDO4@g/WA]2RA?@&DLc^CMH:AA?5,R81&E=42S
B&I).R=e:^=><BYegV\a-./95Pa1)P&QQ_7\8B-Dg;68=F,S#^3MYQaA9K&<R:?=
:K1R[(./<PfUCJN]Z+4SEPae3_E6d^S#Q]]5>6@g^36?CT:RHIAfc&_AM:LSW4</
ddET91,6<QY\(,fdC1gP1L?6<6VNRL5#P)^=11G(#OQ47B,7D5e.CeROL=@Za3OS
&L)._JR@-3a5c:58@7D4QY;BA\78a>#P#=4e,I[[_FQ^62USI>f1V49CO<-XJ17,
g1I(VCT8+gO:[1@GPD0a:Ta+f2:IOND?Z@&bPC<;>.]+IVUQ[fEF+7]I^ffKgd88
3?bMHHb/I)^U+?A_K+[7>)JUd>Fd&I83NA:0GTYRKFbZ19BUa(/&6,^,@A5,>U&P
f]aC3V?6AQDH7[8b=g9#[HKdM3e0&B^5Ed8L^R&-2#cc:1;V1&PBeBa3cL^-aJ#a
ZeF7P9Rg,+4bHSZH],SOWQfB)=E;?[P?V1.&Qc#W^?0J1Mg\gL.=Kg:4Ac-BbfDa
WUP/9Z.TZ4]bdHQbHF_4fI7X0_-g5A_.(]@d.-2\6[U3C>)ZTNN++aCVbH8#b57.
?CGNgf_#@Y^-Sa?&\(+>>B-F+N4DfI;LF@HO4E>^6TJL(GEfR28W]5HAM\5V30,O
IJ_-XQg>M>KJ?L1.e&T_W+SQYd#JHD/Y,>&4G^e]\5ED3C@c/HgFeCA9;f--T#?a
RKa#N_:X@#S:WQCECWEMa3&/LICeK#IVZaOP@feXXJSRYQ[NOD,NJHKOCF7)gBgg
g1Kg9L,/#^K#QBOg4NNUD;AESSYGH3O.K7YW0gHb58(aYM9P<E[X=/HaZ2bIBT@,
63NVY+=D#OVX(W7(F4.V.A/JJg3Te&7A_<G:Aaf<4]feF[T/-=>Q:Wg>63BFIRNd
;=93U5[>\[E]B@QDV+UP:bB4[P3NZFPD)]gg@,=BBac33OQ(YYbCVPdEc/GBXRY)
9<7ST/J59IOWaZBT5-U2)f(K.ggT;B08UZU:433(<-P^-H<DT7_K/We6RSP\YGK+
6K9M\NGBHQ58A=a_bY_@Q^I:X1UXTIg/T5/GGZ8UA)1D0R5X(Q?b>DZReK1CbET+
M;K\<Qe744UT&;_;GY,8=DfAU-A2PLC>O>gW_1R-[;R;FAP)GWKZX9RD6+X.C/Zg
K2\^7GbgF.:Ca2LDU,J-]\d.I/.Ve^L_TcC8)W_LZNOHV4AbB5D2#+^=9XO]2gK_
b#>M<5EIR+2.L?B]CWS7KH1^_E-<=N,&9&(Z4)B8R8(.)2#D8P/D8K0T5SAdZ_4R
<(]9B;_+b6Je#EJ0QZ6HOB)F2#>@IC>M^V;^#gdYa[VO9;F97C1cB))Ud>D++2_)
gM<QHQ-a.VYWd6DV,aZaC\XQ9&80SA<>(8+XL4>Z)=8)FcAf;PT82Q)A@]?0B\_7
a#6_4-gB;;U,WeaN,g?e.g+gde8f;BD\56&@:Nb4^@\N2X(_Q&0e+KeH#;DOSS^C
3-696V^@9U^D3<(BEDQ2@+N(?KbV\4L_#dE=()TD#.N5-^a-#P58=\S.ROW+3H<Q
DFU>BcSOO=B;QG,6f]WeUF5??gKO2c4(eJ)g,]F0[@AB+H]DV8/;VfXND_[41R(Z
6Q3RW0V#DR(H,_\+J;Zed0@F0gF(S4)MPY@;1D8&&U5KLA;DE-X:U]6@\f0T\)b,
+Wd.Q:\KHa1CM@Y2[_L-W0YDJEIM<Q4WO1[#3/C<(f80>_,@M54dI.g@1OOR]Q=0
RRC/.M1,+c-2ed7Y22<8^KHWg];MB.D9;<SK^O)TZ:d+67\T>>:\[1MbO3#GcTbL
#=XM;^13TgS)f)7aJ3<<_/6A&=^-Y=,?PBG&55U<O<4?dAG/HU=;2P2QDe4)KU^+
DPVeR(\7=,Dd6bZbc:=MV:;CN9E&6JGT?>0a.g:4>^ed)[+.2(.DWgH>L::4ELX6
-MWdLCPXAbeS898WTCd-5bgfO:DV3Jd_e7Q)NJ0P>Q(,GE&fRYc;g:_;2XN(de3M
Q-SCbCU)[B[(<;DdS.;@H,ONN@@ad(O>)K3RA9c=J,d&:N-6d,b.9:<]LP091?;\
LR^NS.,^8(KK8XR46gY)SIW:^GDXL.?&UHJ7\?EAR0ZY#J<0Q>1@SdgZd8/MG<CL
X,RPA[-7RT([P5X1B--bH.#^/2/9de&0XefQ?NcE.F?)/C;[?\NJH7>62X^<XZT/
[T<0E&Y>2aC?K9@SY?]GBf6J6-[K5T.D8-B?]eaXZGBJ@BGB7;Y&8[afL_c?DB79
S-G:U_/d5ZCR;(+Qe[@D3\_A;6=A[>Fb^geK[2?]ca6PeKf<)_Wa,JKg\?gc>XB^
.AbbEV0TUPe)Z^:U-O/R)eaT\K.H)VB4X8ge@>+MZ_9JE,9?Fc/>dRaUNH[+5N6A
A-&]JYK(_>aDJH;aC9D=c;;;Y3X3W=^QVT)S=cFOO,.JPB.a06OH\1[I^&[H4-]S
U+<SI&DB,FQ+.F-;XO^2be5+ON&B=,:^-#;4)BQT)7Kf3Q+X3_eY+>Q.:O0]R8Z9
&eS3Fa=C5=ZD\e=B3cdZ.aaTC8RNTDX7@DO95eg4>A2XONM@6SO.21>ceH.DaSIX
<KccdJ@,?fFA[9;b;C?FZL2-[ON9KQGWcaXFaGTFdH4#C@=@TH-3MBXaK8cJ;>IV
V+_U(QPJ8,QOKCTT\Q_4ZMfLP)S9e8C#+3aeM&M]F#-Fe7:M)HH8S9IHWFOO/H#d
F>,]g9E_8=fIM5aWTCBbRJR,eUf[,=Re&ZBGW]<,SZG-c\7<.f2WOY>FKT:bI?F9
cFAC9V<V\F7Kf\W\<B9fFN)-?DYb=U^L[MH=884aM#6N>LJ6&5NBH9ZKAIf</QMJ
[A#S;3(6U:Ua/B5dZ@X4f(I/[QWC,7Ob-MZGMY^_K1;V)=gc;_2<,:<.R)^#?6<b
>OdFF(B=&RTQ0,(faaNEgL8[P0a><N)JTQHR7aKa=FIfH(0(T0Tf<#NAc:V2Mg[+
V1+\I;XK1EVaN,g&,(-R-XZPX3YZ0@ZVg55I)1a23M0HIfbPXRM+&.+K&5cM=C7Z
.[(.>X[:PXZ-UYHC442OMTe_K([.2@Jb-B;Q<VQH4U#\<SLM(6S?-NULd7b&VQZ5
9Veb@R)LC\P+KDXFN:4/9V.E=55TO\@W3<P2aIH2BJMHCU6JePV)?Zd;g#32XW<d
3I/IDM+eff.eSeS[1D0aHcLa2NaG[dM>15b#G_,G]33O>d9P4DHeO=>.(?,,&&)Q
BA)_e=KJ;6Kf(M=:CVTP6+KG2GZeGT&S,O2)eE>50b>e2M)LF36-AEIZ&N\TYeZ#
11K4X/;6^R<D5@SQ@45ET1f2N]BYUCUeANO;F(\KD@X9g]FgO:V#6#N(SLbNG#a<
>Ha]4P+>45_<+<#0,Nce>^V5[fZX-d#CYTPIY4?15)A[c<g(d0#AEONdKZ1B\d3.
cB1WOI4=f0d66?QW^]KU]dV@YRPIPV0dYV383_(DdUB0W3AHbH8:b^cO/J_&OV8_
^aNS73Z4;>@?dJVK(e]4D]I&1H1.:+/>39/+Y8XJ&6c)0N#86[,^(7(WLG-H</PL
1Y=_LC2W=<HEI#5YaAJN?=W2(AE(PS#&.1H4,PUG]e.N1#aV0=RV]IZ:bD+J-E5g
4P@#DC/KN(cMUM_F1b4(@A7DK.f8^M\a7W7.(e+K9XV_fUHdD7,Z=X0FQ<GF/PU5
A@RHd(5)4BI_dQ-&-LTEYN+=F2YF]EYb89T@BX,C03Z.,-+#[I;T0,,f@OYZ/EJ1
XB._14BgD,+9GA<2)82?IQ\-[ee,R_T0#>NcUA]1a3BQgLdM@(?_[-)1FA7UD0R-
PK5DH&cEZR&NCW333B,#DU2^IT/00(T[6ES>3I#D60OB=IGJ<@g?(RL\?>UeP:2U
;L.VU12?TAgg27.-T>eLUgP@[0I[U1(7YdLe72aMG#TBeR)-Vd6)g_I^4>91PT0:
.U5J?):C&c@D0+O+MOGE\NNHR8Z10TEf4U=MbHCBNKa46KQ/V=8[d;a.TNEZTdGX
6aTE?B^cAS9D<EZXd8@DW+AZF>YHgdD2+&U-C-c9GL6]L:?YH#a)K:]3U<]U:5gY
QXba^=_<Vg[LMe@[W1;<J?>3Z^bdK,1#gJL9?0/R7F+d&4G.)H#6FTM(gR:CMXJP
A\/IQ\2/f1Lc.?4-9,VNLg68&5\cODHV<5^?>Yg@S2:Qdc6G26F<(FZ.WeF(c?#X
,-Ke(=(&C\0SP?(c0+,\Y307]b;c#((G2;@?UA@eKBf(:6T=e,LSSGANG6P/-\.;
e@PT.&(IP+7)^R#RB0BdGSdIW)dG30N2&[YJ[S5^@Oa@8;^:2@;^/=Y0<+e-J6;,
;LBBAJ/N3CYC5\5Qde_DFP:J+M3NLOc.H:4&)?=OAYN9[?Ce4LV15:]8;[T?:1c3
IX:bf:[d#[dYXfHeG.Y0-A^^O(V4?<B^G4O_L#Sd7042fZ_[^g?eS)5T.&(90-UA
:V/RT8(EF^/XT.0?]F=_#T92VSGD30/eXOD?LfXEC1I>JP&\^;;G-LGbS3?e6:]A
cKQZ[YY\_aL2/&]2,[d/(-970DNZ+b=dO^7Z[WXZ04/5YFI.WFKE6\TK9//e&--P
bS25&cGZd;+bZ/EIS+(b:5a8@X-QS=WIbRFO[QOd.OA-6@RKZ#2?ZUTPJ=_D339V
PQWIOAE\-_5-8(G05#L\)N-bb=;9Xe-B]_5)-f6-.[fY(W4Q-01ZReUF84:N0)2>
<0B/S-_;8G#d)74cKa<(_CQ-daHf)GJS9:BJL@Yg2@T5c_0c:8=QMT>eR0<-U]P+
SMCff+,g:(AScZL;O_3eg#0LFAJ[4-S_:3;agNBC20W7YRAM2cR2QLTV7Lg:P1EZ
K>dXIV?B#Q-dGa[&F-e-33,I@e,aSf^]9b@H&A[STL<:C&RD]UN0bU-+;DeNOT;e
g?cN:,VU<5cW8IQNcKAKN1>?+HD210GU0f87;9EG4_?,8@L.9O8;B,g#E9F[31@L
2C^Xa\PTK8F44=ae,RI??39^cecfI8fT5EW;+&;f0.=MR68#)e).b:^GgA=SZ)H/
<^Q,03=]gKg34W7H8HN<Q27#5^XLeaP[EF72P/44)#MCG8,-1ICBg,NTZ1:I/9A9
fF&Vd\VIYPPG=W^=e5H>CX[RE+eXFMU6FQST-1FCH\&KUeX?DfgRWK/a<\)<.4Aa
e2Z-]M3X(G;D&Q1J;3;V=2<2U+>(Ze9,OS(2E^PeO4LE:P9GVbT3)L399bM7(5ZN
4#W\RNK.)AX.G5C)0JN\\?Te#=M>6fPU9B3gdF8@R,(3[>0_5+5<RGc2)O73G,,=
X-&L8+c@DG]3FUSba3ZTIP,JV;>(C3]-C1c+g6(X+J\UD1)gO->4,8ZK>.&&Q4EH
dPaDf8Ie_=^XL<W.KYe7M9_W+K&a/D7@E(8KDGOOI_7]XT.;X@X;<BY;X7J49LF(
RXJ,aILAYg)BO2D#TTR[4@3Z0d[]a,SKG/5.3DDPdF&J<=f4@)U7a+gSWGG\P7GE
0(9WWCGfVU8,MPJI7+A(cZ2W1d:f)[dIX(.cT:2@<W>WLWL54g7[_##gGKKSA?>M
@KK3:41_FdPVf,O5Y-gSN<:-E>O>XYO<DO8>)5_0TKGBY=]+VQNR_B2&[&0.LOT,
]^XP])Z:IRD4E[.G]f[,d>R_F0&bE^ER69&=3LN6Y)XbR[WGLa\HSQPe046O?dRJ
O5g\V(+QO+I_G0Z<PZ=X=eQP+278_Ua6F&3>ERL5RPOJV9-2/;CD_@6^47->P>WI
/U4@M&.9<3YE-G(egKFKSQM2aJ_\C;JB<3.4G7GL52QPBF:@R]4R1Q066;2+QKPD
P)a4#L\29M[GE\C5^M7.XdZ(]0[?Y#D:QJM6fTZ;</B10ZYGL/;^R=&@AR?1R<.F
[OPVTTK/_Y480SVVEC[K1Y:PTTZF:aQ>8N(9R15XIM0C.&3a1)7J1gVRNCO<d\b8
)7=C,FHI^4GbAC.BPRV5T?=c>e&gWF.TF)YX(#a7UWHOVXSWb[E(7g^CPP+4YFPJ
IZ:c^,beb(^F&\c0EAU#OUEMEcNQRT/O^<I55\eO.\F#;67SX,:/>;VJD#e=^^<G
)=]dX_Z2AaeQ3B8Q8IF3g\41aW2V6AT=9>PJH8:3#\S)4J^6C5@]Z/A>Y)+X8C9d
U-<I^E9A#:]6YQF-^.&AJ?7JB.bcAT9TU1U<]CXJ+ZJG)X&7gg39gb=a)(:3Y;H>
,ZQ4VE/cR9AeK#[SA>M7_2A7>#cXScWC5QAdP(.<&H@\dFVM^/)5b_4d?dH=-JEb
gRV9#JA0BO3V4MZB=F+Q_55/,^gWc)4U_X]#N1Q-39WK(IQ4;[5\2O_ZSNJ[c7PD
ABNXC/Q53>]@R-CM4Y/BbR>EHYX/\:^RUbdc]>5]H(gR[9-SF)cHD4MTf=Y>R0Qc
ed4XRaN5H5YB](+/N:6Y=3DXI_OVOR74Eb;L&0\B+MP8U+K_#K2:<1gead=DgH[+
3LBLc@=LC@AE?G.^#LZN@F]UWX_C3fWTQBAVTD985JZ[c]]9-0Vb6HFT;/d=<XH&
de_XeOR/V.J14\CaME.8,K3gB]7O[&PSDKGCVMD+2eJEB00fURW1bA.XML0Ra(I]
R^g.22Z.EJSDWa:8>N9Lg?+;N]:@OUaYN([A=b7PJ=Z0-f^AR/C-[]E@-MB]K?4,
K&IKH>@AfHADD7M&SW#[Jc63@e[TVNCLV\VG1/.4ZX-Z]?BTQ6MS@?Ta@BB];(I<
^>(NQ:C+bdM+V[:g(;UBPR6D=J6HR/1dQTHQ60),LK\\dV[Y#d@Le2<<4a>>XW.b
Q>CP-gYGNW;1KD&(-E(Z:g9L<XT1]BJIR<TdV-VCXFJHNV40VB-LUL2W-I9STT^\
R2b0XH#ZP?4Q1:DCPPaZ9+dUf?HVQGe]f_<TMF33c^FC]TGN_FC4,geXBM#0=D4G
SZ@b63N;D_Q2d-,B,HdX0DNY1S<H2SbR@DCe-gfdLJIWBfA?>[6KYX&;DJFURB.(
DK@H?eI5?_I1E48;T].S\\L1#T;UC2NOYRYX]XWZHHADR)E848=(;QSG[&>HQDMV
DU2+4SUg&d,,dMe1T8KQ1Sf2RB0C&<I>e7/IT/cGD>MN;J7L=6SSJ^T0##;[?N2)
D,aFV];2:8@3DGFEeM>Q0Qb]6fM:3JF&)f.(,W3YZEKWN@:D?]Q8Pf-INB#)4N<5
aAJW]a&6JO(;V.(>L4e,VH/5VUI0e3ZM1b]K(b?Y48H>E4QOc>QVa;N7=B(IBY/<
bg:&?VQ9fTQP:)CYGT32_580\VUfcQ\(RVZd69I[K58e4?g?#7<VPEN9K_d5>&2:
KX=X1T1514>KSR>I6;AQS2M;ECd0)VKH2:g5J_/NV7=#9T;ePNT2#/UZ@O5[Md,:
YW><JNIT(\GDQe0HAY2CA+-P;cRNPIA8O1Mc[5GWH4E?bE3F\ARa2WOcG0]+ZQ06
,fQ-_EHX+@gEMFg7F<1T//Af04.52>:&1JX<\2P41[^42Y?.N>?SK2;;&]:f;EIe
Y@UL.(<KMWL][\I\OKUEJ?d=6<Wb1/XcG\=(B14ed1GVOg^&,BJ3L\--AagUP?)>
R4CZ>RND?O<Bde55.3=)2H&]P/#0/Zb[@/)+E,O6)O6?:_UZDC<\K#DFC4.JR]5L
:^.SMf(a14O:&1TZ<W2LX@e)9K9-1TSc/EfIQC&:=I+a5bODf6BbFEH@5dVQOQ&1
2H@I:IdeG^XH,J-2)@HI4+1&VMO7:5AWf+a-,T3&O/#H(8QVE..?D_,ZL&JeH+@_
0Zd-^e>V+@G9g+\aD-312TI]56#-C\^?eJKB\&bE_7PHDReVa/)I-UTcQD4BW^fD
^3C5/d.Ac:T##])7W]U>b65-BgE9^4/:DY\IT]89LebW)CE:Eb4HV3JXG&9)S[5(
T8>3.Q[#?R);dQ@0\[M0DdPR1@GA(g5GNKJ6VJ38]cS<b?3M@>75d^_1W_?&RV(P
9:N5SGW:-@68WP23[9GFM-H]S9/@FMBMYNgOaO[L[V3/HE36V@g>(Y7-?bE;^NdL
U\E68W,=Y>S)[]YMBF.N&.(?X2)5T33Y,OI=A\\T[(T]8],-DJ,Tf-e(.H_P-cZ?
24VN)RWUX-T8E#Xd<+Bg(#(gPTTFECb#L2ZE5AfOQe-2#VfS4Ng8c];KDVbS-<4V
6gg0A54LP^?KdQMSbaU::JB.H/D.KF=F:^_6H/W/:68b5X32]Se[FeN6(FX7#DPg
2+C81ZA-LEd;IV>gF0e2QEg-3T+?H0OH_R(CK;[e..:P(+ZXf7)(QV:VK^eRH.J]
PSU:4)_0ZddfCS;>_\<dL>_?-0ge/<O,,_I\S:e7JR?85<>#YDF,6ZL5=6-/#YBK
8+..a1):M4W)[1EEWcTN8D)V@A4.^dRcg24W>\J?M9V7NQ.<@aG0T<>(K_)RXNH1
GZ&/=#)7K4@6+PdUG02f9?>@&#G[=LH[F\:X6GMOf;K>&^T;F]cCS\AZ>-T&MK0b
[:/3F3N=K+IA1OQa5g;TT(=V\X8O2RKAJO@U>OI_(L1V@32<N83)E:Wcf9N4N=]5
DZ-WA#<@6eRK#<A[cM)IFP5B8Qb8XW[DbRZ6)+V470dYU1&TGCHVYQc(3Z8X2VA2
R7LN)_724=X1K?+DYbg0Q<+Vc9fV)0Cggb&cILC^H==f?]1-&KUC9Ie8?M0S[,-]
a[TMX/QK>E-H8UaBY(LLT]\ZZS[QQ3B#1=UQ5M2SYZd^Q2Ff@<0C^^b:2GZQV]IL
Ba74_0@QZ8XDaS_-C6;U/b,QM9c1f1b[14FX5G^e]N^X/d/d=9E]B>&a/@2b1;^O
F_<K2MaDL;Td^(a[DO)+Z43HF<58g9ef\5;:3@RW]:\EY;M[A/K5S0+N_MIC>gHA
K(M<3EeD@<bR8BM@#9XXE-8I&A8Gg(ZAb#(abGe)8RZ1-3I(B0EE85c+>E_J([b?
.N5<SJ<G_\;^@J]+fZQZVU>C[,)QY5#P91[K:bMJ+Ug+5)NOJNSI>JIMNZ-:e+22
_-SSQK&A^Z.6N_&FK=2.9VMfM[U:R^VVIE;]UKOWQHd.DFM(D#^J\HU=9A7H>a@?
Z5_TVKDSUGRLK_C;KL)<@IbL-b#7^2F-XF+bUJf5[2N+P?^g:HLJDb[A,1PMB6SX
&Pd,NGa?7LH]?W52PY7ATAcacQdKLg9)>(L,>fd.d-^WUdg68MIUaAgdNM^:;23Q
HG1K2DA\OPDHV/5-4gQCGLEeV3IA3?)7X7)GeA^.g-4T.^7)28@4,b](SPQ4)HgG
WPaHd)Mf0=I3KPc&RZg=IIP/Fd#HM\fS5gW4D4HN_0;0f]e)85J&;29)@0JL8-.7
>1a;,>:JaSL&W9UPWf5HK?-;3-XIFG[1FKEU6Ef&.P>BI[GL[Y5T_PG;VY=9G@FF
?a3)L;VfP(>G@Y5QdNVB^(Y.gO)QY.2=gd6G>)WRTOD+D9#\gY&DF]D\?J]#B--2
-+^V5+baD[DfOC7MN?Q&O?e#bWEFKA&N+ee?9Q4cDK)W>>K<bUbgAVAC78?>0_@b
cF3fg#ATHb+Hg7G3dAW0/_IO6E0G-X/5T/2XP_(A4@A,7X=N&cH;Ea?ec:fe=8Jg
F3P2\=0\#]>\A;KZ,U+/Mf&SD&S6b,N8>)<5^N2@S51]5E);^)+Q[fPD@UO;AP\R
=P_b0QWN23.S-N,2+Zf5KdED3RL?g2NO=8ME+6O_6Q32@5:N<W8Kb3AVb;9)5cJb
/&?]d&D5.QY&4O=DH0DG._NHJ1fH,?LD1,I)+AVf\=AUN,I3-H@G\Z695P^1?\A]
IO4))M_S(F\@MCUWb:)265Z\-HDd+?#DYWYLb:O[FA.CU(1G[.^_afZV.fYLAL,Q
cG@Y14]MH?UfM^4D_MO1=ZH8#cYe.cU3.>ND>TAd^J741@45/gL&-H,a\dY4VE(Q
KZdL[OQ8TE.@5(,9&AS.SA/C6^N-a2R,S.d1/VC.HZ6/YO)K#Pd@(.<d,<2XL:]9
f<YEc;O]->BG6f-UO_^S3@@T-bFCA]a.1:(5YOIRGWQ.91/H?=d^b5EJ(8)aG9a?
5[0b\f8?>bBTU8>&6b4,E,^Fc)L2;g<0:]d\(R>6S6?<-@b?/Cgb=4EXDY[5D.,D
WMFG6&3O?=K;PLG@Z.,d6aK_WAY>^=&3Ye@Q:G,,IR0N,>=:bbKBJ:D@91)_WgJ\
PfCKG_>TQXUAH)U)(D9;6f1U+TMFIb,VeE(RNUd_0772-4>I1<U:bH<5@)XW8ZFI
]L2UdA7RKMaJM,5Zfb3#QYL2LTN-/7LOS\>DF0B(_T?,HXDDbSEfOQ\_4C\Y_D+^
TL1H8CaC]]HdVTg.&N0L,\GVQ^deg&U]b=U5Bg3;f(A9N_Pb2<>P0Ag4]9M]KCU,
6UE;E^N3-V=3,2>][6fR,W(^[:7XSAg@J@dV#7#/)V))EeS+XYS#8X\EFa@]U_-F
gcRW(b)VU_?C4d<]0]V#^GBga?/TIfS99)^+cL:&E67PJ]@(U9Ae&M<TWLbd#,;]
4<XcFLMdU/Ccg/<O[X(4de7HX]gK&L.?6A8]R=S^-16#a+Z>G>DVG(g;MM@<<O8G
L[7XbK/[L1IJE7d7HH0WcS),YPbAM:N=7\;1@T5=MF(990LVQ,a,N#&WRdES>O?T
?#P3SQeJ)_>:;>8U4-R-b.I#;V/A:#UI=7L1QGN-Ug4&JV+MXZW@01G12,6X7Dg#
GN4:9:>K<O_VY5dTg@BH;W,+]+)J>CJNg,CU8^7PdZD=HfQKW+e\cM.QEU;3b1JA
R,GI;eMB,79ebA4fW=C6:QY471gF3Z<(IY04+5Y:8#0&(bF9T<,(fC^HA7>VKSMc
KH<7B>64S9BOL?PX]+8P;.9eR).F=]^Z8141c=Z\5\0YQf/O9,./\H8@7c=NY3[R
.V)0:5ee1&M;-a&-(LKLaNCG18gFKS@?OKKf+][(8]48B3&68e)X?8Ua(72R3eQ7
^/bOC<@8L5c_EB@\EG(1;>^CHKaSg>GPJ_Ac15K;G3bJ0NaI;b[Y2Tg-+CIZY<)Z
17]?K=VT>WaKDS7K;7Z=YF]3SRL^JG:RRHa..7@0E4]BY;;DbP]5e[S5O&K>b=B7
;Te64;6L>U\PM[d3&&4dGe1#H^d:Q/dF-f6G+g/Q3EB?;@\B)^]X7JUY\.5R3,A#
[OFc@e0HN#/D:HSBgg.L(<+F^dEO[-UC;gNN>8&g4+DL,EM2YL_:gEebVJU-acZF
:JG;[<,K]9R<Mf-Gg>6?WECKHf4bH9LDJfZ>Q&)U)(/BIM[LeLT64HYKM5/V@f64
Aaf[L78AWdPd.Wa.X5L-g^&3W6S+(c;<aU2A1f3(+_0-H3)aBPaPY#RPX];d3/e@
Yea-\aQgEY[W_dP>;3X1[c5GfOO@Z]Ed2F<eJ?egAaAIW8&]K;c@+.47PD/<cTQH
Gb^=2>OL_+(^Oc_B7U]<^YN?gd7Dc-4NYE/4:D;31Q7:)/.cf8S3Pb71+^@DVd<I
YY&RZ0PK6@MVYR.N1/N+#.2ReAX5.BN?\Kd/L;\Z\;3IO,@2HfHd^GH\74@SR?_,
R;C@VTHXXZ#9XPEHH??]013HfcO15?eJ]8]JDO6@;9W;E>,24JKCXgLfM?=^f1>L
?1^+d>TS_gaPA,Y:IB#4S<3R(WMF-<dD?f4CGcN:Z5)J@)AV[g_cVfFT;0I,f(V(
T;:X]DD@3K_YaTaE2KP)4(CHA.O,dU<HO8B?U?TQ2/aVf\Q>L-3Q]2d]73JeRH^>
&=RVV#9N+;95(BaJ4fEU),Y]I]2(V\-?BA3X[M43PFb>)gT+3J@X.?HV^UT1UBNR
RF5ZUN.0gQCCFRV]PK>,K1=H:VfV5eV#=cL0U1^fX0VWCE>P9bVHF^(8?c,d.VJI
Y:24;^.<H.5C#e\XB1_C0H(>8IQCP#R;+SL^bbK4Z_B0:+[X7RMM+6IN78]J3TH/
Ddg@VR[JZ)a.a^XQ<N]bS>3c[IW:a(=H=N.D&4ZR+7a\@&XJf[YF/,_<_3C\.83_
REW3MO,O79#Nf<^#(E#C[CPLgZM+1B[1+BU3eOFgCZF/:bR9UdMS&WMWgG\W5f@=
7Zc)ATF>G.@FfLg@eR@GQD?A)VOJYNPc;d6D:05A.4L9aS-3T;J&D]^Pb8Nb@H?A
G3eT2O65UC#16WL/[JTYNEDc:/#0_e22LR2YP^SYT9a=>UcQPBJQ0_Bd<OPXRXUU
LgXMc8OaNd;N)LH=f<.V<acXb&T0\4NJU>4.@FUKYJPbOIKF@FZVSOU_b9AP_+QP
f+:6He;U3F.UP..5XD2&#;?5^)a9=,F9\<7VE&96W.T+a5:\^egZNAXB<T,-gLO9
(AaCJ,DfS.\Y9FU5C/?4+/>S@QAgHCJAIR9/_dJ[3_P/\T8L4aFG/^g89_\/CeWK
^,d&(-QYCH5dX(RN\=4d3\/YNM_31L1UA[>8J-H/K.Ie<;3bTTVcU=EI3VWL5e^4
=25.+RCAP/TF=e9cS_#GSJP<&cLTG^?^]AA&FPAgLR0A=UK>N3FN[d7Xe93E_QO6
dJd4]cP:71]7O]3IA=)>GC-LZ\P\Ie6^f\K5?Fd=BUad@UdTdZY7R[7,EASB??-C
^5S;PB)1d@\+bKKaQV]?7SXLccF9Sd.RQOD+O2F,466PX07)>[(#-OV^;8+PWU7b
0X@]D7M^<NF<]c#c42BF_;BDMI0Caf1V.IL[&_-1E^=7e1(g[#0FPC_4EV]]Y=<7
gXHK(].)A9La74P)UXb)VZ^b>gUF4_+R0J25H0#UEB3,Nef<YGBI2T:7DHM4b9)T
fEAE@K\AB@)bV[[B-f)@d.&9V[<F\MHA((YI])RQ?c+5]CN+\9C?T2H?fa/T)&=T
ZHB?Ya&D)46dMG+\X)&cOVP)K=UQOg0CMObP<SZ1_HM-bZ#Yd1>+1=W=JR=TOM8A
XT6BA_K3DUW<R#YF<U/CFdd\\?/VHBUR^UO6VZP4Cb/LN#g^H8S9A6K?@R/g7VB&
2;SdJII(FgC]6QCX/7JXaIg+\f+fb_TO@aB19]V<M);6Q.cDNC9-4ZgWM(WM.aRg
\<4YFfM=N0N@Q<\2I@IBHZC;2P^[HC/)K/SU7f@69F-ALP,;M3)0bF+WI-KbgVP6
.GH@0Y4>2/Q5.Y:\^MY/Z.]ZcS)1[c?R&aE^OB_81P=GT56]0]PcgD>e@5f1@[ZH
A.R?BAXKFMaPdRe[#0Dg:6;2NK)c=d?AA2740C?_+:DC6GZEbcAEV2UVE9XI2@BI
X,_TC:2R/]6-MH7@/92K#672]\.cUJ0REA^>UD1(S41N?DX=9A&K/_YQBC@FN]\-
7<5a>b6D0bFaP#DN<ZdDDOR_O]BAP-.e-dTDB@#af9;^Rf1UCV4HI3MM;RH4ODAJ
W2=Z?JWFSQe^-.J8;TaOU88HLU^)ZfQZ?7;G^cMY,/)a@6&XCU5CQYRFXS8)9VFf
H[YU-X56KMKR6aE0R51aBDf(=(JK)UA@WC,5CU-?]^SbKW^dB(JJbW7R5;c+S/.\
g6U:)-45=HM;E,AN1CJ5CbJ,ZOAQ?;/f.eJX7Jb8RTIeH7OLDca1fKV8D9F8(f,=
.,\1(d7#U&GbO@E+U5CQf.VfIIRX0KZP6WgO<U>c6YNOR>:gf)TWbY7=\5=.,81[
97B.F-a98]WYB:D),0E&)-;.&3=-W/[63WYG#VaM^V@c(fY;e=F(Z1K\:^T3Z3QW
S8&VgZ;0e=BU9TdJ2+)=ML:e(+\-]F@P6dA;75eME5gX3XV8)<OfHOK,5?#KMgU/
/TR4e,MB&4e3J>#gVg,])U194:1KdQIBP.:_2].<,32,7DZDOR#)>Q_&N(\2MI[-
+FW1?ASaN:)@:49f(MP;#4f<:Y(CC.)-M9^e@ROVRIf#.8K69?>XDXC1/c^GRO-D
:He5B(J)6_W293;J69;Y@:Q\BPTcHPCFE/;7FTNd@5Vc0;+CHJA9+F]YKe(L4?C1
MMW?8QU4?DBA[dT,GRc=;6=.98)c+)L,X(.;fKPC\)f#RQ9K#80>]USMT+PL1-NR
Sd?)OFJQ6YAHCb3^P)Jc72()3B<^30SV\^;NVB1K?@/C0_>CE^d6M9^]_:_(e^^7
@;ARa(c4)Vb2=^EG1GI/4H9WbFgE#Ra_[GU9(\9KU/>Kd@-K?5Xa#+N_S?\73SH9
2YJHM97Ub,DSJW:59;5;YdMbAR[@^N4=:KGD.f1597F/K+KFN(efG=#)06/OX,cb
:5VYYXeaZV]afRd7X4J@;]@J:g(R7@.M.BQ3FZS8.-Fgb_CXgE@4O:TA^I.5[IQO
9V>;:E3H;+\.YK5L;#:R0<4C2S&([6.D[(OJEIJd_Xa:aHd;W@O)IQ[,W80TbJ3@
4[1759X9EKe>NOI#TEOeeA]P/4<S0<X0_?9D7W5@4[([]RWH96#KR7;^??5S[D26
#8g./WR&/5O=&QC_)K4HX?B<E6>:(<^<T\&_G(^eG]e0RMRYKaL.Z,c9WeaUG</4
&[4.+\H\@<,SCW^/H)0TBUSGMOff^+YICK/TT5b8,P>-Y(cE<:1+IIB/5MgL63E,
<UG?QCE^]VW#dKMIdcGa&@2L)ZF<#N4NH8^E>RfMACaQ9HKXeNMB4PEOHZA5b62P
;53ARd>fU4O/Y@-A-<1Bg]6Mc>X.d)VB>A\V/J/GTVY^S@/)dXIB)c1e?cM8fA>Q
[I0K-f4AAE5EgZ5[Eg+8QdGV?HcLVdg8>KI/.92,e[/&aU?1N\K,\)=SDcT\AAeM
X:[5+P2,@@9ZY[RMI:=_@=G+0O3;U2<=JdDL1PV(,IcL<TA[\I6_/-G#Q+R3S(PY
b?O01.[QRT.61\,CeC>Xg[bX9M]LB[2@[P=Vg8+F1A3]RGBE#Z74OHW8Jgg(6UX(
U#5NU:NbgU=+1^;c0<JBeC.(T5:[\[JCCI[X-gYJ7EQ.f8AR?D&^HT3(AT-M201>
[M/F^d[HF^-+,AW;PbU[S&3>;SE+XJMCSc+Ccc<#Ic+.2.Y;@[AB]YL),=37<1;U
C1?+0&Fc@2g\9a;78618&[3264M<91VZL>-DbeR2]PCXQ+GAH8Q>4WT3@eC3:Qc<
a>eTbTKb6^^1NWb&4\Y4&VgYY09Kgc@QbLL=:DI.>7AJ-53-(fEY+_VYgD0a,BOD
?J>,d@:D^/fM7Xb9(KaDRV:B,51g+,[=VT6MHRM8;\B96)X9=?0&HC?GP)5)3((V
(SYbc;d(Z(d>+,^U^Eb^95R]090DYcV6^#c^51@6&9_QJg93gKg&@YGJOe\[X,C2
99/>J/5@EG;87dH]>W?H-W,Rb@46-RcaJ+cY^)H+?W)FCU3/#g_SbJ3:A\I&#WB=
:8b<?O;F./\.&YD^NMC2g3X]L9=XI?,T;IQP7BeeZK;C0HG8,@;8dD5NKd9>DV+(
;dFQZ1Ec7G:]039;CNJI_f)#bON:RDgbZPa\0NY#-=WU>G)<OE0,=\(#Ta58M.;:
A,6GaZ/ddDEEB_]O<.S?<9@H])<HF]>b4EX&],-<L8,@dZg5GV0[7M?.5TPAN;HE
ag:=;gY9QB,d&4aDf9&\1OA-;CV5;QW2P)PAL9H?5G_:R3fA^@TbFHKE#[>b;8,N
5SI,Ef:Be6V\5(BZD/A#DDS>f76Sa7R:ZT7#R8^fJe)FOcJa>IQ1fWaUDOOPGf[g
DP:)^W@HACA\]9@1_JVaZ3O)@Q3JFX8((S;+=WZG_&A?8X=4<5/5TNQ&C0QA7aKg
Ze6cO_32&+\>MGJZ8-O5f4+f5D^aT<VW[NGUT+&U3(?T.,2.d<3c)?X^@17gZ4.]
.Dc13K^NY;;g3YQ=b4e3_<BE:U7E.FQ1N-a\-TXZO,LOHWJ4cFTN6>@8>aWOY3/P
2M&D(C@;/L9_@fD9_72-I#Cf=HeI=3^cB5PHa.#@O+VT4T@#ccV.9-^GY>D7cHdG
F,E2a#:L#+NQ?5H<OH9.HS)Z_fNIV43\H0J^Cd]GHX0/O_Td4+=DR(@+f88D6N[B
[D&JgD+J&XK(7DZ7eD:dc<H</0SB>bga_A[9N[KLH[\OdJ9X.15#XQJMO)d5KcW:
71X(@3V+A\FM1AK04<Ac=#bE7QV&)I5>0ZK^:>VZ2Y55H,>BRQe]K#_N8O@Jc;Z6
Y#(&WS#/;b;\KHf]b.[eKJ<3@VHb,?gU=F[Y020]8@Z4aLWbZ]DO_YK?91H#ddQJ
OLA-5Q\a\L74ZKH3XB&O\A.L>bP?,RF7ae@LOE8b7#FT.e?AS40LR453J3d)/DEO
Y69Tgg,J4HZX-DA(JD9M)O=F\X_D:HVf5D@/)G9g@H-:]aQX8:+4HCeCTH6?FE#]
7<V+b<1F-?^39aV-S<SW.Ab(ge8>#7#Y[,G-W9U+8X6_E:AO.#W>[PQHDOQ&Y^@.
e4aDJT8SISEJ=GceA;+dK+?GMK9(:-S#_?0:c5HB)WeT0/6\H9^Wa((V>V88JCGe
6T]=.9E:ZgDa]:S)WW\T-=E6LSQ-R+/,LH3,/POKf6:V05Q;#QVJ)d?]SX6FA[U)
S+M]eAY7,G]@(0H21T6ED;3b&Lae&GW?Nc]J;C>b=1)Q#\4F.AK^P>/;[:]D5c3&
4Z.NS,KMaIX#2O=1R0BLSgTJ8\Z+JHf4,J7.34Y8/\da:H,YcbV#@g7X=aX60@CC
Ma[:.VE,?RH(Y#>BXVAP/UJ:UD+ZYI?MF,a[fH\<[ZZ\7W;SB+ed;)8Vf52T;+GL
(CU0E6V2?BdJU:@/:)f#CKUUZf?F;HPC)g;adZeIR3&:O]]]6=dXf&@=Z4\.DR5G
4V?8SBYI8J\S5J\-/a?-JaZb70YCEf^A\eW@_=EEd[DJ,KQ4]0L3eJdL8?YBEX>J
YFf[;POHTg)?>I:A5<aKZ;Z4G<6bH.-6C^SQ^]8^K8CeU=9OHF&^>bII]+>.QT1F
_M(P.HUEUa,()OZTPA0:Y>I#KB,f&+S.V4J>X[4+Sa(D)]R7]5KYPQJEfJDg@H28
KN3-MG_OT@[SRW40OY\YFUW0^FO>1@&ZO&IJ_e63YUe#A;QYAQgWe2H[HH+MNDGb
dC36X5FPD^a_<:NMCR4Re8E-?BS,6:W3H_W-\G6+?2^5VKS9&+E7<(VPF<R,=,C\
b-S/.d>#OO\1-faD#>4.J,4c:=_HJO1F)AVA6Y/Xg7^DYV12Y;^&B1.P[KC#>8Z[
KO=5I?>5II&Q&YYN4/H0@DgLQ?f5XU6,UAEY-AIX2,)M:U.=1-YRNZC5W?O)W<ZU
?+6-(6_3USJ4I_1CgKJNbQ0(..1[?F=,86T8.:dL+5fBVGIYT^A,WYS_@73,2[45
bX1\O:>03#[I13K<H@E-Tb9b\RK&;PG;L^aV9T&0FNP54@VbZCFSIg9Y-Od]9@1\
#2f3GOO=ER:T+Sd9O0(Z]CY(LQHS=>[B#VLedGY#P1IQ],BI)R=P=OQ4Yf5cd5Ma
B@fXNWb@-,Q1dLbBd)?565>UcZ;:-d]TBP+d3(;/S-e,)BWMAF>7@W,?ZIc(L=bT
_aagZ8^X8_1A8>>aERb#dW_ONR:b34>8dE;WJG8PO1Pc56QLb6WEE#OLgA4/3]J#
-\)AbS(f[Me+AKNPAEEBN8fPL-<JJ+I/g.Q<J3^C@^3M2GK]Q]H#c#bDCP[,P/_>
5YS:5RJI-G[G-HQ6,IW9HRdXa-_6ZL:[E-[-abFJEbI#W]b6NaR&5dX^B_+b&BK[
I<S^2L#:-LF4QfMa:MC^Y?OEH4dNTcTPdBH53:I5-T^bF-HC^_+:BD6d^:-VaP\T
>1LRaeM7Uf6#?ce0:G/<+-[cTdQ1COQA&L-bf9Df7;+.E(d:LReOGOA):IGHY&GR
AG(US-[_5e@aN)J&YW0gXNe_,\2e#ef66SJWF>M3ZY3.M>eGF:Ffg?I44aAUdI,&
Y?.=R+Mg7G.&Cg<c(J(0.=].9,5>S_.(=6W3-IR_P)B5@C.8&O<M>S_7-Nd3R,66
@EY1:U7X?5SXEbBD<.LQF3__,1\NIT?JCB1^be[4?aH11&9Q4I_0-Jb-_3Q;H0W9
dS@19O;]eRb(0A@\Hga)DOKWS0(5A(BNG(9\B:)Z5H2)1?gA/9^;32BG_L+ZXEOL
HKKMBG(/1^4BfE=6L:;BYQ[,+S/gT)RbOZN;978eO:#Re,/D.><B-dC\5+9ZN53_
E&X7.g[dD9=R@GVK>9f@9+09?<e?RgZRAR[-]TO/GTQ=]O_62:WT1YZ6W1[:77La
/CBU?,EP7-A:DG?Z:/4N^T?McGe_W0OW5)T0<^fO))c=OG5)Q/daO7(EZ@1.TB-f
;E=Fb(>]+IJ?81JJY,A7cgabD)T^X.9d_:15+]\(L&a&Gc)1^R//f#>cMa4CCH,b
N7Hd7Q&-S,&JAZUfDH#NXXYZ[a+4T,\;W&A>;[/TEC&TcHY\(>IFA,U5+Z_bC8dQ
cfe3IC6>GFU-3L9X1T)4(G@b7,beKM^(Bc<9C&R4Cc-Pb8[bZVK9WSK[ZL&&4#E\
_A<NPSZ-V:F:T-,=3-edE0:gBdT([8#6T(42A&Eb^EX0H\.Z;2+g4=f3^C#4O16@
@SN<4Qe3(W1(VG460;68#UaGC6]V-)(8?FR#YXGJM6M84EUPO9\PHcYJe9]=Z7EO
5aM/^.G4F4ALM4/A5I:Ec.+5[,MQ6,[Te897e\-Z(5;[TZ1O&QM:PR/QdFbRV#g,
gQcS_Q+gWOA18L#e97Kc[8GMH>Kf+2-ZVgF7V3<Y(J:#a:\0PM5OHbXgKH6^PE?Y
]9?\O^9<[^[)_HR@2H&3XJ&b?IZU:,/32)B\Ja&Ve;KdIGEWEA#UW4FDRV>P0]VQ
N)68FF+@.04.CQ-ZgS0f0=;\1)&]RDeKQe?B[.aN:[/8BV(1T)(#BTAeR1Fb=2#:
;.Y\9+c60)>/EHYN._3\T.(GL(]NJTRJ,aEc=17X-=<66^&@<HdD_dY;a97IXW8V
A<YO]\UG9f==^W(-A2CK8:WPTKF1)@Y7b&97KJR+b,V&-7R>GHfKBJgH&RJ#T=P=
6JS[L@A]V[H:Ce?:3.].PdS:G&QL4V8AZL;]\&[1<N43L2#F0Y:VPc+I[e.T3C/d
(5=Q)BF5a@#ZVJ)WF1+E>]_P2]\eYfXK14DK,B&CKa^/Xbe]US)URc:?UdZ;^LF0
UZAb4b8/)VBH]>KSU.^X>@a^7C?KgNd1[6c=D)Jf<VRdR+0^5ZJ:&>)1NS)W^\R6
#9b\P.D;#&[JYVZQHc[d23a+#14QfA84a5\C;I90)6K([Saa(7JbKVRJNfYeE2?C
Mc?=U_d_M-ffHB4JBKQC9=Ia313TdF/LcY:\_DC;9G]d<.I.MAWY<TbgE4ES,UgN
XZ#IKBU+bO/Z;>T<PVTf)8KD@].Y\@?VaZ/If=C<#9;<d308#F<NL+:H7FDU+eCI
WA:2,N9?/UW:23PA4&OgVS>+#0UWbeSELT9\PL@YR=<XQ)J)QOe=Uc0@NZSg5W>-
1SUM(EWM:V,M+H(9&(#CT^^/11:K>,HUf5Vg@PXB>-D2N2M2+2(dV5<D@^aaL/dZ
eBH_F9c)Rb>\2NI47O.]-,\g0dJ6,If8.ef,6[I#)<<U_]T\<OX&>[faOc#(NHG0
P)-L4f.2J\TA-^eT[2M.:C-dX/.HY6))KEe-KWMb=/g6H5UFa<#GREUfEZKB@W&K
_N\^30D9^10AT8BEX7+L><HfFSPH,cKg[O5=F>.4b-_(Q4eU:;_PXd=IR9TXIgOY
0c8&MD9E4.1A:B@1>?KDVCY>N45PSUYF&dfY12a]7FS.f5G+<NA=_4.e]P=cU_M>
2EZ3X.,[//YB+K1V5N;/\668f[L1aUW[2Jb\1H-?0<[9DLRGTZ\SLRcYC4-Jad)2
^PS1:#J58Lc[[27&&[ed..J?@J[eRDa;)SK(#:O3OAY>\JS2EM@\g6G-^#LPIe_^
9K@CR,f1OM@Z?B,6_&G?D&7YJ+GF=/e\<F@KQ^fCV^W,Ug1<@MQ_U2)>J]_SM1&0
6XX_L1@JFK5IMRF<fSIgB22#7EHcM3BDIE#8a@OQ<aeLQIN@(^WD>7DBIYfH3BSW
b_8BQ[>5O;(M,QJV_6>dfdS3<A\N0,-YN;NQ1g/PR0+)LR<[F;^24K9PVMCY4S6U
WBK-:S,>_,R@2XgX(1>.N-d:eAHPTNDR^9=7=]YD^ce6NA^9(2S7--?DN/AcU8ZQ
#YE/ITG/8940J3;8>EV+>C]HE6X4R_?31&-&V_/Y:)/PHFT;fN?/-;eN:YD_ZVED
..?)P9JHLGL77;OaLH81>bBR>:,N1a50<^8YP@HD5/L>c]J85B<X.5D[8\=@Qa/(
.-W4S^)-e2-RfcU#d:DT^+Nee#6eZQcfc7c;<N_IELLT[UPe.A]?9gG(gO9DN2D2
3NI6B\f_]KMI<#7U:LW9HCfaVNV0^C2[Jf0KDYHg1[=.]5)9;P&,IGcP6S[B4c)A
eN4f]6:dVfQc3HK.>J-)F2,(Q/3HY>P]7>(N?X?[e?T,PKQ;a8B#b8NG89DZ,f/K
_Z9[;)_:X8f&F_EQg<3b2adF/MX(1&E.20(\BATJb:@3^B<.OTX+V4e]S1:J:_3.
a4UU_.)XJIP^UM\JW]P.RMB@^9c=+#Wf>e-T:LcJ2G.>P9^0g]=YW8VC;Pc?a:\B
J9DSc)II-(10]4a)537N>:?5]VfGXcZ.UVb<&IE;SRLIA96X2&9=:?+?NW#9CL?8
H7J]<]>Z60A3>:DN@9S(L-U+12eE6ZcbERLHBGESMQ/IFD=0.G-LJEH7&)9-]gX:
fLg/g:OC8SU0SF)1G,XHET7@R?;B][R&,BMCb1bHKE,11IMH6GDW4QgS7M.YGEQT
ZFP.KJIO2_gg@,.+d.K>6@E9FfO?ee,_f4]S?=RR9Y:/bQ6:J^=OI<gFVdaCBA&d
<.9b[aAXQY>fAVT:4<:&7A#b\34@]fcU_eZDd<X&I;B36gP?dbgY<De-1&4_g/NE
<6KPP^9I-e=B62;G?JVS2P)#/N8H32B?Z>Fg[/\dQ?OCWb15A^N?:P[PMBW=+G]#
a8-(9-QI#VVaONASI@>/QX/:bD3JW;7.)@9==-;886Y/&)/GDgY2CX^@dg\;aeTP
4O;V65F22?\O@/U7O9cYO7fV@N95X?I#E1?19fD;M#NWRU5RPG^e=H^QWD5#K8S6
Z[84-L,(8VB,\DA)FR@Lf28fg<^3V9TVGf1A]Fb@J,&5^?K.8/TD[1HE6RcaZL7:
&dXgePMZca=IE<fTdT-GQCY&V(=?=b?@=LEJI=^f?<S_cB.?Y?a&()\PWc(N:,9:
4dKD5S[Y^;[0,=[;4/4(a56SY[VcL[-2=;;@bB0QXbA&a9U#9NXZc)8UefMLTYK^
>^9WHa>K6??:EW&83GP\T_)C:]b+5MAfE2F..WM)8HL[+.(A^d5a[K4XedJ4KKWV
5Ee\NdBOJCFHF&V=IcKBL&@Db^Vf]AQ<&&gO[2B@+?HZ0fQgN@I>XFZPe/Q,[/UG
C.L<)<7(J0RH;Cf=3/RHN#0VFVB\2ZdH5D+8&9>?Ig=,/?GNdKU7f@X#cYZ/ZBY5
=5RC-GYfT9J>a6+5I5;>0A>#S\SY+K.E+T@2]C[:H=4B,7&]\fOAR>.02/@FdRG1
4LN4<6\0[4.:#a0MAA/aQ4(6DWg8Z8#FOO1&9\c\QL#]\O]W\Z6Qfbc0=S?6@AW/
6fBC^R5J).1SXeKZ4XH?^g>dUE[&<MJ(U)0IAK4(/2_0<DY,W5I2AGBfaUJMGLM,
S^WP9_;T1aMb5Ge4@>MLD7K];6f[\=ER.VO0&,6\((V6((V[:3RR#7UK4#Q:,@6f
L;.,>])d6O]Q(dYA1^ANWJ?;V#/bR\8AVT-c8#C9RF-cgODg3KNNd=34gC/MF6Ye
fNW7C?HW7#5V40eJ(57g65O:(^2U5eZCXfBcc20B;6f+@[gOXcTN\bIC^WZ7<.==
-#MFH1::FW2OJ]RI9&5^S4#D+M4dBY41,E>(X-b?OPDF0?[],6bNSXG=@>]eE]8,
I^MIJ1]c9.Lca_eBXf1\TFTXaY)cIXI2+T6H/B)cHXN_Ag7C\0d5g5JW#fZAFNSg
0^:b,V)b1XFJ,g)bLO=O>O.+-Y2KW<\R/0fQZYU>Y.dDXYe^B5I_c>@T#GCAFO2=
\b9A_W]dA:d1YXO189@_XKb;WXfdUWH#;RVFQG9P]TX3Q_.T\SQGc.(:W.^G.Uf[
K@Pb6Lg+66J-2+PYCVN=C4gOIbX/T]<,9VI^2Gd;Q0:XeBY=W&(-#[VMM<-9UV>I
:+[+1RME9HIV?J2;d--dZDB3JaHI]:J:fEbSC\HLcM=+\>:\4/>IDNZM@?0#1[(&
V([d6eKUeZ&F6YLA5LB;0:QD^.Cf,59>?-@He[KQM/IKFgY8#S_fASb;)M\6R_<)
cVO-^(7NNN9=8Y=<LGb=Y0TV0AC9@Y6^ZMH+W@);]MBg)0deY3>1(4YW)MX3N\1X
?;g4Z(&ULBO.G\dH5EG4aDK>\EWVT:)]@^_3&FdeGVcdaL5@2<6Da@WH(&HCXW^Q
g_BH4V@/\=5M?._KB:HPFZ42DG:6[I(ee;^/(a?+^DG#>?SS,84]B_gMT\bJRd;)
5&F+g,\(aH_S&440LQ/d3Q#?C9Y7gL#(0.(1]&XY,<4N:F2I;QHQW/5O#G#I#2&E
/28aJIOUEDF9-VMbJBP<Ra=^RLBP28;[D)-Ea,FNVRB9;:[/+?,=HC0feTAb,.EW
[FCdX[cKBcAe6,5N)00C6>6(0BE4e&:(c8Q8]ZKO/NXSFc70MI:RZ)R:++E/K.@^
P8Z8DP8P(]KK_Y4gSTQG?0][]).Y]0&^#_AT)>LM>QZ)&-E(T^<W.\(DY4fEK:;&
,3R@fSIBG#PM@K6]X5HY:5;Sdf&6H+Y#A4d1Z-2S3U-GS+LQa<V@4I01d\Fgc[d8
&5G2;&SLKN4^-:71CTLgLd^>F,:[1(g@Ea.5:[RC-cX2L>]&L5^Ab>W95&E^H2:L
[=M]3M#ULa[?5E-b0b#>:DT-;F@IS:QY6Ue8g+7==deeQLf(@a@T.7I2:0B+<;\b
-:=ZO3:9O)(OO\1L)UFW(6XS<DD^Mf)P:],+#]PdNRSMFf&bW0V+Wecf967e\-2&
+3fL4V0L./D=GR4#H\MG.<C)ag77^\=0_KC=/(/:C6MQ[XA<NFYC\<C&F#@I/]e0
T9+&T]I25TYX#Lc;bY3@Gb/[d),8BRZ.O(fOR>RIJ+8>][L1O@(P-Q5g<D.\XfU-
@cUT5bgSKG+4-V#2fMdSF[NLX^4U#V]HU&()R-DKWK35::R0cMZO0?[aV+I.LAB3
aOXS6PE2>2F\3\[XJ26VAF7J<S.2G0Iga3>)G#C?bM,.5;REdEaCI1e+fd1X,&D\
aT.1A#=4HU?N7G\K_LZ9\,_TRS\M&,f)#<^,J>.WGdVKP1)9PKg+D)X3181#cE@G
;B15W??ANU:Z4-&J1/CdN3P8EG8^.O02=FOJfVd<-U)QG/8Z.]5:g?_<X8TLR6e^
:8R)1TWZ]XOY).f8dEEFSN>3R>#ac9?(1)#DD]?6d)+7N9AUC6M?0BeIL+19]eR_
=NW<S-X;12+O]Z5f/@[4UZ).VIN+S+cGCfJ181g[KXVIgW0W#4:]44@^YZ9dD+P\
3;YUV8Qg<S/TJZ,b(bF.H:Sg_L8Yac3#eF6YKRfJ)1dSF<&4DQ=(e9K1FSA[U=Ef
;W@c\Z3Uc,&BXQ@&X92GYe_>I3K(P;ZbO\)OI+cZ?FP0EQI92)4U-#+/cQMUSA.F
FCYT].ZFgaJ=2QC<@R[[WYZ:-:b:CRL=CEI_Qe^ZG@S),fM2\:c,f#3I5g^A9VNY
X(1K0ZT:/ET[AUW(VAP3B2gY+7MY<QB+;/ZPR<f(CV?JF_0IaE&GPQYQ6.RCZ5gK
WGCT+E]Q?RW^VRcaF;-JES7I5<H=39d+T(eeNGL8ORTWC4;G&K.>M4WOWdB5+2IJ
]Sa[0K>A.=WWK.[(ZVbMG6SL9&aW^:@c[OOY[=^]L?ZgNE&FA=E+5/N:;0QDf+LR
B(?]1GPZgVcYc26#gb/N2>SZg+?4[;cFZ?V3dZ+YKD:58>X4MS/a=3?=[F<&;&cN
D=Y^QG7U2gG59A_dg]gW</<YU@F.9\YJOcL0A3/JM#5,YcA)NSMZHe-@7I+2e[T,
^[;,4\B&@835BV/NX]5/PfI8&.>_=<,NMe\;&WNZK.c2dF[I.9#@7[4d=Z]7MB@6
HOOS]=W?N&I^EQI[HCAYBGI+I8^U#ME0fZ3J<A0:a5MC<P+B0AN^cB>K3D3F608c
(6T@5A/MGI)Rc@#e?agT(gcZL71KMgZW9QQQc8.e-b;:RGB5L&<@(PH@35IOBEBP
cE0RJ(J;TS<(f_-\UZD62\cKX]U/b[gOC&7C)P;U1N\fUb3GA4:3ObZ(0,_SfANZ
C:gF8H6PBA,;^G=d^AQW:DT^D=E<>b1@G3a9QC+1(b,S2A7,ZX+_fRI(OOJ[,02E
VAM0D3K,2M=&G-[KSCcb@927,c-30)+SX[CJfA<6<JAGG#4Z2:dQ@F^WfO(20,_;
a<CMQTL5.F)=I1Pb=WfMCf:))TP7]C\aX(BbYI7g^A?=3,@?2U&7[d<Sg\NFfg^c
:AJVeJ54WWRgT7.2/?L+XVJF8>dOeRPUP0U/XW#(ZZKMVCA5D682=RQ-CZOJC=)B
T#GS[LSO.X)Eb?33Id8;4(C2F:(:.^-=_PL7#FCOP=06eL&8B=,1?3dE3d-,5f3&
:B[KE@c0)MJGA)aP[0NaH78INW+K7Ad8eZ_B,gR>9)X5]WQ7WC]SQWd.\6;67)c=
9P55TVfT_:-PMJ^XL1;B0W.>X89(KAYNXbfU<:8PBc^B3/(2=Jf=^IFVGQ-+PCW<
7XW)fG62C:8/6FdG)BC2&_I,+D\)e?,:SNOcXAZcbLF2N6V-1RbcD;?\9<J;/;.,
RQ(@+8MP21?cJ_e)&c[-(4I6S&E&?5^+Z7(-,-L&dPBV5DJU4QC,Y9N(BU7:\X-c
<B>c3^=(D,:FXZ9GK80]bD.2L=_4X):O[OA-SS4b==_a><:3b3eR0SLDe-aQM](=
-<dgMANgDW997&9J#O8,)XDCV[4)<,Ca)W8]2EGPL6OF,/,A3Odc)#.4B^V6g9_=
JfL5c7WV/3,NO7IYKUW;baE1ZWCD^TRS6YGY>ADF01/URFfYE=7^RO[EWAHa+_>K
(RXKIc5BWY)Mb36)&N1^DO4ZdKdG+AfI0YR7]CT]20<.?a1cCP((1.>\8P=Y,:<@
,[G3L4]6dKJY)ZdV=YG5_2/Bf2dZMe4B)L4eW>-?0YI,\2g^R,(,/bTGEaV3gQ5=
DDY@T&LL\ITV(2RHD-<PZg;27>&VS-Z#YRO?7c&Z?JVXYW>(1/;GcJ1V:H,&\Gd9
RBT1NQ(>8WNZDS#VVUdD^(9Af9?;&=6P>MgMU5afI-7R8F-N)0,d@Bf95Ud)VNcM
242DdS(<_,ZIB(SYY[J//..F1<eNNC9)#Fc)X)T:?:3FNQ@bFObZVS>)JBPePKa8
7BW_C=bVgWBY8cGJKFNHP(&JHSX]?];K7=_^gC-:X++e;JR70gA#\DKc]-JMHf0J
Yc@@QDM[<BRSIL=\6d;5X\:Bf_[(=8:]R,&QR\]F+-DL)4V>3DZ+:CY+AbOH;<Df
gfg:GJ1EA.S;W8<D5U2A.J,IIc(TDZZG</5>I+b-ffH4Y,#+)QW?G5AOF51&_KIC
CZ^.g7@FW[OY>0J=7QVg66a_/R(RB>4R)IY^_&Pc]+DQJ2M1#e0HI9W)29#Tf-+I
CP4/OT(L86YE?.4WQ&NTF?f=EY]aT-5M,S-cT/F2V\-+WV=^e\bM/d&R-2,5@FN=
FQ3R\>2\?/d16U[de=eIETT3]Q95G5]^O5+TWBK@XGO-+/AIJ2533IT32(UaH-#W
=][f;,6Wg=3](_g3\=.TD3XCY)^+]JLg_C^-?-]LBa-^EFg0PS(0-I>;::YEVeHc
U@0DZ4,M_?)_<SF_V5R(T+)Q<cKVge9gK?@&6RSZ9)gYXUI<_(I,3D+)9)W&aB6V
I@\^./[Sa<A[I.&+a4.2aYYLD;<029XD1NUHR\U=FM4UL5.e9U,ZeH8_+M^W-D46
M:M^?2J0HfKPG\1HDa#O@JW92a\T(gV>b^@N#:_>P?5D<X.H_LY^?e+Z/,:+Z#K7
BVYc5=AGJf8;]=8aXA-C5UE&NMKWfb]g_V)U]g@:a_3([\M=;5fC<UPgeO+2QI>N
6#a00A#.ZgaPH<DE[9,PWH6.HcG:_dKUe9D9gac=ZAXDE\UGRG^_E@b0H(X7)FL[
CHB/2^\/Se9VC_DSfeE^?cd2,d-?Z?ZL4g8BRdX(/4-Qe7;&4L88&FT,41-;g?\[
+L>bgZfV_eUD6>9QVS:]_IU^QcFGGT9/O]6bF<.IOHWaCf.[Fed1GVXTf[,g0KS.
+W6Xg5cW2^[YX..5cC.3PGI.fU3PF\.ESYIg&S@DZ9X.2X_21I2<&56PL7#>/E]M
XZINW@QK:1aJXYcG&TZ@;YMQFf_8a?ETde.@/)^Xb8YI>8UIcX?cH4bb8T>3;HBH
I1^KTD6E+.N&c5c/+^/1>)e=RY6TYdUH701#bEK3Z:>TDP^\IEBB,[bF=&GK5a2E
e3>3KeHZNV4TBDBQb_#T3WYT\;H;F[+KbKX5UI4GE#7>>W=1&IM4eMH(N1dJCc6.
)7PH./<^C/.bPW^,P.Y3GFSH/&C4.X6#A?O<]7c;B5f_NTV.38dbT[^a\&PeH[25
@&SO-ea6f1IILQEKKOI]]R6Cf\6O1QW:?.:4NJ,IH];+B\/G6/N:9a>1#Z[f,0D;
OZ9_:^.N[.6A,PL(E-;#W?AJ8=755LJX]M<8g/7EU^W&KYRF.:_3[:.M-C;[DL+,
2aGaIV2=,NfgA(?#_bKBP-7]V&b+6@2@3DAJ@M8@Uc-8c>@/&W0f#J=YDX31SCPY
::<efW-E.gRf3dH/cL_&a8,8f5]F7YY&W5AM,0.V34Tb<H@Hb(V<ZF;BB7e01f<-
OJ397+ANE).ZM=9X2/X4?BAVNDBE/F]Bb>1V=&2SeL@gX.HW0#)gd[NSccK-63Hd
6ARDWBMDPWYL]:A1XA5QP+7Z1]8FL-BW;2A_OI=+d#7(-UJe5O:ZJHN3#90Me.7K
U1#Ud3))IX7&8c-2/g)?eegVe/Cb.c>,@KDP/Y,O=9d<+bRPH8(.,OWdTMOOQJaJ
7\8McBc:8UO]10U:bQ[7a88Z9OC3Q<Z>dXZ<;]++@\SC?^:JZY>;XN>P9<-QcBQQ
]RWZ@g?L90cI3WEY++,UU-U&CWg.])M:AE\(GgOOLfcE)K3\/3)e+>723/JHQ<JG
@JDH,0-W&J\2.3^+C#bP]ME;fR2<gag2(@1_J;@U/-NAJ&D#,06g5e\B/f)I>R:8
1V-=T@LBaD]bMPHEA-V6MNJ\J?P]:eg0<NfgB^G-0SVe[<53YT:/AM^6Oeg_.\Q-
_VO5SFJS>2:>Q21MXAB-#X7O0N;@TPGWA?X;W@D@S_2.=VEcM(Y@H;7fNYdJ,&PE
FN\8]_G)gP5BUWaggP;51=2b2M]ZV:U=OcUKC)PEX0^FJ/eN9,+B6V?f0a,=GX8g
>2TY4I&.[_b,cV?N(R-[AF]AF_@ZaFf?c]IWWB?U9g4ZS?QXa#PX5W;9:O86H=T5
_<?[d?VFJ(+Q)VTRCI+^Sed-)AQ<5=+T&XU.-bbMI6c:ER=\VTPa&H<M_=#a;[HX
a;+,?Q8?XYOI[)f>;T:KD[M_?1Gd#4):,U6bA+=Q702\SbDHa.=L>ccWQb06PWLM
;eO5Zb0Q(KMPHPEFLK-P?Z3WRZ3Q)&BF)X;YTY_=0f(51Ba6PA57=>c6cPfZGG)e
\/6eUDPH;:-(FU01C?c;R3X?<[@0R#X76#81,>DD)?4BfA3BJ[(276S-EI.R]I(H
I[d736P4.DF6]XHUU7:I3/)d77gFGgQZWW?X=?[a53&HHg4EDBf20>XT8WYM]CG4
M,?4-)[NNK^STOO/6B__&=1@>T(4->Y#,LKaabVQTBE4B=NC/Qbb[,1,a:,-SCSV
3;F<&Wf>_N)GKFCQ=3+FE)C2;4e8g1Y_&Cb+?\?\SA&.#=1SO05&&+#_#,CKbI_g
Aaf3>e2K&./^L1(T]61D5Xcc@[^Z/g0Y@GEf&aBTBZ+[72(^>X<O2<b+-\eF(VR?
G^U:Lg2OJbd>)5^1YbUJJ.c(Mf_Q.A6[MX@[_#08=\VZ^HX54=X8\FP&?;18&W@9
eAY&X1PQWQG,JWHWJ1VMZK9P47ZZ)0Ccb#M?):Z0@0EZX&b&g+d2LcfU?6:HI[<K
7YBN<S+0^SDW1/aTc5TeJ\:](=ZH+&#+9.,1(Af&(BWfQ?>/RR(XD:#8a&Vd1L^J
&U56^/&,JU[U>UPQ@N?Z(72XZ3^KRG]?Gf@O_HL(Cgf(\1QHFH;8<FF\&@#H6KC6
Rc0\.LGDGb\Wc5EK)gJS@/IK.<JPI5)S>Fe+N0UEGMD>A2S7NL.#EB4gcG^[2ZVd
&9\6M&VB[/YVC\Vd:NJ=:C:#77B<B3QDge>e7CYT0\,fV?[0#D4R9BCM/^;gEJR)
#=I7cJS;KCDXGFYAF9)QN]BfQXZWOGMQfI2;2LHXL54BGYdggEW;;SEZe9#75??W
+^B;BN[ER4eG?E)T]_6#O&1cN4&TS9B#HG+&-8S@aC.Ag00UN3G-&cDVXWRA=W^7
FJN[,N6)d#\C2c00b0C6_85H,ECcaVPVbcHUWG8QX8#ZM_QVB7BZ++H?0A+R@UIC
OT(f]A+A#L0IAQ4OHA&/M9_Y++?0:BT2AT[0Pa+1YC[&P.d_;e@fIF-#0M@be?)3
]/J2/)b=684-,/;(@?.3N:&AA#5\gg;;#7-O_I?;UUHDA]Q>;3YE0E[^?&-7?G3A
bK2[gL/&c4-_(H7?^aDDdAY=[2Q5#X,#a/+a86\NF1aX-3:7e30&S/)?1-JPQD&,
,LL^Q5I;X/UY\.F7N9+f0IWW_CGY16AF/cY7aLXA>ZZK3)T67R-(LEag[TG1N6fO
4PBOGS(KK,\TB>gS6Nf4^DG0]Z\8;V\N.8cIeeLDPVe+43B0Le.?eF/U7BL,L/W]
EKb_g.N?PE<=]IQCaW0?0)2>V.HE\^eZ^fb&32OC^20UJ]^MYJ.9?\:T.8:eY:eL
f@CDP#-(D=MJ.ga]O4Y0DP-JL?928e0X-E]\O&]LXOMY2d\/][T\Ea&f_?S53bc0
FDO9,a[<ab[96ONZa?^YMU<^(^]^?8R3J9L&+-L/]C,]+SNN0?TR^f9J15G]X?5F
DfD9WRdV7)W1538g>[_KEGM_W#Ua)#V57CZZPMT6HeMXfF>RGPZ;KHWCRYQW9b,a
5<@f4d-WcNW_+fb^M)Qb^TOVgNKA_NDg,V0VRKF60#+Scf9B2bM0E&?Q:K4S4N@/
Q@-<ZL_V_g@E\-F>,[<D6D>J7O0@()MK1JU)G230aF2=)>f^<[BC[2FF5.A[-)[0
8-c,M0DSS@&Q]-Q:ZRS-\aZG+(eU:ZSKG+EW6_ZTSO,fAT5\.NA[I95BH4ES=V37
@e:g+647Seb-4gCd.0eDQb,EXge>EU=?L@/JQ=0]MaF-KgB+&.14Y@+B:fA7?9R;
Ub3/]2U),\L.[93bFA3gQ@\b.OPRgC8e2SH0C^0C_NF>Q?4\^e&?2eLPSEBM+&7:
@[dZ0EeRJdFKOY94B<TUDa-RKHKGGWJa3@52C0.E)<A=g.gUg\],YCD@1((VB>#e
VfUR]2]?HUUQJ[L>Vd=J@@P1XbC_b@_69BYM;GQ3Z6Db)8.PdVH-)]Q6FVUR.^]K
@dOU19,)Ed\2V)[e@bCGJ,@.&C3._:5-PgaR],PBKGRceI&^7+JR<:b0M#Yb-I9[
<6<4X,;9Wb?_LLQ8OUD#[HHgb^0I3Xe6Bg=+JcDg?cPSIY[04]&g;2/V2E&fF>?,
+=FYbL@,,G:-2X.AX>Y4/Rf_33)6O+L\A/T_d\db@0JN)2Pg4,(N0KO0S@IMO;A-
RSK,#+4)\gIaKA\&37U#<UNbd.KSU9L&^dQN>fPe=)g<FI2\]?C6+/[@6I+0a_:4
>/#:bHSaSY_==fcWCFg\(6^N_>3846.C9M_;ZN&FG]gK&X.+b-=0bcaKAP/-UFba
#66V#6\2\65,?@dd<J=0GY]NLb]Lf4S>ZCENEL80WcFeO_>9Qa,:Wf;2GAe@;.W,
H=SSdH/SSW(&X]V(#W(TN<760Q&;,Q6JIg&[1cRT\=0IYGTEV4F#e&VC8+81T&96
&#4\B@+]KHI(:/?=N,-@-b:2aeUKZ@X+DVSO8_EZ;NDe[4GCT?I:UVSWPE)gLUUK
76HH04IggA/Y@-1BeMLCQ#Q#ZM[G#?0UJ^3X16RZJG\IMPP7@MFLG/1B]3WIA8F?
bgW&RS9)5Td,X@fa8EeOJIHTWb637+,,af]/J(/2/4P28^FJTX3b77CV[gJd0f^T
(SdUB\#VNb9Rb=M4eE5f3fQb:]?\GTe7QC1OOP7fH@G:AZF)cK]gDI#->/(=B>(8
^BVA477eQ4/&J)@UcVTK\^))/A1HH4<V6)KS.^7LE;9Y12F4O^#9S/RW>F/_L\1O
KDgC^<d1.O2NB-GaaQ;V8bfG6VN>^6?;L5HX535SL>]2.1K]=?6)M@PX#fdY7S;@
CJcCQaQ[:W4WW&HUNO@9^K<CALbP:3/9?]RIe+1G\[U<cZ9A7M960b<@7@NWWaL=
Y5JP<6JT],#Jc;97W<B6-3SIFOKXX5473EY1ZZWSG>IA-T.3=IO8FR#L#GVeQM22
O^,F:83F7&NB>>4-_(WT&=gab-Qe/#g_XVSB6#/GX6/S8#?5OZR1OU(+3I&&SCF>
^SbO;S0XA&B:<Y0Q67cX8#.NH:]Q/B#KBC(B.[-_gP,I\SfZ=6TDFWPIWU_;;Od]
FLYS;ALEbSXeS,3-Fb:V)\)C)2AVZd;.-f5?O<7VaBSFU0>0fHC:-7]^_.#6?VXU
6d&UQJ&aYJQVdNUPc7@FZL6NCG4,I6fdKTOT;0JT8Ie1YdYUC&WC)=KfbY1MHAJP
T=b&\RAJOB\>T+[G88A<N_T^EZ7b?41B521;.cdP8S/89JB_XY3:1HJeGaPb?([7
,]/XKgM5Q9?0Wf.,N]]6<QLfMf;3e;Y)-UBS^f;dG1^/OI(TRb\(OA0T2<:g;HeP
U.]DIKJ\Y<ZMU&@e.6+NaX3ICIZ=eGb?La-(8?WC8W5b90.N?SgGTPE(7W)Z]eL&
N71We96G<\c,_gK4f0Ag.I?[LBeMC3C:\QE+?(<_@=Y4UR8Q?W@K3;e2\5#X)8)N
=?F1_>5E>c3g9)3Fa5FgU.S/]P1/_M+3bTfHDf9H@4bN3_O8c#7O,J&EQ8?<QMQ4
g/Af0VbVE2QVJYeY7919Qd.D0cD]]#c<EH@QAdEEJ+,g)<+8ObfQBa;^ZM45M2BU
MJ,JDbCa5,_;V>_:1>]QA=6@f,T+@^d>VT=P[#8@Z<-2Y//?A@@a_e;cb;Wd\QQ:
eXQT821^/AQ5TOC)&T[c<Xeb3Cf5P.4D1OcEAL\0DbO0,<?GM5\bcCICT/XSLfWD
JNM;J.LTNM#EPd#OD<30<C5D;2U=JVcd)EZ4V,9GGT:U,.D^W8N.RQ-F_-#O2a5:
bAA&::bBA;<BH76L4CNGedN2OF9YXT85_e/(R9+bM^D2EA\0Yc[ZUZ:cgbRE-(8?
>D_P-KQUR,,NfGD9Z75&B,2b+\Tc&8O5gJQJ7]Z]:[--W[G9)2]F]EH:GP5<9+]J
NJRM\5E>+7e(V[0@.^g7)/-WaZMCe\O-KC@-N>YR):)S.4SSe?8P[,OV]5ETNI_-
FSBND+#Yd_)Yc2D<,+)TW.Dd/Xa.\TDM>I6bX:(1KfTO0Q#)6N>W)][5NYSHG9)O
7.d&,2ZKK^#@=@MZE?5+f3@7WD8+CSNC+G<G_1/Ea\3HAgb97WN@K>,.]58)d-PY
&4XX3d#>R8H1S:HR7L9(gVN(3c7]WZg61=0CbL7B.gOCbgcDZI_=<[7TVP<V3\#-
+8Q3VbT3JEJ<;+g;AY_ZZ@]#,0E5&>,V7Tf4f6;#-g7UMcL#P32,c6B@;)</dXbL
bb2U7<La6W,]VK,a;[:+7MMC?c]eN9;_cK>_J7_B)U-V:K/f0a/9D29VH\YWLBIY
,0abY;V/-@(YU5gAAINXBaZG6>UQ9;&E[+A^W5gP3G=aQ7<1R7\gcP<MGg;P[MU/
QH+KB;BS-WaC1R4_A+bg6-?8Q?abT,,YL0S^>DW-WOJ>T&U\;LZ@.(>-VP3Sg>6B
I\G)+fIc\CMf+cWX:QU>c][;@,W5K),6Ygg@,A8^WSE_)JS=&&9CR,5bU><Q=10c
5WS)A[?^35[V8?EeO15AHfV_a[feBa-P.33]WP:gbPTbJ=U?3(TXJ#.a_aW5)A<a
97=Q>PX/#M<GQPUa91)IXKDd[aVCDRPA]bZKA=<;f[Y4^VKS-+f<BaWOM>gaWCD8
AD0M02B,g+\g.dI67Cc[ZJX39@4_)<S.QR(IJI&+,6XN:4IE4JKRH\H0c9X@/52&
:@)))AF?<1LF&3529(M9T51d0G8JS9&SL)=Z>T36\X5DMf3JS_5We#--KM:1/:&\
+9#d]HDc[AH?Z]O<HR:\J3R\&8QWI>[g>D5LEX9FAf.B-S86.BW[7^KI9a@9VX:S
.D46#8KF8gQT;G-Fd]b@@_4_Z+>E[10Je+@\Oe3K?I<AR\fRPdD4(W#K+:dScK:(
IT[Y>=Yb/Y(0d^_>=>IL#1>ca&-I)S(GMe5]WDeWXGA,aU)CYSFL?92eC:F<W3fJ
EYY?9ML/<IX.6<fJb(U)J0T\d3B1a8]a_@D6\X)>+eD1L8WKIFJWaONG<GKeE^O\
]61]=a1C).D&ac1+3-M1G=6]HH=R3TZ6-9?+)_HT\[7eIG#b2MB6MYTS#JgWN?1&
#X-:FQ&5?+FAP&Zc&_bIEe9/P@Ec=:X:;=+>ZJJe:OK3bY8X#KVJE1EK+/6:bP>+
C<F4H@e\I6ATU\Z>O7>\0:JFA12#.++]aM]7+T#V2d29L]S1)cAA#C+DL\NN/EdE
A9JU6I2;<J8&TH\9;?VXOUcPPK.=M6c;\\5RVcFQFZ;d/bGNR3c;(\QPW)KJM,^P
^KK9fON:&)9,?Q@JGOR38gg9?Hb.S1.+3CC,-K6V+;<5SVOfV62JON#A=UR9(bP2
b[C;RZd8d72+bM7V^cP5&4/9+V@R\.ScGVUI>QJJ/W+cESN:1GL^_#[IP6[cM:c=
P1J5#.]P]OHd?ZO(J490MS\SO39>;9HBFD:UJRSAEG/4V-d,c^9,-#XM+b_RD1[I
/T=URVcV,e]Y[)@0=&;2bIW&N8E2)c(cc<)P#ABHG[.2\/+DI\DX]C>F,KVL_YDM
N3CZ2)cU8_AE8&8P)X<?g5Bgf.7GRgC3DQAHeZb^M6L6?(04NR.2.H<E4RN@]ELE
dP4g<SBTA^6XbCdF9B4WV&bEC[XFN4R6P6SU^97f>)84O&aFSK(8BKT7#0?FF066
fYJC69@bXP7U0[FE,MOSLO_gAPT6bCUS6]ISEF8ZLMNfGJ<7,#?OQ7#[31UH.UTL
8f5U^V4D@BNdgF]1QJ))3TAY3=?86c-06R0CD.\00J>XPM^<b0;2)]PN0T^ccb4<
cPbX?UYQKRXf=c;0)G0_WZd,9c_I,U/\/]:-aPO113.)Y,&>AWd>-:AO7KU>=U@W
QA(HOY^ec031[D-;08U7.&gQ<-5bXVZ+de<Z=_aQQZGCdOTWU:=fGOePT7_97DH^
TS-OW^\QA)/fA_LU1gG+/AbLfQ#4#g=EG/3V;P5B9Z1WK?30\E4ZR_c,XNb/R51C
XJd[-Ld:.gQd_<GcK+c7V]H^:3B2T^QU.<cB3QO()-X(HQY^RYLG)@gbE/5)=+I)
</]O6\U5W)_2VX;5Ee7H?GYCTMRM,-BKKd4E-VAbMb957^8F59JM9)D[K:1:J7KV
g>92-M08-(_;Y7Z@&e(Td7UWP[_.\6.T2F,F5C7b7,8WINJX6@fMUbc/;MeIVG#Y
D=]9STV:D,:6&d0.+3B:3Lg3=B0.G]aNIbB#;0E&G-?9VUgcacW]L=AFHgV<]=(T
;B4Ke_P487#Sf2Y2b==7g-c2C7]_UV:d<#ZU:#UT545Z6)SbgCUQ7fDe>E.4f[DY
fP2N,A79[EPRCE^ES77>5P:?X8MCb&@>.XT^ME^X:93+S+A?>H+Ra3<XNSE3>R<@
)4dB>_;1aRfP-)3GFW@Rd;)SA[E(/YL22a&aL/8W^.f,AUXJ<EN1SDKIV[(9Ya\L
ZG>,ZEKEeO^>PbZJa+O5OZ)Y(d3DMEP3;0,[>dN<T?B#28XNB3XLB_DH^F)\RCTP
9E84+f^N#>OTI?IK[?Fb/0UZbc_OW&<H5_@^&dTU+IV)QU>OT:Yb/19\c&<++=/f
>HPCBa2WgT,_H,dG9^W56@e#;g02:TQU<DRP3J1a+ZaFeE0G<UG=U8J&I_4;E2c+
D\+:Z/A87D]3T12a3\F+?@?.KXR7[\D@PW\T.Q/cPBfFd69e;g=GMd(R19P&]QS4
=&=00_R&JX1EU\\<\B)&NOV,4VZ.FWIaL9ZS#U#4O(XX7#/3=UB[HgY_KDC7Q75_
Z?cQJ&aa\V.Y<Vb\-S1:N]OJ53/:[V;W99H2YQH-4g(X9?/P@V,XNZHS]F1YMD05
IVIcYT[fYL0Tg63;S;_MUE@cIEGWA^MHKUI&>:]:81T8UD=T?G9G1->eQ?WV8?00
48DEDXg9gD6M08/<?X:\0^W#X2Ya64/.+KeVc-W_TPHdJ73(PEES\0a6WE&Y5-6Y
g1FHXG4_Ib#I8D]@3&e)KTZ7@M3.g7^f>/dR:S298M/[@I^B?]d@ga#)YZ;S:YA.
6b#RS7fe<-(Q_<JL^2=M_0?6d0Ka&QI&MSW@<3c&4[IcI2CCMa@B9Wd,Yf4J^<]F
#;(</^11RQYUV\:KLY6R)HKD8;;cb(FaJ/#89-66=)@@IQ9@W^RA.GY,0fHE60H1
Fa\C(S1J152aa5H6P>fBF80FOK:KHS0A88WPDLX&e:XF(^<\3a9f-H\X8JUI6I6d
10_,G]GT\8S7SR4@1ZK:MUdXeM>&59HP(Z:U\K795#d)8M>ZESXS266EC8L9665G
f<TQEB69:)e<T85T.VF604?[e8:JWOB86B99NdLLgKG8L251cJEZ0-gTC7[WC.Lf
J+>aA5c8U.MS.ODM4,>4E:/e?gfE.QBeC\@J3B/6(54T<>d<6Q3[.?Y/g4D2\CIZ
9a^7]):QJ:Z<gMd(V=JN3)+KdWCH+f\ebZ>-FA9JdOY/87DJ<L2:#Y+66SgL+=/X
2ReL]U7HBa4;?1-EW97,[Eed1DcL]9)WV=#f6c)&CDVbVKVA[6/G2fWV,b.7)J3M
]/Mf>@5#ePM\WZ@_E)X:V?&-?_&C/:a+])W,HYRfCf79K,N1?@Ub@<a=DK96Y7Qf
:c_2FC3\3GH#C/VcC9?NU_.1>cG#dG76B+;<K[gaP^;#cOeaN&+c^A60Le7VAXA?
e:U@QE^6.\S;g8M7d5WT?cMFef1=#[9NR2?8(GT=1))P[TEb6L^b2=Z8A@I#.A@E
[R6_#WVE.9=4a=0[La[X4fTb.YcB.+D?+R9?ALgF_FD]V<e?]^<)+DT]AJX[#<Sc
WL7FK1@3&9OB#Lb7K-<IC+d^M\;Naf2<#-aG(9cOS^U9a:_@IN:d=5LcNB;:@R93
JW9=6JQ4##:VM:KTL=NgT_5Cc06WX]A@OSLNY7Vc<3?#XZD8#K7UUOB(2c;+:.,e
R[I_/91)P]G(gEcWVeEEaHLH+250GeR)+>ff=>IN7>NI&NcF0_4\Ra;M0edN0VT;
:U^5c/HJ0,(WEOe9,RU&#A6Z6BYZKL>J?3B=Ka,N++TdT5,Vb:U@PCL]7d[MPEU1
)cF:8cRbOP4E4-K2A70>TF,b:.@T\RPY,Q\4;IC=BQOA<B_QTJ4IIHK84<H>f98P
_S.5L1HI^43^?Z>0WITb+c-=YO23,(d4AU-+G-:YP;/),/GcReJO0bDK::25V\^3
HW.9&-98<Yd^QA,#4/T;=@\Z[ZKK;Z)Q;2TV&JF\W9T;APfQ)V6?eK6ZEI=:0J@S
J=GaH&JKA-d54]b]FS:1GS;WNZ/:WXL(\^)M;SY\C;CU7fVb9@>bW]g[A6F=#+#f
?-_HW\/?b/GU-LK#EO6)9X\A1.+R[5TS+=B8VJ+/^N+G==aQ>1#28,Z=gCO(b.UX
JDI<6&>ZSL56BKE71M+SJ0ZVV?R]QK]=JN\AR^_eCP/=0]&J88dLI3B2WMF7^0FG
AI2fb)C1/<T^cU9b;1D(NTN+@)e=\V7&JNe22;KS4M+-6,>RcO2K_:5NL]&CKQ,T
/QJ7R)F_C,c-B&Z?_[>)>N7L2[,UX7Tg.g7>D[O#BZ[I3>6dg32#RO1d?@39TA)6
3V,HCJa:;HS7XD:UWC[BF;b(F@32+->dDUEZJ;PJ-dO0QBdX&T;GR(&.=e<ZO@(S
#,/:\N,(#K+?;4A9_#-,3Qe_O[Y3=5ZSL4=PL-8.148:_CWBFH:KfJL2NST0VGf?
OZM1ZB2[2Q12L_AT^;2)>fY=7d@O9N0VMd_YggJ+VON-:9EPZX8b3^^HHAM^2;YR
?8-E_ID^1b7DeV1(YKGfRT0I+>Z/bUf6(]Z,/Re@6<-b[);?UBTBeUd<DJC\I79R
VMG=D^A5FS&Wc.3cSfM[V]-HKf,Y3]W,ZD^#RS_8P??,?A:g5a]5b+7)fW(c^E-N
K+8/&+a:VAMWgC&+D^FQd8<P2V\>d-UWU0ZCA.)7G[<E#cCY&LK1fDK0gZQQ&=_@
GDB6YG,3]Z=A^.c9PTe0K4][O,/814:HQ0A/g](#d:@Z;Q+(X1#YBQ#V<\JZWX>I
c7@.FZ,a6OO>HcRQZKAR;e<A5PM<BKb^#,EYK?EDA7?ZF02^-&B19O[1>TM4S6T=
3f8M/4bcdH)O@GU&-I[<FLM75,4Z6d\2#95ScfcI6:A.#MWJTB2ZC[6+FZ<d_WF,
c(=aEPCFB&54LJN=.KYA]YZ+:I2PUHCXLeVZ?]#e5^8GJDSA<V#CVE<<g54Be46?
cY,K+dT.E=#>4HLC_0?KG><VDQR_[eR<RMP=LT;_5Lb(,Of/bO7VJOcK.e6:OM)=
:LX.cJ,VB[3Z\BEdYg6^gZ]3-)cRB:2I,G2<T258/V,M/YUV#g6XNQ9+,6P,E;,.
#45DZKZLGQQWN/YFNc)QVdO[d0K<KSU6F4TCMN5HP\=5RPW\_\;[]MRBC#8V.^]M
a:IY@0dI#^<]a4GZa@JXdO&dPBFXQ7A0K>Qg7^V?;,SX,AYY[G@]#W5#?aC)=TXA
2cc356T^1(?52G[EH3&<A^c;]5XUg(J3<2eS^ad(Q]:16(eaI>4;b]K1F27CFU1\
f79cNYd5Z?Q04KQgM5+76Xb9HId-gI?SD>6YI<6YgfR4TI)X&#:E&^T^N2VU[_cS
[4HG?\2H;A.I3G22PKD;J.SLX14[gJ8a.6V(F?_).--GfB>08@(^C97+Q4<K7_E_
>P9+cIW3B=1BEK<SJF._5<TUK..e<W;bKB2F-DFY[X+J#J58Z)F@Sb;\:EJK\c[b
I0IE5@1@YWTd\AIGJ,0[A8d;:JJYZb^2Y4CaM(ZHI#Ad#/RaL\OUW1M<(cWbHN#Y
H(=QE@1E#347Bd)0TfLfV8A,M&eWV25:5@F?cBTT>D-)R1)VeOCKYGEaB=e/VHS5
RZGDYO9S8_edQe@/H5(B;fA]-?9JBTTT)-1QI\1PN]ALO?G(dM-fB;0;d_(ZO6C^
8]ba(bb9Q_g5G3+.HZ5IB>KBHV5QP@Z]6_>AE1#Vd1AE^RNfa;cZ\R(Q=>[OI/SO
bgZG(LG><+g>0AA7LP66(W+V.B_f^60cb?bA4Zf\0&4B&OZde#B3UU@.6OQHPZ.1
.-N<KYL)1?9E/Xb@]D-/)36AF\+3\\GZTafa)Ab&A6\;_+]\FKZ86+&^JAZ=X6=-
GCW[]_)C,fGR5\54aGPXKB.;UY\QM_a78.E#X9fC8,-IN[H7.&]N@\(cU+^0(0FZ
<O7>EUe8:HRAZCW<7DOUXL,T50bK@7a/;=Q(RP?:488_#Tf9TUH,+b7)772,[O)5
^\fR?(N/\KbP(UfD]IHc6=SWb+2#Pe/9f:2>?/TUEUbA]1Q-V7>eKM+@[0[.c[]G
V=+&D3P8.ES(2C3(1G(ee^WeOefL)/aU@M+^/+)_^(bXLFEePNABWNUV#BS.GTdP
a9CB0g-061R]VHFJLKA[f1e./FE+>CMM5e&J3/QF3X,d;2K-T5d\da\AT[24H_OW
ea-F5H8cRC#+F;/_1E>/6QX7ASYC,4B9-;1W.fQ<U.<-CJe[55a^A@N6748)Q2<\
<FbQf1:Ag+S,PMV(2(SBO(9W):>6#SZ05X#THgD.#D80Y&VC&J\Y+6b(Bgg?XYf5
+UF;46ES>S-QIBWT@HX>__U&M?f5Q&/N,X+RC_6L-\,2HYfe)+4]//NBZWCfb@LT
[3SP;ZU6]P=F9gLPQ?B_OZL+@?T:HG:[2/[X_;X?4P?<ILR)&O0..#>&7W+d)>M7
-e5fF;C:].dLXDE6]<_QR2NUefRV6)GT^/#UgNQ]L3?NG.G]EZg7eERS0c>Z9eY[
L4U3M)@.f#/:Nc8+KKYM#8Z23+[N95FDB+YZ0(B=dfOUOf,D(fLf[P<>,]f_;#9#
>^JKO9e<9[CJ]5W^_,gU^Q<G6/#@OW+D\KC0GI.HU;&0J3>\-U;eGO-@9J_Z^E9]
>_>H]S:Y<UaF1H7JH.1:CR=:3_>3/+a^>@U@W]U3;1ZD88^I)^Y4#]2L^/QU;BU4
Y(=Bb0UbD8GZ>[)DR695=PAce]BL).:M9P&Z754;8W^]T+9XH(W_?:8]Q&TIV.(M
:VC-cJ4-<g8OOSN7_DB9A?e+bZOAA]DQ4a0B&+.b4<9:WL1PNQ,IfZUd+O<TS]\6
C<R3ML9SIbd:aAO[M(QBc\;[1F,;9PX;^B7.UgMB/f7Y@W,bL<g2YVH=b0AH\/QC
4F^&-,[;YcRL[;R)]+:BPS:cK#cV3bTa44^__Zc&D^]]LSI6EL\#V1F]D0]^RDPb
I:J?A3Z6[UD<EDGN^PX\aX2FOHQ[7,/Nd@X(N0U;_)4/RLJC#Vec;Hd6,^-XL4D[
F)ed4a?H(DJF17c]#>[e84BWRcMXNa@_LKV&4JH.?1+69UV+X,TdAABJdFd(I2,0
OX:IRBP7@NBG.+6]JE?e/d.HC_/<&7g/]J7ZaUDX(PaF4@_A3M5Ead4YMAD\FZF1
XDPUKK892-b/-fP62QCY0G-YR,\\7-GF9d0b0Q1V:1MNQbBe[6,]aU=+93EA.Cd,
L>]eM(UP[.#2>H&[_DQ<W#1YS.0PJ?XU75\X?Y4++DQT[:QKZb@YeW?)QW9,H#^f
L(97,(WV3].#fP,[4/dXE5#3[C].T?FL;e+.=);SO0(SKN_/afZH8N>A@ZBgNIU-
/g6LRO4dTa7[TMb<^c_NcQRH^bC;L](]B/bQAAXSH#Ne]b]1P3gcB#<CH;61/>Y(
&C\TaR.fX[EWC.4d3Xb4;ECd7^5JHA,\^B\:O9>._#Ag1]aD]@>=P\>,ecLgbODd
5GZXPU-MH>H:3#YPZg#TQ7(a+-.MbcN:[a4NKBP208gL)V/-(b@:N.=26BDP+,A9
@RFQ6<Ef]1/#I;;UY#N/X+EF^^#BY:U^I4cKLV-VeJ4N&+#Ld,^4/[JC5^E0MeN\
E(3a4]4bOd<7GQ;Ee6IUAccVF?d21d+DE[UgBEXK@PF>^A#-NB9:VZC=\.9eX,F4
Cg+LaL\MW3>(+BbA:=&6NAFAV5B.[\d8MZ^S^<NFA=-:Y-\0NHP^VIZ28H+UN7#f
+GfDfB><14C3--:(8848?a_c/a>-F[KX;@<J6Bg3G;BN:?FP=_,I\./V:d+aS]4G
S]+]3.c&3QC4XYf06#VaX^8@3EYOGC_F2DO@bGXeZ4]FN)-J^@O)/BQ-(B<FGB,7
5TMVg80<f;_MJXgDY;XQ80-1@(@cC?MQG<c;Y6;FR<ScFEd2f+ATLK?4d8Q>[/N7
a&@^S+2@M)7L[R1a+V[edSeM=_QLLMXZ3NAf_N6VXEUO/5]\.3MVV_YKU\;YEM/;
>DIDCJ5NL7]6;CeH_VY7O@gR6PCE).GL8\?7HBBJB(F@..YJ7[egUD4[_ULG?&^W
,MJB(30O?GQN8:Q[?#Jf3);.V[-]JM_9-S8\Qe<0\6\0)Hf\5PeHcL_6Q<))0@2V
A.3^XgSA5._0F2WcBF4@KdRe6^#RNaR,:T]b@G6B=\)01PC\:cC1YB1,de6->G#^
MfO@0_RX#0?-f5^TdW460K8J0VK@S.#Qcf\[:SRYfK6P?>IgU7Wd+[(VD0]ODLfd
6/UUVG;ZK(\(WH=1f?(4&5g+]fWebB?&)[<dg)=;J6(A#NgGC=CW5/E2V2gCD8U8
Sbf64AZO]6H^>M^1I2ZTaU5)/c9dF[E(HO-R@bH2H@M1SJ]-:5KP55N9T=-RDddA
K&8[#^bY7B0Z16T[IR#2\>X#_gI5SaI=LfG=;_ZZ8&WN6_CGL7b+D@B62U?]OG0.
4O]@HMa[D](fM:<A()W>bY#<&/&aeJ>D=[22=H_7XXb7YO-de(0a6Z1@SG0e-41V
Sb.KfEdAMH@-Z:QAY9cg&VRa\U>C+U[3LAJ<c]NB#?2@)[C^fROA+[aedB6EWFM)
[YRXWW<Y7b6,CS[RUDZeO^1<0a-e<O&(PcPd?4DEd<fQ16c&3F]a\SS,::,CUWV_
bdL&g&-4A?XY##-NM\QLY;dU(-;,78Jd,@fT-d:A6LX7-T_dN.[KM(E#,GOSQ^?B
;Dfd[1D>g(S(bBD[=TRFM=EB+)QO9JZTVQA+Od9JdT=C@&&3fAR=<F9]@HZ9<dHe
\+)bZdO@;E/RW=&^_M[)RSX]/A(fH=<\fHKZ3ed3.9eZHQC9eTY(BPUf=He@0WS=
ePgX53,Ub7+W;d;eBSSE<d28Jd-^,Af[O3.[R_TA58[@>O3X(&a#]N_<=]^-_F1>
6Ge<A^H32+#YSU130@VCPT-MB@2D\09Hd0_[.HK1@0ND?1-]T/3X6_VBcAKFHE_a
<M11BQ\=.7TYU>?)BU_-e[#E&/3#L(Qd8.QSST-COY&CK+\N.OK0L3AAPM+@Y^(?
Ac.,[D1g878+;G,6Q7S(L(I5QL<HD.#c1eQfZCSO./O0#VMBUAT:?Q2V:gS404GR
H<b,4^M-2:6fD>2X@,)7B1d_OW[D\<S[#[./IA?BKC&OXK>HPHS]9M#;R#SL]+S6
;8SNP&&=(gfGTN>/W8(P29L#:Lf[&4ZU.#8AZWQOW/0U)QMOPg-JdXMIK\QZXeb7
1bTV2U#._(c6)GSG25P<XEX&D+5D#AZcJYbMN>Nd-E;cL@_fc\E@R#0MNV^+@+DL
1J#I0aY)@32.,#V>J4AaQeD@+8c-fWLd((H(WNXC2=d.+-J45ZGbe7(UJ,N)[5Y-
Lf#U0Sb<QZ-A,N>,aDM#4aSBcQdG&F-eA;B.>fD=EV/[@O/9Oe^F<N+6YQ^YaUE>
T<#,HKaQdA1AF@TUV<;VPNe7d>a2&+HUD5B,O=J:P<3dSPEAK]D.bF(?6\SbRX)3
gC]aQ.>3M=;&S#e3+>E;B6&BHg2#2ZHS5U:=+AXMA:^>;/,,IJGBHcG?.=RNML.I
c>W>16/G5)Sg4;fD-40M1L=#I4UZIA0c^KEb-d7:/80T,I6&Z1Q)f?RZH8,T?T(c
>c\^OP0[)5P9(365?.CG;ecQ;E9B;--32>GXZ=QWFQ[af#V2()F0,/W]TDI6WEV]
I]U?,[ZA(5TQ_QNK-cO1Q;eMJ,.U,ZMNf&-S_.KNGL\(NbI<AE[bHP#>c;UE793<
_8-DgbeDP0@7A/?64Y]e,fDA/HLN5GX55T#/CWW?V7/1cA#<Ye[.T07];3PQ,Z.J
U02A1IGV-Z>?;Pb5-0;ZLd80C^MZ#?[@L>0NQ3&fP\^Sgac[WI^?2#V]e.B66C?0
<;?fKe9@)F@VK&e3/cbL72.YH:]Td]M<KSgZ=B+9TC+(LR<D8IT2XF8NML;X--0g
Sa+T__LDWJ7B+,6gJ,ZJ=MKU45HHQ^RQMJ,;cE7ZB,d5UM_X08>dc,A8U=<b.6X3
BR>NTUR0VK?2V(Bae80K,<fJB=4^>IC@@_=IH@.E><2&OYZ5>DJ;eR_aWMAfNQ\P
M@30)#fe&V33Q=II:IPb+_J-[cR49Q5\/#V&D@aAEM?)0--IRB?d.\/D\C+;gK,F
gGN@>I9d[FHAE:(5AC:b>E5]#=Q.9;#@@U>>GKBdggIW@O<OX2E:QKX.)S3)IQZ@
aJA@6TC8/1]\-+/B+^\X=S&TOTQ:ML<[aS]gO(@Z^NGM[@HTWAGbF^\QX7dcY<TE
H;+VP4UV@<QN9)\d2Q8d7MZFGJOW_FO\H..#M_f#H1ecSUW2Sc1e@I.2IR+.]<e[
<]573>SQEOaUJ,S,Y\4+E9[]SY(^<Fb\A4Q_#JT^01KUebSZg#>1]6.E=aPBN:S8
N7GMT;Eb,M+9QFbH:5N>9@R^<X_:c<M^?BDfI:^&f_>]=0AP>-=<.T4]#A#L[g?N
8M3&_PGT];WCG0@U(DE&)-eDD=Z=TC(89_PXPCa9OT<7e_+#N2>#[@0XR\&fdN0]
U=L/PWBL7A0.3BI9515XXA3R_g.H)E0\Ag.@)e&)HCLYc)S4NbfH8?MaE+#F;6.:
WF4E[3:,(XTJ-@VSO6(K&M9^gbfD&2>g\FDFOLKd,e0K=VE3._V88S&78EB0<E&R
fX#La(:T>b/./;N^D@HcPUC;[Mf370:=>d[a36.[;b,W[HLAGV3f=b46C3(1CH1F
F4a4<1BQ[#O(d:0<G^9_80N@E^A?Ze^^8:/4[#gLMU3C6U_9X4N;XRE<MK;\3CG#
-4ZBF-<5\[QIDH\M][?bc7FZ^DLRR7(L.3>&NW>e&+d_/NP1fZC-<?)V(=XG(P6R
@WG7H9+/K_d8YC5+Gd:=<<HD<FB6@]a9..3eHZg-;#CZ,<Q]?Z(9E+C6?Tb,&<Fe
+L/2QDa-#6VHdcZI_<5bM9=aQC2+4AOD)AD@0RK-6D)c&\B-/G=2g?2c4[T4?ZTZ
Q0G-:05&+V&T6#LL)6H97S6XYVVW#HUWJJJWKP2Y@0_7f]GcA/@6b\\d<?g0X)&P
LBUK4YfOQ-]dL;EEb.S+e\MH7ZE=</KX8>:E6=JS[NAI>66@?:L<)ME0A74PIBBN
eRI;15^MAY(M&#bdO&Y_Ug_4[R^);=T&>3#RCRW[R4R>>Cd/Oe&SNJ^==S77a^U<
+-R^KMSKd(Y-4,WLZ@21@-<>0c&J@A;@V=#)->cNZXGWL.GD;;DKBg80HU0.#M_/
A^E_C28#<]R7BU3R+2FV#J?+\LIC6aN2?8YALF;1W:N=N6IVc6[<<?Q&VV@5Z3?[
UE&U,_X9cLG@1)Xd<Ld+]G=Be<63_Q,Vd,eFXO5FT_?KcJ<B@/)V]A5=D,S;0F-8
JG3/JW?JG96K:@36^\C.U5VfaPX6/FS+?fR8F;g6]:+GPR,<(V[A9@&,Q\&96/K[
7-9?:;XMCPWg^F0S^f&ZDdD(U+aYL\7&-PJ?P+M._c#>cg+e<I&NYGN1<CB]>_6L
=B?DTIgEL8X/ASI7?)L@1T^e.95J(I=_1;&WUFZ-.4+2A>HDP2CgPc_4]Q4;ZVO,
GCFS?VDB7f39aA;0>DL41N0KRXK97\4b,.F6L?Qb4QJg83H92g09T4ZHF-08HX6W
.c):3Yc<Y/,P,@P2#.6SS/O7DV6b+aZ(&TM>&&GYV&&A0=e7]\e)BR(;b\-;SaH&
+:dF&A_(C0.W[Y8fT=ZB_DQ4f#3bc80EX32E\Q/3?E(11?HR1eXg)N)HN/bI(/NQ
/EUH9(]P6N\aFEf(?g[YG&H@/d8^VSaH52\F/)[@OKPC\D;:cd:4^4>+Nd4HH257
^DB#NN[\JC(Xd;:K]4R8EG6YAQQBQR-K^=)39UgB>0OKaJJ8MY\WP280QWgf-YcW
(\C^:9QG.,@Rf/;+CL+J1IDU-?51@)6T,A9bd>e]T,RD;UB/]+V]QQ\1gT+U-6Pf
+OFT;7>bL#4/dHaeE7b(.,4PMKb4IcN9U;ZEMbf6VQ/[B1S,_MNHf?K>\VAcdH&)
RYC=@:)+54JFM+EGQg68=-Lg:eFUdSfa=J-BIGC3LD.ZfQ_CU:gKF=Q_EWPEQDH)
L#\</5[]QEA:gDSceSZ_Sc86T#UJS<]L>?F-EP]a]YDfH-=TJNE4MbV^?LSA931+
2W]fO6?9eDZ:\&7\dR?e(E/>0R3KDZ?@KWUK>c0EIVX#gRCd\>F0?F[;Q<<+Y\E+
R7W.C_7Q;(=g6aG8aW^N2@_[XQ_51&H(242@eGS+VVb1-:1eXdGV&Wg5YU.)63?J
7=LE44WR;T<F\K1?<I7GY6I&Re;b=#WQ-#Ea_0:J&+TX^GRbUP[:#>cDCS,;RR4?
_,O3N6a5K;.L;Y-@e5Z8DFe#>PdKJBbY&]4Q?UdX[=26S=_MVAb:Q>#./X+a3)1H
,ddXVEA]5@0?Z5<AcCHKANUF/O1XQ<_Af.^Y2H>>be,cg<D9B,,_J[&B#VQ5T8E,
@Y]G,E7<c,T=L@<],NVFM660I=05ME1)2gLX/be7(HTL[f:S0UaL)LPZd[7U>]DX
4WF0=F?97C0/[ZBLC=W<V@_WMSZ.T^JB]V<B9]#@SaC8?EgGQf-GBc/7([IcWc?6
P,Zdb&gBC,#K_>X2G0,CC>S2MS^eO.\),:,^cIB=DTHLgCQI__fca7d(bH>U))9;
W[#T#HfCe^LIC3WBKRNH<C_e;b5a&&A3-X>=9LK#g+gFHWJ,[\bCE35K3cgO2>Ce
_[<X+?4#:HT?b\(OR@IaYdQ[7:-,^>O0XOW.:WB7(AZAc2OG)[V:=+ZYKGCU[)<\
[?e</\dKWJca12<)^],aeObMb>\^CUQFH=@==B6Lc,.dHJHHM3Fcf#?DQ-JQKRA^
O)><F9dTVVg/0&D-S(\gKCB^e^+V0[96Eb6W?I&AB2UK=CX:-Y,cQg6Ac\^gJ^9W
[SVZUW_0aX]085\L7_@Z0-b/B05MR5=/\gM=]SdU]LPg-6,0C[9K6>-HDS<F#Oc4
PQ\7=cIeZNPJgcg;X@FY^CO?5LdT2-THT+V>\_beWg/;?F&W@Z;QLS98aT\e\;.O
ZCVcI82CIGD_=1)]V4Me6/YDTSRJQ:S,4a:MG96TJX@7YScbXf=Ugd<O67)MK>A[
T2MU7O5fEcVZPeSb@?M_,IL1b51B#>:2LMLdVLF7&7ed:1L-[;F]:8GKNCNe^e6g
)J6g6\,Tg2(,C67dS[a@Ib;Y^D?])]GFS:RW[fPQ\<M\fMR[g[:gE-<Q4c4B&TE?
GGGSL>Y#QL<g1-f?6RB]aT+<J/-N<1^b?932@SZESAW9E[_M6fE9(O2R+A=\LEJH
1Q0]WQ4U.S+gda)3B_HA/9(2R04M=0/<e^=:&#K>b:?4dRBT_=B_g54.K6&aLaQY
,R)GJ_VV]a<Wdc4K=/WG1RDBA.ZI\Be]L7::Tg-_<PJP5TX0+9d=X+bG8EfJeQ6<
df<@B^)+1_>-^R]\JHE,4PdQC[#G5^O<FWZ,g;a.8\.5X(<ON[U2Ia]-)/?I,g6#
3SBNg;7/dC#ef#aT&L]6c;3+fS#.P;.LDf+1;K9I3+CYe#BM(Ad<B>Z;QceMGEEW
d[)=c5523e3WWT9@N2:.WB+#K^Yac2gg_cd,&1^/(A8;Qe#dTZI]fc<ag=SfG5E(
WP[+/#?4PRKcdPf(=]-5Ue:ON[aWJ0ZZ@AR=L+.^GG^89^2c533-b,_:@CB8LUP=
+LJNFE,)A,e[LQb>++B,YaB+<WD;>b1c5@C&G=\bdO0Q^A)U)gg]]</;b<=ND^K;
g[TCO/&(&/=cd3Ha.I2>V7Y>Y3NUdJ.Z.a\S@5DJ08VACX7FA<GQY]4I?COPWG[:
b05]KB:98-)Dg3DI]]d3[aYg^>TO#U4)>HV4^QR<BOHC4X1=HCK/@2e;>dZU\A:W
N+SB?C\IGNGUfB1/Q;48[fNa_ZV6De-PBNL@./[V>R;/aW0;c6J_&NGJBeg]2Vc#
J5674D]BMF.6N&#+7.[5D@]XQ3)3bCJKbPCHE:PS&DFXG(CBGUP(ZeX:L;UC,=?Y
A:C9=gTc.N91P<3\c&.,&H>,]6[8]EB=DO&cAPCF3eJgU=Wa0/A7PZA&+R0+0GT@
>\1T6+9MF)RVIRUNG9G77^d3T]J#H#Q5^d=LBYPQgCKS;CPA[#AeUPMM/SAe<Sb/
:T/KGMNX\_FU4C:GJV;Nc6EOg<6-5)-Y</>ID?<)@>@bFQCb/.GXcDSTTM8J(CCL
5J_.U5P_/V#8f(\Fg<:6YKV3L#eFP4AJ3552_4a@U&Ed.8HNe(A<5J(N:cVe36KD
>L6<TH)APCcd=78K.2aW]1/X<M243JJT#\HG,b^H?^:__gTdKdBJ=BWZJ#?&@+NS
dH/BU9L(HLEYM:<>FFNE8MT5L4EA5R@390_HKT:P_8ED^@H7.^J4.:S0S]+)5\&\
OMV?TQX&aC(;4-ZAe49L.Tf7YL/P@(8AeH/AH=M_@YI8dTPN1V-_#M;@4+-WZQ7Q
F;RFde@(IMa/CB@RV+Qg^9f[[@GFDO2[[V5Mb3DNO,:]S6IET;4#T4DRafF8JH)H
N^CZ=NWG[IU+BUXB0&E4:U67EW49,C2(OSB=RM?S5L3JY9FT(/TRL5A[ZCg5P,(Z
^Nfd?JXUXeaY>C9VV<.ZPJ)]=U47>]Pc_&Za^RHXLDEOO((G#E.K3U^J>..Sg\T4
/,JWeTQ/78B^0IdCJfW]fLebO4)#>TcXgc1(HL4Q,Xf6#97[5[D/OBV<.HY@=:19
=_W21QJd>@TX,?)a1)W],S1F\UFF^Z4I>#O0a24E.D,]C10Q717\N7/N&&>)8XfO
c5J9=)5+e?;T^,WG[XeQ0&?\..[9).(7F4HTN(R\]L2.:bSV_>JZG&;cD1#F,90=
,Ae;VU4UG[bU/MQ<W?e@-8ZI]SWBG52DHE4L:)?AKY(HX&;P47JTB=P3R8(GDAYT
dcUBd()a8I2eQ36@6#FOe:&.14;>]5f1P,.G@B6I\8-KL\GU)RU,933F4H2M1U,7
@V772KIB5#.Ga/Q5M)XH&[):edYGFf,(dO+L.8KY4]>C<(K]aI:.7<<NOH?2;=Md
g22QRF3\ZW)HOSdSd6(;S_d#=cbCa<AXFQ0T,A]fC,)bZ2WA(=PBONK:R,.CZ&N5
?NO=8e/+8;eIQe>_#PSb^HbKS..)&&_CHgJRW<L_fOa/J(<+]B+3OCB+GN\/-OEW
C^08;Z?HO(0F(EbB24AACPW&YPFK<(\+a[TD_VgJbW^E/Q.GTZG9ZGeVMJaL58@I
.bSU0-=_3KVEOF^b/\RJ]?S+<A/S^/EW1P.O?geMe)H1\bI<f-,J5dXBP[8B30[S
L/+U-U9:bd;^c()6=SVLE/Q&TH>G]RR3e_;>M[.<HE-0ScG<b^^RTfJR?#R[DKFP
Y[)Z+Y>;LEO]K7\&f#?-F68-10NgFaD<G[FI9f\F]SNYMg:XE\]C;.H#SWc5/JSe
V5TNK\&c2/MKeBDc.ad7JQ;bWXb1cX=SJe:dHY]-aZ;A=<JG^PN/g>2V8A854..g
AFaO:(+?=?^FP_+>X3V9;aa<Z0#3gPTgJGK#&@XW0&(dVH)2NXYF:#X0BP.\4.8e
a?9.I+SD=WL,OSD@&P),eJ[a=0=OIS1/:34Y#@dK7b\(-[Q]6),=:a2c]U3P^^I0
e:G=7gSD9U[_e9#J<WOUZ=A#[+bH42RR:;BHf:fH-BB.?L=7KYc\7ff8,eYf>]<#
f,I?T,);[FeX8W7+a5EPW1S>;<IK_PQ1[Z#T^>FI(eb7LI<H?V(O?N]4G2PT_P.&
^\R?M_)U+a&W6MYf;;KPR9;7T&<b4Y)(X=\1MgC[^0AQEc7QTOA\\AT+W6O.RYCN
+G+\MZY@OO-/?#U>B(GE8gTOA4Nd5;f&&b@C#YDW9=C)OZ+RZfM[.)O1M?0C-GZZ
^5@=TQM1>K)QMQC/G.-#F)IAI,PYEG3@-+@HKb=8@V2F8.N>,Y#/-8(9d6E;=R(8
ECfD+)4-M,P6#]b?EAK\0XWXe/?=3cM#ASZL60CfK,C@B[c5CP\]32WT<^baR3W/
ZX/#]0RC=H)Dba(a.C\@CcTC\M^U,-2\aVGKB:16SKZ/+&:A]d&S5;7K;OY=J<UF
U]2>XY4OX)f(95+RPde&PVDG,+aMH0LGO3?Q^3YMA\\aUb@-QPS2J[AL+M0D)W;e
PV4d)aJ<>-+5.L3GDe?b/];BP-U?W0VC\b)I[aXVUaPA;9(/;,5<#4UeSV2I&f-F
4=HGfZDU+1U#5:3#5\X8Je.ZNg[Td5>M>V@/TA6MCg^T;T60N8Z\>)IZ=&\=NN-Q
Z+T1NW^7AF\Jda6O5-@=#PITE?,L3<.@3AA9UPd&U8egR[.[\7/V6GC?8^2YP0^c
N=,B\d05M0W_g(c>F1FeP2VFQa&6E5I#aOeI9MW5)DP?U8XJ\[MF;WcH)123)6a>
=+e#.3=aXcFT2K=P81E+E+T4aBb([UNcc/?<C@:3DD><:RO&:9K5]MPGdUc2,BE/
/LM&</QVc-CJE,MVfRO,+<GGGPG_7N+bZ@O+Y,c+SMY#^:\@fQ8F:681=B9125XL
N5,M=J@OTR;E(9PZYR/9-.LaM+QMLa2-0:]ZSD.^3(?9gZ_2^:1,H465ZeY^=Za-
FYRWXeBS3_dT]S?]0TPOd,.=^FK2<0>+@T<L6X&A5P@Ug0P]\4GU08dZe5YQPa.2
S#B[RT&F[-Y]CN3\)[gCD\Kd5G.F?N,;WPLGOTe67Ac1gdUNHde^7<C.(>,5A2^/
bIJ\GO]=>(XYDa+d)g&IT@4G&[I>(U,66Z/?cM-#M/b5M>^2,+_CMaD2??ba;7cP
;^#a7RA(6G7]YW1[3dQG=T)gS9L;(g.K8U+W\03@/K&T/GKSUEaVLTHR+@;\aG:W
dM?A&.O36QFHIA:\0^<TK34b47&d8f@Y&fA)E6QVQ,adSKNGB:8c=<3?BHXW86H0
@2D.e)d[,QCfg5OE]PG21Vaf:&(/-@6HZYK@f4>KSO&RG]MUfZ#^b(e9E=DFNKC2
K7682[TNS/c.b]:4(B&Ng(I/E26<;9_,[#;CZF9QQ)IVd8D/6/\7KO&C)>^5PSF;
Q_eBaB2P#.,d)Ug4Lg[OA)D@>dTHH\Q4-W3ZRSO?;:BDDKBc>]Q=>>ZZ@dFD<.SM
][\P-4B=IA?9cTGW>ST9TD)?FN7gZ0R\1C4g5PG;KDbcSQ.eL?[3HMR@GS>?c_Wg
K8J?I#),Y9T&bFR23f2U#VL/Xf>,-&DQ+P#[0JBdSF4UfK;<b]&_9^Y,:R8J)F>g
9Z2_EC1\J#B/g.>XAQQ&TS@0(A6_fAc.](535<&e>Kg:e?WPB[+:-4B@HPJ#ZY=;
29[J=W.17R(X;a5Q@D,.80UT:)03UK,J;B3c,eBM?_D&ZD1/<9+E8SDU<B4]9H=L
fLUcb<>,UUB-=ACF^;aTH4QA8#TW/d?03+5-Y6+_c/=RK9OEWg3C?U9b3=YCd+PG
2g\[ZgM^OPFY0E0SeOLT:d/W?O6/9P<;XCS,=JCO#IO,+d=&H,Zc:\6/;_c&f-?^
#Y/WRg2FB0+7)[84=-RRVe(/H9MXQ#TC)^0L[6FBLMQ#(f_Lg?^@#VEKR)AgeSd2
D7S>e6Y8@C4W)7Ya8O#U.25bCDJU.;]C<Q?A_XUd.3L?O@_:XE^LR[=4Of0f7]\6
TYVgaSLZ\QeY>1X&-PaR@EU,(><=<&^]:D]SIMQ;1gA@2?gg(9-4@g+H/0Z&(bK_
gDTKK,O9XEL[BIdfX-EJ<=.OP-<3H&D3\D2>TZ\UA4JfJT\/GE7SSG6WVDYbBfQb
H4A0+WA/Q@g6f@:8Z:Ia6KGJ5;?)7N869e5MKANbg1UXHO7/;0ZDG(D7>;eAC=c1
5,JdVfa<N-c(b/,.92\(A0dC/_W8^0HN?-K1^Wd0:K/UJHILPJZ,FPa0[G\d7_QO
49JQ<0?XG<M-B:J:?YZ^f1<,7QP@c38)R#8,&,SQ&.]_d[JdZ<;W@:_+CM8N2:ZQ
aL[MD/,>A=;>1D;QJ1^4PSHaMN[-gETWZ>>_F#egZWSC@;:_cgIcYXBgINU\a^+8
=cNUH5S._LK6L3_ULcJe@b)V^+OYNZRI9+_Ga0V+6(PJM@H7I,4#7<Ya^.fBb-/+
X9SBGAL)@;c6d^3KX6@#2STZU4M\=BE>dZC9Y3COR6KW0a9b)\d@E\81f7f:Sa@#
Xa&W]=f^Y#Y9Y7bWIEPU?0-BQ2XFYFWfd_VB<X0+LB&FY^8)gMCH#FMgAHNF3P^H
LHBa&[b#e/Q[(G5b\c]Mf;W875:1&SKLC71J(C[.4b:>\_#V-@_^][]caLI&\DS<
T(:7=MO+U#_0D:(4_>MA]4JFcOFVOGM6dTHd3IgKU/6P)Se=@0-QHK]I&H0e7NaZ
a4]LKfcC2Vg<H+3<3_I^B:2b@SLK(=HM,KT#CUa0>DM,.[L6;e>aBKE,VENWP3bE
2F8X+bN7YeN@3B8)6\<c2OaXOY5:=VEDJRK_d8_4W+=K7;UJ70O\&&6>fX-XXS(-
R>e@^&EJI>L3RKT-/CYJ:OJg3>>[O,gIKQ#f=+3<WP0NLA5a2]JMN\P6S67,7QE7
00L#Y.#>?)WPEK1-9_VDfcW_H\0(g4X6Jg.f_Obg,gKaBH83,QcLa1]F>^^EV:-d
M+J?/acG]:>R0X]LU5\DJe0\-D3?MUH07X9f;;G<-/I..EITKC1_Z2RI7Q3C-(W7
b9bR=C^8=:f2\C1Z+H1L/<f&;BQ0I4I-JS-dV,7\TaG\.(QHcK^Lg0HdBDX=/4T>
WZ50G]/A_YRZ\eY:7cXR_2C]T77bV&4]Y/288\CP00/84@+YVHQ&=Z\XeKRY()Oe
_11//;SCK/M=;&a)Q6IB/57B-A4=gf;PVC9W#+XaA?I7.U52<,/aTfb:C=H1W_AN
IgQ2Q.fJOR2dCQ7S0?I\f446(^K..-=7^)H9G7XKCX6(AZeC-6<^P_0A\2MHB+VL
MdJAK@T;U#f,]@--T0]FSFgBHgBW0ML<)8^]WJcB?@4e#Q<8-X3\84T+R.G#Zf[;
X]45R3.dNU0C)<A0+KIPQ85(0)-IISSSX\d<TgN68dDA3CR+cX7JY&R[.fg>/EM)
^QCSN1L])?=dLGAIK#QX;;BF&(SE<QV4T3S^AJ7KEQHU2PJdI:)-W/\30eASSN#Q
G;=M-R6a9S^M=>-4VHVCf@V3(;fd]M@^DM)>>S9<>9Q5)Q/G80;^FB2IfM<&<I^6
b>0<_K(Y+>.&d>FE._:4&&V#F(\PX-<.^(-@V[0ORSef3T/b4@gbPA]GfLWDc=>9
\W/^<T@F2/#4K[3C78O>J2<D#e3HJA5MJTK4)>Ka+-/,CCTg7-g,@\F89P(eB-57
;QC^KE.PV^A]X4JE1FR]dAg]aO^6F\->;=_^YO&X\RedV6cYTZRU_PA<\3AC;&Qc
CVeTfP.LGfWDG0D8c=9MP#O72BMKagXWBecZ#EO(\<bR6+d\?L4^>9-;QI1WcR91
6+8We40\U&S/-FX>e_C+](9)V_H.6JC^cMf?aTcX<^[,PDMNO,YB>CdN_T]R7.aI
AFP4CMQaF9d/D0aCG#LC#NLMeMQLcK?&ScV(1A#+B1_Bf(\\I8#E\[0]4C\^c/)c
_.LG@&BbQ\,^L>9B/3b&:_f1VQJI2He7ZBN(728W@Bd+E_<ScABfBcG+]@c(F#[.
UFMA>.UYE(4AXGG#T,PM5W0dXT&=51(S3HaOADBJ;)KH2U+&T&>-I_7?ZG&PIBPH
.CV>dX@K;QJPeg,A]d=NL2:HRIfS]1e6NZR)BdgPYF-\YCRD?OJ_YI<N490GF)DH
d?c_O>:2AT/;BIJ?DXNd@D4E-gL4cK,6f?&5F:2UfICX.612?^/V^D]OX^GA6H^#
CF(-D+WOM-VeCWaLG,8g/P+?:](ad]#K_T5JE54/Z;U#0PR=5+Q<c;>d5W318Fa\
dRG@CcF8Ac8@DJ@,/N,P[0ZGA^gSX4]5,g^(D.7:>T)A^[Z_5&IgRGPUg6Vf():#
HL?7F>X,ba</5&>Y9D@@T@(+B5T7N+cL.aN&L^,<\QfM7AE?_K;2>.NgNT9:b-KQ
6g1/PbCQ5d@ca#0PI3EfL?^^RWS7+f0QO:79fT4JfYGf;@E7S2RZA94L9V8-ZS7M
V#3X3ef?fAd=?92T-4[M)ObWM/472(1D9SNQZ4U(Oe&Z=;+#B&Q?DLCW7X#DeKa^
.V4D(@5L&PFS1SH61Y0dcZBdRC<H9XEU+6>2b>Z6L>f2B\OVR#8^VaARS>CT#gQ<
U6)#+AcS-X^=-TLM:dR-@HgHP@,.Ue/a#GOaQ88VJ\/F7UMg@;^CgO.;;AWTI1H?
S8GKaX=eFg?(L-dO=AX,A.fQJ[c.a@T][8FQ_;(e\OHRf.Wb.>MM)=F>-JS;aSY0
4SRIM4&\cf-6c;gVg6F>a;[<Nd_TXF0D[G]+ab\XH:[6B=1YBQeD-3N@UU&R5N6Q
eZFFcYN=gVRLB63QS/;B6B]ZOF4-0dS<@1GUA8e=7aVRP^6]8?(=HfZHgU+EfH>T
W3]Je&M,OH4fT6DRfQKU5\6ba:.8EUde3S(PV\>=;V41]>F]^(&@Z.Uc\YJNHRK5
E=ae(2(44<\cPP^T4:DVN_c(&):P1S&B7Ad9A&\2ga3E^FY&>/FCYZRFc7JH[D-V
TAX>KB=dV8SWQF8<H+[/5_58N@]bAC_T:VR#J6I7L[(D.IgJ;3:S>b48P.8CdZU0
JCJ_5]=]b;J;AKgTg::7Y\La7DN70cMHD[\K=F4Z?,@-5<++F#8E=A7K7.@1[4He
0Z(@=II;5M=JY27B3\4I#25^S(?/dNW#Gd(1#@NZV1Q_H.gB,J7]XU:f9/B:fMZ>
ZJ/X4PUNa=cfM3X/eD2SWVGDb(MeJT)@;USLCg42H/O:O/TM;QORFO6A9RN2U;FT
R:D9?^c#Rc)LSI/L]3KK?V&BO8DS_K]@KB,EP_[&9=@f8@C93;MAFV6eO,V?_XPN
LMS6A_BEaE<CL.\[b3gVa#]>9-bY[g<K55#A4]7=31;-3FdD6_bA[6=55:FN&OT_
^)[].f9UUVQeI:<+QP5f0BG=QX5a?SAg&D2BX6FL_;6^L-cCI?O0<Qe+2;#FP&1)
G45+f]5b9A7G-X67OLCFSCTeZ-LJ;QKF6&4>.73AI8[a6[;9TEMP^S8d#MX6/2TU
05aL0d.]-0U>D3C#NT\:]DeY_(><-22O6d_FDcA7@fDMQK.G+dT86S^=W[U2@;E?
#4KRad.IX;/1^^Y;aMF-_C<Sg-=+=JDe8LT\1<(2S>#1Z:Q-#&W,0dM3=NTMg_93
<-9RD9KY+>RNgg+G.I4QCKSG,O]Q(]/::D:AHgHTALT9YW#]0W&\JcUa+MeM6U/c
Jb5-=V+)Y<IGa2A8egRd>?7e4E,XQH2QQ/HJ,[4^]HeM^fK4AR8+IVR:d+#V/<Zc
Bd\^,F]L3?g>/FGPa.B:>(Z2WT-IS<fP9O;RZ[RHdG.2(#WLQIWZG=^;Kg4cCC0_
-Ugc5C@\VOMg_a8WD3D774)_A;J-[L<T\O]#]YTKW;4=E\>0JY=:QeW(;Z)0UA-B
<YME)R,1\D;H2Y9^c.0df>b#.H@P/2,ND2^KU12Qd=A=[O#:9FV1EQ=OLY7(S_UW
5&+?](=e8[5(9e,[G5)@HJ;7[=?54#N5b7g&WO7NP2.gUW6HE)^ZHDLaN93a)]+>
J6B+43+7a#C4fRZ(C:+g6gRXWR7L.#YRZ[9XDGOO/IN<MAH?W26HPB#<TR_1e#]1
K[c5=?]H0F^VC]\-8VYT@-acC_6_M^TNRSK[5F>f8gg]bg.^R=a1X(/8992K]Ff5
47OVZ&;CdN4g\5=X4?(9E9KR-1?:]J3.M1_UHe7,V[-0BBZ/,]FAGf\ffaZD:-[6
6C\)e>@@UU59CC6BN>=>\#]BKa@&H2;[cA[f\4@A2D0A[B)M7eHA=VUcg.;(PVgV
)Dc7M@&19bRLD6MM>G)O)R/NT<FE>5L&dM#>E]0g]Q7MKS@\&LTcbY?WTGFJPZAZ
1fM3,Q+3PdGe+VP+PK25OWXFPb\PA9J=93K7(PX25GA@4S_C,g<M@UXUQ?PU0RD>
CG8JT]J)65UZBZ:QM>f7I#)A&]8Z6ZQUH2-&<N1_WFg(GT5F.M\=DWVD@#^7-Oe3
6[Z^:KB+_N/:\c6bET^&6J7-(KBI&<4_^IAKQ0e9G_Q7DV8J6;1N#cV1gR.B=[86
XEM-\U>bW^QR7FI=b=-<#:?4#6/WV;PC_&Y,E3?M&PaTc@,JJ(V<Z5ddZcO6Y9Ia
A.6[>19QLB=eP>b&,Qb]FK.N@VcW^0B7VGA;Z^YW3]bc.S0b^)D<1IM57WRa82#R
]:UD+O34DL0[ZDc_3>3Z-CT#M]L7ZTS^C\Q[P3b-DBQ7,O&1-R5::JOL9Ya6L\[,
H@EBY9M,DQ^18>d_=aK(EDeBDDN.bZU:(f1\E9Ag&9GIff58T/6JBa33#S&TZHAL
?bB42<9G\]ROTY.<Q:@&R3>@TJ5Y>\<S3?(Xg=KBSBF10>(<^)#)d<=[^T-eIOKJ
Pf5E/1]1D=F=eMT50O/d6E\8<56:f94AT>GO+J0[D[6E73aW3E_9\a,(W)B6KB.b
=LU3ZG>?eeX1CN([.._V=NNYeH)[4d#(CY9W,P3VdZY(Qe\^TKgBHJC#fF0-&9IV
Y0a]3#M@Y?YP=Z+3OZLT\2JV#+^V^?:g7>TZ143BA57?cLKJBUS/d_&:_8)-[Fc4
+1[?Q.Y4E5^?]8JGS#-IJ0<PZb&;-JA:4:+].D,I-E8RCbB?[HXU8)8>:g16FYP2
<VSPU(f\UbHSA\Q<N9)4\Y?1>XO:(7@3Ia6,Lb3P8N^PEa8beaELZ7M\Ef1YH/;C
+.[3HLCJ>.Y06Hd^Pea0@U3_E0U#.75Xb2/PU<f[3b_TS:]LGDM&5B1QQL:^.\9<
e,LU2fW(BgF8\MEb_)HGBX-^eKQ@Jbd4[K2bCY1/A]Z3E)UV88d-WTZ.]A3DeZZM
P+R2_19IN5YdVD0)<:,L73+;1&P.dN2ZN0<O45RgbR.d4fOaR/f[ZdV7Mbe:aT?D
+=T3QXK.HAPSbJO)P<0gQ02CEe(-U+@-S=&Ma6g3#LWU:cLbVE[\9D\WPaU<CE3Y
4V&>+FK&[HLVB].=CZ2OdP5DE-.^T6)6?R<XdBG+dP>+[+V6XP]_Ig0R)D)EUgZ3
_/Ab=EQ8]EaYJ]5SR:CJ9<AJ9/\S>A<H_Y8;f8[ecYS#Y@fV6;1T+Y[UG,NP3cMY
J;U\4geJ1g#8-8O012#2Ld-YY2HNgEAdFAd;a[,L-&_[)-\>(/I@-_F^JH,XI,F7
J5Y.SQE]CY#PfODYc-S@+eTF1CL;Dc49B-5P;Yae^&f6JZOEW9KEI4AP8P.@N?@<
FG,bJCKAZ2,&+@DQ4JCL0;5302&\TbN.eJ=a0&2J,J(6.L:Q6F@[/W.RM+5?HF_I
GG^BZ.#M8eF6gIgDb6I5Y)?)88Q<V,,&DO34SF9D[gTQS8f+\#?#>fB;YaM+DfgF
;+21=[WB&[c/L/[BPR6>BO2)3-RD6<F7X1KOELgES^KZHMWWP./?-S5L+AGV/W9&
7:BZf:@dfXLC44c/V<8e@>ZIaZ\D_0GU=Lbb/IUC^V-@@-1I[[K70E8D9ebG9@Y2
G94Qe1^Ne,V-:=WRMAC;f_G>/8FN^]Ib4WeE+f#FP+1/[V;dKP?:T9]O37C?Xfc-
DK_QFQff_)3e7V]J;NdW1Re?UH.c@d-4)2MTJDAWP?6U:I#6^Ef#<L:8).A4#VZW
@:Qb^Bag+5cA-9X7G<]g8:MU^8UN>.&UXT@gQ@1[HBad0LH2b\:;/#DgLRBB>cN&
UTAdO<3<KI<(.-_0g71^=Y=Q+EW33gC<Y/7.1FASV3\96+;7-e_A,.)[8QZPa;RR
?e4R)SJ5N3&EQRFHBJA]N?#=R>?&=M7V7afg0O/R<fVPUcJDK]S4XA=Rb.)32K<0
?8=UH&>6>fc/D[af0&+D+V@fPa4>&K@V5aZ?7Cc+5ZY=V?,4&(M+Z;^25T5<b59_
>(,VV\?RdL(_WJ9:aHEA4[^fX^DX=HMC@Fec&G:D@?f0?&8&XR9eBC&JHK=]]KJK
/[TP-b^e8f0NXd\SA33N3/[FVIV2GS/?H)6Z9SB,BO)Z6UICB@6KNA]=DWV,;J6>
(G9#e35B,PabGOTFK+VNb)X76e)\H)5A80b4GB18YTe^8eKUI51OcH&Y&Q,LJf59
BBKbb7P:.e)G^BG^2)GFDd2(C>:Fb7_V09L&KP9][Ne6cUBDae0&Y>YJ@DW_.K-6
ZHfQEb2JeN#K<WV8S8&,&@]&X4bc1B&/&;HZY:Oag>d_dDTc7>D-Fb2C\I:\[HeV
]0<cHWGMR]^14BH54CJbKcMV/^LLN<K>1L49D6MQNC0R)50.,0<<WcCTe&S\6dXG
_LRLU=E[AQ?WEbH^D(Q]=625F3TSaWF=I.KI1;:aL2[E(EX17?]d+/SC/5XXefa7
WTN3,ELa4DY<IO)g+<KP:6eHHYWb#bOZ:N>^bCa^<&5b+/N.YBGeg2[4-;(UH65b
WAR:GR?b3+I==Dc[2Sg43E6[B2aUJXd9QN:D=:-Z/\&G=U(#2<MQ7aZ(E6(N<KG#
)LU65TJcK?X?:)5TRd#(.G7Ad4@@0H8_:J7]&<;gGFQDbZK.dZ1e<OGWC9Q;HZU4
]Ke8e0[9bQ26XaVWVR/(_DKfe4R,6<^>7K07=;0&Ld<=49ORU-R&8IO_8Gfc(A>0
JL:M>O>]\44UWO)e@7)8(gGS]/N:(B.UY_dL1g/2(&aQOR@B_,2ACI0J9X>BW;1b
SdWVUU0H,]4ILJC;K+EDUE\#Y^#CK8ZX=)/cSCb,:ENa2B..]TE1H+94BOUJ@6L;
=f5?P\\2EgH],09g6W];F@\d],/@-3=]faT-;.5cTO.W]#;8]?G8dY[A;.2QQea>
)[1<ZZ.R6:\(?d[8JLUfA(G]aN+,AV&EBJ:__M^@eVN#Te-SbO_XZM/K2gR/K1A\
&.:A2Gc&HZAN)MQe90594LMDX[(FPc)^;9QDH-NdR]d<<Ae6F&[d8?^-d;0;CdH@
0+?1f/df4I9D>MW34@]3/Q3Ig9C81KNbSLFa<dIB&@)[DIM<ZZ7RQPN[3&U(NXIf
>[F[/IdL_T0TK0_MAdYQY36/<6_VH124Tb>Ia8ZU3VD&9EVZc-;a0#7g&YW)EI>-
fRC[0IGXGAcN@V\[;-+edEH)]A\#:QYUI_3P_:/MVYHa3E]UAf:,[2R5[.3GZYY[
F=GS6aYS>;J1c8f0WFD8#9@Bbc,6RNQ4K&K]XB+9f83dd=O&9X5,;fA?VacJ-Fd[
XLF110KX\<\R;M,84>09^#,d_;aP^6:NI,LUF@E#N]7(DAV^E1SJ>H+JCYE70T5C
92.F0#ER1=./Qb3PO4QFPI:)5gC[\Z9^aM#FM_7]UQX31.c,&3?=\)&4X]V2X;_+
2]UO0.e?B0])05A;E+:dgO&GA0XZ^&@S(?^bb4aeS&@DXF,D6=_0NR^F@e+]S#Ad
4]A(327c,Kde#<RDG]&JY+G)a8Id&7<QMD-7?cV+KMQJg1\O2I5T\cULfUS32V/[
5H9;;7+=[ULR>S76QCA^,5d_JJ0][g4?V=R9/CWAeW+RL71RR3?N>Ja5)].aV0WI
2YHHOB?8PdedZ-FP3T3e3ATNT:4U6SA@\<JGE+Pg;d9;6NPE?R/,g,_R@M:3<P@G
>IG>ZS(8BP>JQC9_XO[0R(,6?9Ug(.,-O=W\aX/:5CM1W=Z9+A4A[J96>502fW#>
G\G)]B2eQ9?0Za0#c1P.E4H+V.0>/@1@Ca<&DEbc?4E_WA@=L5GDJ6-^2fD.TFZ2
G&?D#F^XL7@cWV5ebALOZH[W7(K-F:S.HDRR(]:3?AHCCP5Yf#Gc:O44LIRU@P60
SI?83Y#:77)MID-,U^/<[E[gG(f5N2?U@V_Of/BV#6RT^e-I0;(Rc8ZWd4@BQ)/8
8+^(F2WJ:fLVB\+e(+;\-U4e6D^0.)f(1GcGG94FIFUI?VMVBb_STEMdYO/+LU\F
1ZFXE+H\.2S,3WaTM\ZU\b-+VEN]A#KL@PF,9WCKbDVMY\:4+dI4XJf=:)+8/,/c
&Q[?;CXQdI:g-T:MOOM<6P6gEg>WCRL&b5#d5.#:fU06VY6&YTF.P#:A#UN[Oa>#
K3-3RY#dJ2<IXdHXd;fbd]4TIK9H/H2I06QX>3Zc+WFedZO]Ae]\KZCTXRXC8-GI
F@e?Z>J)G:/Pb]<?aaA3Sf2FNFdEE4+-dUAZ&ceV3(?)RY4\6g<BXL7ePB=P/QW(
).7g0DYg#QDM6cJ(Y^Xa)>K?;AJ9:&gBW&EF?,[KOb=#5aU5LR7d/fUBY/3_>>Ec
JR3bJQ4G_6<^]eT/eRJ)FN97_-7YE16>Y)[[.,=YH@+fCgb[7F2FXdGYUd5=c9fD
PNZLJgIa4\<S?,VNIEcR)Q[YF=IBXWA;LL&C1\ND1M#N;4ddX.#RZbB>T.@;?8EK
+C3PY:)edC?UZ-).a@/N5)F^MJ-52OSdZeJ1c(AcU&RV^9+]c;;SL7T_5T_8-f9b
<I:XNWNM7cFBgU2=+,A&HYTdMg<M8.\<.=^@Z&f3R?_Wd6^fbGb?16_c\FV4-KE_
P@>)R(I39cDBa]DPTHV&Tf=Ng^PC;3&2^CI+a9:ZR6Vf\f#JV:&A\WZ93H8/YHM]
bae6O3)&\UTZI(RLP^9:\6e.64VJd<3:P[]=+QJ9__[Q,H[6N60_4C&VRZT9@YO,
(=aAT&-XF\K4C\JBTY69U;\X-;UO/AdDK36O((:Q,YE&=AIP@E^(CZe#+-I/KJY>
.1J741?/NDP?feDP^;+TWP<ZT3/317BWOXV\[8XPY4f<2c:YG.NM3O-Zb9U=,5U1
N9<8I,VDDT]Z6#1NCbROI5.T[#BLe^O)f-J:(@F9Z@Fb,c^C<M.4deQ,b<b,EDD/
?X.B38@W-5N?:@G^.FDL&?FO+@aXI5c-_ggaJ/8\QOF[81JG#93#0c8UO4CJ+RPa
ggJGN(IQ)<Ya<\N]0C__-^]\g9Y)0)7BE@.1;8UgP5^8=AN8GBVAX#EUVWW5bd?M
1QU>f^N0faNc(Z&BeFH7>:Z1Nba^1&B4A)d\^F&88A/d;b,F=&X#HB54d6:e)\L#
cW306UZfLf44]<+4P)S56S)7g7N[4[T:FN]Uc4OcJJA)P]OKZ[S(d[4b&&YGWE6/
KI#7YQZUYCOFBXbf(=;Ad2c@fU[PLeZMXZW6_#:bW8Y(<g^.AE:dLSS/<,9X1;g7
5b\HO?bBTgF)QB+<@4:V=Q<V&(e@&3+f<A7<G7?0/Q/H-FZd03cTC5KXVOQAT<#B
fKY->ab3_V&@QNa#,60MC&2dgY-?ZUT-^N6ZMY;dAL0-5&/,\L([L61N^3],EEGH
39WFeHA:.U4T3\+[QXJ+J3D;+Oa\YaM__]V5B544Cb/<A&SK2KE=^J/?WX4NSS<\
,Rc,7GKC2X-Y5O+Pf7GFOc[J\_4^#WVfg\OZP_D1_MIV;1.J)XbM..G[\1K)GNVD
8a&QTQ47WST23P@(0N[52+g031BBa=^Mg49U-V2_fOa0MN3BA&\d^_I&5JOJW]Ef
J]+094b;\1#[=52+[A6[S#JAf8C7\N-;,&E)1(8d&]&Y_Q@=IBMZRDb4MV.#21R9
^&(A_4-@VHJR1_Sg^H<H3SPN\eCdWdUIKN+fb[be(&^OW0aIXXa5R-+D+<^g9C+]
NEIN[ULTS:4V[0Z:Md?\ae&,?3SX/E.7gg,6T^Y6ZJ\8\dcW+1BL^-[6U6#)Ag5&
<XPJX^.egY2N4U8C973,:B:01D3>@a>C^fZ>eZI(+a@F.YO<.A<-6\Y1U#R?@(-I
I/8f=0gYU;C_4[NY,EG>gL>DG@G.>?G,N_b^8cH_U\=9^a-8,T\MZM-\+JBJ.0d0
gJP3gVTZ.G8@L:2M/N-6)A-E?(F:4RF^DT_Ic_e4LR[cAU=1M+QE[2R2@YV<..XN
9=HLTS+]ME7+3_V\Fd1ZV(5a62RCJgWF2?[S[P1@,d[[RD8(4[>NcG\I+W@LN@-f
<9YEG7)].4TYd=E;g152Pa]Ta9]OU8Q-@#2QJP8JA=2?/VYD=&=RgPD=J_5D3BAa
^8b5N<K6-OL>>/G&I??]LA=IOPT3X8O]-38-T^4H3_@XgIf@X8[303?@6Jf+4JY+
a5NQ?K:A7XD<4+g<G09e+D00d\aN\K:(dL,^aNIQT;X<af6Bc=\f@eDI0FO#RL(L
=KB1d.&6__\,H6,0O+;SDE^K:_TTdI,;eP6M4(HAbN0B2V;&\O5OJFVbC>[N>=&f
&Xb?A:9a+e:<2\bTG0DgQ(RYPXTV;BA@FGO#C\UV/5\#b]7Wc-30G(#5R_2^A.X-
TK0T[Gc/ZJ\37<cD;(WEGA[YB=2(;g5T83J-?S^aJLgN4H9bV5U>]Q\e3?L:IK7Q
LCOO5C4=1K8KFfVO/@RK_PV41AI=VA0gJa@c9&fAL)DN#g3TdA,&7J(1a0g5Z4[M
6ES5]Tb;.4Ua#WeeEZ=a-M,3R9.:PBZ3^Z7@Q114>B4?eB<NOWYTOfFMe2f][2<f
c<Ge/7AI<0R+C.TgHHg0#1#>.<<U@Bda7FaNXQZ:XT@H?9/52<7?3#O]V+E>4c7K
?H^4IOVH>NEM9I1>2YQ&-;e6@[REBC@[^[d/^RXD-J3c8P_HYT<:6GQC(+C#f0.V
46+DAV&@]LaAB2\^_D1_TeIQD8N>10c2U15;7>ONX9,dO6f.3G=2?H2AN[U@.:7)
[V4-:@+2KGMP8WB9e)LQN,[KQK77V@+USc](_-VGRZF4IO6ZZ^&&J+QP#;aDM&:C
]@:4,9(g]IQ88@E:aNWA\OCSL@Q8?d=Y(9-f+B(@BVUF-HHN9X&XL;VM4XOPO)^C
<QFWW5(RH9.cf@#[E[R^3+K8dFL6Q]dR)R++0S[E:<,T+?NLfTec]64RCB/8f9A0
G3NZbJGJOCPfZRUI@;V<?O6D<\CRRd:_3.6gT)bU(>DH&[CP>Fb=O+[+LNU6PO(>
_UKg4O3@;e@9G(eK,_NE@:S9THe9.8DeVS)JIA8L#H)-#b)\YH4#Q60M9Q0.1/?W
c>C8_5DO3R;d^f7aW0dP61+:aBD2Mf<AJC+)H;gD/@D]QHMX^6E<N_PSX39O5Y)K
XLQQB=#38QP88@=RK,0T\/ZWN@->1\FB2Nc,F652cg\-1J-<D9=ScLcN4=86S:0X
]E>,ScOA1,-:Ic>9\=;gJe]d@I:A\1=.c=H1ZNH;#PF2@:]P1+D.#Y7OT_RP>-3]
P<d,1),BGb?gCSQD3+Z]4=I^I76[\L7LdCK+M3K/_Ia_8;cTY;CZ8E)gQ]Q;J96&
?U,)1DF\1Qc(V0Z9_?K/b<6_V](L82VWUSCYAKQ\>d:RI23=5b42Q&:TA.9/,-TR
;ADT@_@88)#:JR.45B#8;AU_C,T/Q\I<3ceI\P0;9)@gFYf?NeZe=WA)Y_(8MIPY
]<2P,@g:X5Y^@=+;+OJb,TU1CdH:)(IUZKWE1DA=?LBN9,5He[dM.7B3)O1UJKT6
RX+#cUQ2FS]BZKHW[SEfIE]HNgcc^RJQP&e6I[#B652[^RY<ZVH>Z;>]A))a5[X\
_Q14Y/9(?Xd<;4B6V>=])-TCFc1UgMA,0EJ41_Y2X>T[13V2]7?AV/&,0c#MP[(J
-1(V9SH:6e>-QR.V:>;U4U9[1Gf/]d=bN)EF^]6)[)[/@/-D0UE;+SO=g27:e.)4
GSAJ;,>BNP#6()G7#<)9:R,V8]8XH]E@8M:K9VWa9S#.G2R[I4e8KT#74TVePO=c
N1KBaEZP54\&17b]0a8/CH1-J5&-L<EN7?.<\KD0A4E]NO:>7S<YM(26L9bI,c?7
XYc)EJ(JG//N]=3L1-dWAMF:B=MfSBb-g&gJfY[-SY>M#^A#d,ANF\_-;a(@D<>&
\#0SZ@41F\5\WTHGc3D9^>O2<Jc\C&1NPaEQHA=2GJJ7a:D6^VJNZ)/Qc,L5Sf=Q
Fc4VOB3QVTLY2&[b@AgL<=A6Va-7#edb28;]:Od4T.bKA@_YUHXdF/EGU]3J^a9H
GWa2<FM??-dEBE,>gZG4]4).,f7[b#XT@YfE^NO\6SPR8DU)NW^L[6GC7dJcL])_
,551Y[3g/C&bWX_@XF+[\^UA9ZAgPO[X92?JIW6/::435LDP[TG]H=2QKf=GFF@N
OPCHO#F7Y)I]9dT,/V-ZCcR;VHdb<_IXG&G0\W)d,9(_dKX^PA(A)<UWHYY(Z]1E
Z+C?aYL^R:3#<I)a(X?N2aYLO^5eYR#D-\KTWYg;8gKK?3K@\Z^V:GAZNW.P/0A[
9ed]>FcKDcE^1[B54B_?Z^G=Z[J>-<<G-ZZGd8(FQBbS3I_W>=64(,DB8CJTdd_@
C[OMGL5Z(1)3H]?;MM=5?<@Qaa_HaV2;W:5V36PQ)97b;c>T3)(Z#HRSRCWBVHC#
b?GZ&<]^2VWc8YBMEeY3U7VUHdbHV.<_YGSPFO<Tg2SH]DA.#?F_E8ZTM?\Q4g[#
6T<(4H]]V^6HJJ3Z9b;-FX??M+?@XPV8Z^^CSR7-LA-a?gaeJ@_b8f>(M(56L?b(
F7KNK8<@G--1S0K]J8?dZ_KX2^6&+^M:_I4J\[AUDAd226W3FQTH@]>:YDQ_]>=E
Dd#2aOc=JXO;gfNd];@(+H667,f=Pg+<^V;__)Gfd.<\2>;=gX+DU^A6(&;SSORI
/RLCLQM,7?b&]1/K9=GV?^ET/N<60GCg&G)aQFT^GC_F.4&[-L5U/b(8+M4CJ=YE
X<QEa;M;KMJQ[,JW]/gE=(fJ<4\;;0XO6\3gTCFCR0DFf+CW(<I=#fN3M\(Ia.L.
&8,6dUT<eZIY_ZaR,Rf@EL-^_,=U1V[RC6Q)cPZK]Rb8?cH?YL/#6()AAM-J75P,
K@?@OeeM,G.:@&@3R-:bCHO3W_5[-Vf6#?<D^+#T>/HTS9)4VX;?FSdFR65=:TA<
@;:&=M?5OCQV+AQJ7).339&FDKN/?S_,K/QFQe6cHc;f83K7X##E^;c/Z.(_-X)X
,;L[A5GG/>;cdFE@FF:QM/L)72@BH[b:XJD55]LS9?MA8X=J>R&0QD5EUZ6U#Y0J
>USb2fYL6CKL\0G<AU,.FVBa98Ab:Q_c&T[e9,UFb2HX-Y1<I7;P7<LA:3B=ZScg
,OOI1A<+;(TTF:W:2LFf)&QM3HA/8<Od@DRS9Z936-HUE>=J:5U@<F6B_>^<@Q-.
^26BS[baU&]18#<X=0/BH^LBa[O-N)DR?SY_CZDB0)IC2AR3R-Y5\DGT=VD9>R=P
)5>JQAZ6FM4_6YCa9V-HT9&]+&Hb9dT.D-?)7O&SD#/XDB#IdQQR8Pc^Z5EE+99c
,I:b0N<F/BMZH>B]4eNXBg\)0KVK^ND0@,7>-gF1e1]N7<X>_MXJUPVQNB,D>NPP
bA49e,MH\Jd?^d@PfVZRR+,8XP&;T^-O#<?g.UF.Y(bC=)NJf-[77F\;__CL(?O<
RYH&D<>5U^1+V@PeIJ43dH./(/,W:_]OObQQ(>ece7@#SZD1->:C(=4,(4O60ZQ6
^,B79.CI))]B&.D?_aK+UM^6cbZ8+O</[>4/MHN_He6:8O,f,.4ZYa2GfAW_I;NK
HG<gHOD#M&+W5,ZD?<E\>/S#2PeDf=-I#[OIfVKEHBTWT]NHILABXbK<LZaM2NdK
QCe)BJ-0O04?c;NK:ZEA6R1.NSK4()N4=\A5@^:Ja&=beDcSEK5C<C=;KXHA/7eF
Ia#XV;]RefPWaN\4e:>)7IN^4CgNf?Y;a-OBLdJ5bNIIFM8ENV2YVGDP4?\/:)#X
^,TQffY[1a3..D<_ZP7GU]95NA1>WLb\1&\bfN8-#Jg\:Y[8TgSc[OT2A(.FN>BL
_LS.M(8#_9E8DfI4U_:^A^?EK0:?;B#MEeS?W:?>_Me9E0QWQ?=Q]_<79(b4fcIe
Mb1(7U[GKYOCfLe@42.K=W.HaR@[N\b3,d8#&.(HDBM#5Xf</3MWDA6Y;8.]^VHJ
7^_4D([@9[?g</cC@DT\L/[+5C_F\T=9>XE7A,Ue.=.eQ<E0AUg=,Bb,5#2c)A02
DC5D<FRFGBGc1\9D=bU@FK>8g_#9D_42/7gEbRPBK2ZL3UeQAPF+2?4ZfNI/\cLK
K@)ZfRI.)U2B(CT>.eF.)Zc/OO;JHMa_L^I7R[^7UO#[1J;)Q]YM?N&PT]eV_<?a
aQYQ_.4VP/UdVO;6dQ<GeH6[R.==1ZL.>^&R>7ddI9TYH<:N#g[cRX4\7]B8_eVe
2MgDN58^L8KFBLETM?Sc&G[?68WW-.&Y\2PeC[e:0]&Q6T/c1E8TVXM-+EKLC])^
Lf#^[ZdfaC8V/,7O/<K43(\C:G63\U>FK6=fdT^=]@c#SYQ>ZA6?_DSPQAZJX.FA
>B^\_K/Ya_D:,J\\<d\E=WaJFSVeHSR8ZH2B->Y,e(M2-=F<ADS9[:8P=/6,e/Vd
0Xf4/8.LR>FLCYZcL;,X5c^Z2_BB48X7Z0@@,#7^W@-9V^/Ee>G_68&T_7C6CFDb
7XN(DTe6fb&UPPc8>2B+T+?8<#5;E>VS\SJdUUR9RJU--&Z[H2PI0L.2RT@6)K@9
8PW=2.aF06[CY#MP4C7BU,f&f\6=._&T8,AGbf4TZB<?WE@U]_HLCKQ&V0I=ZgeG
S4NY0FC;ZDdHUN#8YS#JdMA2f=]5]W>PI-_0X)J6:9?M;A=Ef:AMB8J?C.W_R^(L
XD210QA6.+.6](gUeZOCcGKJc=L2\C:QH7QAP-.[-f+@L9N^[AgQYEA\X+,8E?8\
FbMQd3Ea?1d;XZT/TgU[,4&7PUX7#D3TU^+NO5A_E4Z&>bXGR9eF=WDG7LLUOY/c
7^)J8\@DOM\IQO[DP(fOUb0TIB<ZZDS+ac[C7LOCePG0RY1eH1eC(g,\1X:bEMUN
-B79J5@+d60TM_GA9G(6&R,PK0N@[FN8Q/[_>:_+MJHI<N3fKHL&cD>=XD0\G6Lg
,CIg0<;+MfA+XY^J\7Q^ZD/A_F@P,Ncf7g15ICdH\HREdDaTE274Y8=>?DR[RQ;d
^TgE/FM(F-59MJ,Yf@1SJg93]Z.I\fY6>Z##NbL[g[AU3cA]:BdBG_\M^f;\1]b]
KW;g+ZSD]?]4gIbLRb6+X<\,7\EHfA5),DF,G];JV.Wb^<IE7d9FcLXb+^\O]I:d
HbV\/&TC5W+W,EfQCK;:>#D=f]]E1>Q>X\?_H-M.YLV8MARF5eUZ+A@A0g\&#)8\
)D9BGCZC^H\_H&)D8B)(ILCEZ3<A??b10FY3Qd6;E9SQ3[(8D=P4f^gHOBVULM4g
(5&5.)=fF@=N\M5g]Z3S\3.0bSf2O>21JS1:+aafT+E7BTDQ)W-FT\1--aA<IY\2
cM7G,WD8+\@BRLTZ:3)15YSZgabK08]@MRdL(,SFgA0F5<#D2ZG_A+G5d3JVD[3B
YJ9/&:8LK3-AAe_G32[^F:8Ag]:1WE>:R3-,A8_>8,[;L(;fbFHQ72U[Z#:H)&4B
WcM=#bc8WBPOG2VX3AXC>1&+@)WB&/bXGa=^42]K#=_WUR9F_=OFF]BE^SJP^.EQ
ZK=cc86<D?Y_E>K(#W=KAdM[S#fJRX6_5[0,939FNJ9f[4f,]W<XC]6e[R_<C08M
-QVP6]e1JY7]J0R9B]&Z/D5+=+/B(3_a+(]0/SWcb=_KEc#(/2fC/0NGEM/S(Y@F
(,9F:P]>IUeWX[@,^DUKR\;<K5RX^6&cH7dX-?SKOV=E,(,NXF=K>2fHGcK2a\Tb
JGG/Te4)fV9[Sc.#2T/gSgIOCYKTT&c_CWT)FZ;aO)A)_SO>6Kf^MJ8+FdT_aY,C
TgCP,dN>])^>gd@H3Xd#Rgd9)bIf2QbHf,+&.@(VJ[4Oga4UcH:X])\H=XTI8X4,
:]=0+O[L1[LSIN<4\Y=WL.c5e[febHfWaa11<=?BVM+Q]+Y76/@E9Q#:F?,<(1&0
R99\F1A^T,e\X;720Wec=AE3)eJd\37_05d#]#GS1O:34OIML;L</YRA_9UZBKTN
H.J.V=6.F0Y0/B.#A,_LG##?abIXW,dOG)Z@=LI3JV/F-fK]3fH_LaXa7AWDPY9)
2/0ZH8bJ08TDC2-.?7QR36IM&7>6)Z^A4OE/\Y.f+5EV>W^OR5A(1O5KD=8T&f^<
=GI9X/RA[T/9495Fdc#5cWP90.UC\N[BS:XD_eT.Db((<R3ZI2YcH2g2eQZ4CM76
K&G\>C]]6&^Mb8?TZTPVBBPLBY^bD6Dbf;[)N>D=A_UD@K.TD?BIW?S(OV,#7F94
gYLQN#Y2L2^3@S#B<^b-U[ZebLYE=L=M83?g[eCFFe(aY9XS,X4/QJ5]T@KP/\f:
G)PMBg-[#9F;M;A5GKdQ7Y4f9:^.\@&<;9J02X>MV+X>8OP^4b.N&dWeMILe:OPS
IJa<SM?WTfLNT9e_KN<Cg+T2>P4,DHYKW4JQS#J&T?PHQ-:7N;6VX?@I5UeJT0\O
:8WSA(C].?S8YVILMDd(BaLLHUYVcK6aRfR1\XA[Ac[H?^?[CROf)L&E[^E6QYH+
Z.)6.0FJ88>#HeXY]#d9g;9\4-K(91EBXf&^c2E1KFO]QKOK&Y\)BO(b450^WC2;
2T4e1/=/:CD.]GG4UF&-6F#T40?##1CV_]A+@BD1QT[14^UU0f2XGaeWJG:3#YK1
IEFJ&#E,-/\R9S;fTJW&@>AKW?]AZOX2Zc6\@&;0T-6J<_PE-dG;-=XK(Jg=?<=0
.HJ.Lac;c^Y/M_U>@JKD28[e&B;F,L\CBDYBe5dB5U/<#NBIG>I=O,7+8a_SK/6/
@(.#a.#:E01(Q2H@D,[d<c+1d5E=I_bBPF#TEZ#.G]M4CEaX6U^__;L]WHQTSRM^
86(^W#fH(GA@FeY6D#C_fCN;M&dd2NP3&,3,XfbCN(/9D-cGDSM##_47R,RX5B)H
edT5T,e(<JeA;QKU6c7PV\?9f9TOXJP.WQ^5^=&&EB1)GGBPY_V,OgReaTaf)OPL
LLM+4\)D95-GLQ-dP7aNR<B>1@;D2KOYI=AHg3Y1BcJ)?LPUP_aXH:g73H[=0Y9<
D:CA5BUTF+]:Q&NQ+_FLg]>ML#NSVYD7ge;5;9XcbD4ID@1./5STJGM\=12.WZ_G
94LeA95UFd;T<45De>^MOGE0Lg1d[@#a.K&YO2.dd;?>(ZW@(O+?X;F(WZ\\7cB,
e7N(/_L8X92R&7b&cQ]b6GMJA<2,cDIQ#/X^_f@-Z2>^NA1:b(61a]LTL2V=c?_S
gADeB-SM;-c[0:c)0Dd]-RTAQ<4fL9X[\W4.-Y7e;aO#7aFO=^WM(4bHdG?OBEZV
]9=TI73/N>G-FC;\GZGFU.bL_60@C0G2Q6dI2<T2/+cbI)O)MVW3N:,T-19M@=X4
ebeLC_=5=fbLQ[8G_a7d<@STGRQJQ^DD));EgLD_^&)0?UP=B3NLIaBP5dWOP_Ob
</^Z)dFTf@=+?KI3-Y8V#91:SE89d&CUgK2a-2,ag[?/8Y9<58cI#Tf6&,N]2b_J
<fZ8d;;DHLI1E:\,QIH2EP0\8)OEfSEYf_SPg,.@T?ZO4MX-CEW;;Z\CEVVeJLD_
Uf+6B85EX=bSW@O)6,F>KN&3KVE(K(G4#:,&+8.IMC>?^7g;H[7X?S/8e)OcQ(&Z
.-FLS[1<7JLa(9OXDf3B7B;a9A\e@5bBT][-4\R\9S/U>#_K[XE6@;7Bc>aa1,[K
)Kg2:+Z5gf&?L2;W/If(MO5)Ig^NHM>YZ)H:8&=a\WFDX[,_f)WP8,Yb>QXDTH_-
<Ig5([EI#a[G>OI](5RU@?F-29I<R/+MY98I^[g]_HQ&CIUF7?Z-C)._??ea5)Y#
T>EBc-#5F0+LQ0d2-F)3V^c#K8&R5H0>]gO1I3Y3T[QJJ@N(J3<?=f-Z,&Xg[VLM
FOce=\,eYEeKI:.F])YS0H;_7b>,fY_H-8TRNUVUZG\P(S9@RNE6W<ccXMS+a6RK
G/21Y&Y8I]B64eYbY=Yd:&(KfWTUX&Tb7F?7XSW:=NWF=Q\9NHHcBN\C)[gbG1NZ
1N^OG&J_gM]B^?a6F@U_G<QQ4&_92.:H&GG,Y\G<ER6Jc-R4IOZS(3/gIX5X+T5a
;@c<HZ5)01WR8,KWI2T?2DQGU.AH&Va;)=4HKP_#6I]#=933B?++8:?K+SKQ-/YR
Y4(_2Cf9aNEGG&J?;fXD-7XG2JQ?#H&aG-;K;H5&FU)_K4<KeAFF3(+[SIS<fW4K
DY>fP<0L_>-d\.Ef<d;efR4)7:Bb+A)4L]cGEN<J=5,7IC0;4cLbAfM\d]Cg:,b+
65=e=<;/NUGY#]7/P5K&g?4X3D\97Y/0I;eXVTWb8)LdFG_#\_>DI[9D=3f94Oc:
CcgS)U0>P@-1-Zgg=_eXK-[g2V\TaPQO_+)]N(KZGBY<a?;<>+DN37T5.6IS1E:?
2Je=3A@0S<(KN[PX\L=eR:H[c55g]5U#CDR694MKPQb-4]0+Y+=3N#YO<bdTSVg[
7U;g>g,67Geg]WD_eOV@MG]G)ZEe)29L[2.>LB92@(9@>(SfbXMF/\>O1TG8Q/=Q
JJbe]U84N0V76RcA^7AK)DAeL0Y[F]<,[,N4OQ4MYD^9Db,3W@\)-Y/OTN()0FR_
e2ZAWe1KB@@<<2A28_C7WIO=LC-;f4OD?^[5]0VW+VCR#CVBe3AP]1,AT8IGM0g]
9XA]GZD7MJ[0ALVC[_.eHN-#6RQ]I,IK4)3]GM-XZ[C7S2c8)[=:d;K+Cg]<ZR)0
/+gYLQF@.?:@@.)&)&CFcL:W-=_(5e-CX^EHNUQ]8[&92H[+U#B_]I&Q@M\c_:-O
06G6_5KC&F?W>QJd(_JB8-KTG&_0,X,G(c;Kd@g;(PZHU,[6N<ObDB,HAcN/3I(J
@f5\b4R#>/V?J\6Y>>a6gJCfSAYScbg<f2KTYB>W4-._4RRQT(^#.WJd6U]0?USZ
B/]A-SdP=?X2::[:8<#cXB<UV8O+?b@_G1HC-.>.&.UVELSS[DF(c&X:O-L7<8cR
J?F]H6YU1W5I9_6?+eaC,.SR,UTQbC9c2AA^N;VXD&GRZcR7/fBK)?08:?9<#<-c
YYNGO>g.?>PES&7682H+I-N93&=F\KJ4A.76,a>8=H/MVIQ8#\\QOffCTgJN5+#6
G48b=+GLSgY1KQUY]]aUG):FKK@W6L/W7>8IBV@::R\ac8FE7IgYeGU:#YUS;@AK
,A.K,Bd1^]cO1QD,b_8eYfMK5)376#46SdXVa?_95QB].00>_43IZM^42d#5K1Y;
@#O]AeK_\&CXU5J=A.:PRWMb&7>f0=^?Y1-]L=QbDEgE(deNET&HOKG=V_(E)\(^
S+U^9]URbRc#0N&Za>@KfR\.U.P+79N5YS\3f02fR@.OCW^^QTUS=U^=W(?G:YA3
(9MGc8EA\eAX2N12AOV1cYB>LYE1YUZ9c]b,+;<cZ@G;;De+e(3D()a#4Z0V28TQ
OE&aKNZdb=3+,A;@V^D&Q[=0P52b(UHOHf2GIPFJZE8U[QUa>6eg.bTdULXeeEQ(
YIY<XQKM^-V8?M:Q._+SGeOdCa;c;R<VED/:eS>?D+7=2B#,XGae)8^=Z2Ld-#NH
3MNCUO1ON]XfG;_PD_+9Y[I_RF@GCc&#0P]<4HZM>QTf<74F84&X93EbAJ4#TWDA
<#C7#K(eNWVZL6^Lg2gc57fH7Z9f+NZS-gcVH[[5TIfWD;McGCVOdWF=.4[BS8L4
0H04RbB3FMF2D)W9g>8CUY()]7<>Wc-a8+,NUZa[_8\^[(7FB<XfLKWVIB/DBD.-
[19TMc\Q8@3Ee,VL\+DJCOf<3A6N8LYe-)FfT7CK&9>HOD2@g4D_6E7H?DTg@N43
A6+IaH_Q]]VYB#]V.g?8^H5NXPN0FE3^_[-J@--P6e?9XRB.<N](?R]V4Gb++#e0
S22ECJ)^Ca9O6a1CII3=J,7/K3:[B:5A6&4QeC^:g\3.LXYegZD#0O1^;_/5RM/K
70F+_H0?L92T5Qd3dBHM3KZ9KBY\GdMO-ad)@36e_/a@BBDJ[NADPgT)/0?2ID]V
P>(-_[>SW+^;]RF>Q/T^f<N_E9JgbXT2-dH9.FZ_HJU,57]_V^dNQ)^9d:B(XOA,
,O-Xde&4V)58bg<]AK:gag7AH+Y+?D,<6OXT_DeGf&@A#0Hg7]^#g7fA;7EFCX\S
.;KBaW1+T0_NA-f;S3a+R=9\W>J)BMg&WDPP,UFY5/cJd2CA+aaG4d61:f,;GMM/
?XeNZ1[XZ.[XM]._;aLg^;b1LD9E]P<2:c-d>]a.LZVA5F.9A=.g,S7GLL@Q1g,^
07T.W#EPQK]L^(=33F/ePf/De(A:g[/&/A-DJ4Q+X/SSQ\.)6J[5d0M9N\->(5QD
9d.T5:5X<4?W=TSUJd:ND.7eATeebM<bEOM:+/8(A.>=P@I2I>+?-MGH,IOV5I(+
((9eVYZ0#TQOdG]_(-X-RPN)a.H(3/5#N]/:[5GD7aPfa7CP>Z<[ATE;T8#=F\F)
0PLU_V^>(5A?7-N[(G(C54>:E?^XWe4T0fNQ_b?baM&FfBf(ORJA_(V&6:U/7;RM
CA>>,dV_02FP;>GCfKaX0bHU#]]TQFHDe+&_I&N=bN&]T9?3dO9eR#B,,aX^.dec
:GM1JeBFJ1T-8T_(:=LJKHG0AOW7;8I3(g[1baAad=1TM#cKed?-.8X8(4FCa[CH
/f(=GZ)NJTC7.WC9@c@Q>NIgEE9J\^([cd(B?PE-V#:[7]2a&g-U_)]?E_DYFDc/
4IgL0J.^OEI/,d8YM]D>Z;fLC=1Vb#O&8DSD=>B,(55=;F.LXLa&8#Y@X3-Yc1)3
?)J9]P@06#2Me[\g79+Ef+H;0M3&G&1.gX;IG1&7K9_\83:B^Q74=1RAOH[Ue>O=
6\=-LW@CRT#CgPF+\c<dI0M((.,,WVKaCGF0>HR=75RJ3?d4<74UOC@Y;8#0F#cb
BK8R@CYHe-CKBVUJQ>W&509cb=9[<gd6g?gfW;G^C[b+H0:6VBCYB9QXaII()Ba6
;.eG:/g.]WY)P44#,JR>fD1[DIX7\f#UJ]_.HY,2A=>U\7(gE3K7E?HXF5dT+=\d
Q+RTA@]CG8UaMG<)Ta_^:2_aMBaeD?.6>/b_9HX#<Q[D#-^WD6dSTA>0Qd1>d==>
Q5&+5Z.4edWO,@8XROCI1(.084VP]fT)-6J2HGA_B0Q..fXF&46,.TSK,6AY\ZC-
+a7X+2UebD2)]S,N5F8EZa>=&A.8>-K0#3S\:TgCf2P[R^2CQ\I8G&)T,2bIUaZR
8W>eX_51ZD)4&M4#2?9[12K3,LT[g-/=(&QFI_]a^A^[7<Y0.eXY^O_(L\<a@YK4
3TGf<fbVV-K3^]44Q4:W,E:&aT[c,)Gc8F><fd+\caX^L4(<db&+VK3-+#1/QLGa
G2KcV8LefS-V<1gNF,V_<:V3=WD]]J_RTV;fRGW.e2cZ@#d:Cg+@7JU?>GF)40^F
QT^]=0<ILW2HODS1E9X[CXC09PH@bg;X5DYWGeUUE>626>Be-HDYA;#0K86LSCbN
Gg1:a<2NI8_Z<6KH_<G2RD8MK5F3<UZL>_I&Fbf2@\ZRO=]<<9\@034+LX=Cg.+/
#E.IB(fHQ]IT_Q=eU]PKUZ-+/WGY\GfV;Y=K97:7=3EgB#(EV@e7[U2^.QE&T.#e
T,FT5/:JGNT;.3FME38&=,aV?e?DO7O9)36>@,bM^+/Y)HQ;Y>f-/9A#XH,W]]]-
KRQ(S_Z[L7@JVJ9^-R@TaQJVQYWeaB2B^&a3V^-SYPcJ=[&_d\1gR.@#(B+M?4,3
,bY[V\Y&98QfJ/_K3/O+B2C&7/,OXc/RFIUS27[-Bb/U7H?LTa@^5HaHES<f.8e<
GKd.,>?^>TFc5gHF:-cJL#25,,].)G=628&N]_UX_WG-.6K(7[0cWd(8X5S7<5_,
5cI=b6FV1eCBB6YUgN?2SWYNV<-8#RY31C?#>Lc+?.Rbg)5eK]FA3gf@g2)YK#XJ
8DF/\F>N;RJ;a4a\8]R)WG9/TP@Pg:RcgG1(aP]S9.@Vb[.5B?@5/c6:+;Fg)bfg
@e<G.S(G;48.IW87Q\UYX2;Af?#/D/KDUCc5STPI.<,Pb8V)V;UU3ZY74+;c2U#8
cf<JB#(N,6W?]8#DO9N3UB)S4&:3<VZ\c\/W)M_^JB#cHCed@MM5D</SEA8[.Z>&
CV)]6MK&&G&W07c@/ZC#NS-GO:JJQL@/LReSJ322;_Qb9c#APT.?]E#_G>6e97]d
KRgdE\5WFR4c0+FL2(V<Jec9;Se1N@RGc1WVTWNT:Ig?f/R>_S[5a^SY0+;W2e54
RSIZ(?4G=TY_C3)?8[ANMW=EeMF)EGgL@GUP4KOM?#.bAZNaVZ3S]03(<UVHdH[A
87=9:=@8eJG)c&OXOd\7K[_K[C]&JNV,/9N3CRVRa._SM/d/2VPZ1OD<dd\+::[1
gL\3LZT7B[J?=V4AKf,?Tc._//V_H1X:E#\NO.\(4\Cd0>]L)Bfaf7<^,#YW>E>@
623EF8I0@BR9?dIUU5d_6VEeMcVa+.3C<)edfQF-8O<,#QE8XJ(O8ISgVd9P@<-d
_9T=6E9[;_53BSYL@.ZWXfd,D;,-^)OI1Vb7A_D^1PJe]IGY(J1)_\#V16FC)X2M
_5M;IF=]D>A.7KC?Mf.OI(4:0>XRd@KEG-L=2NEQ5S;EQ#1<:RLP_K?K2:?c5&])
47/1VUd3(VgVFU:ZfW\:^29DM64-A=g^^7^F^:A3ZA5fW+TC5d&1)8cFDNU(X#2Q
:.SG[f_MN=dTOBLJ&MEUd&JMB_GKF/6;Vc:#a><BY2550aP?+2B)FH?:GEbM0]V]
KKdID)AU17b-KPI&[Jd_E#2,Y5\PSK-Q-ZAV[YLF/:/^^69a&gJ0;fWe>:[11OP:
^F/QK8J1R^;G;H(4:;24D/KB#4S86g+PN^RfVAYBJ,TLQ1+R@>@]A;e]&9)\L>Y>
>>g4EgR2N->beKEPXK5MGf7#B:VS]?4/V.I-GB2PeF<SISJbH>W3A@:(LXX4+1fg
[B-W@S6eZ&[+Ee(V\GP:5&V,-=]M(=\Iea3142L]TE2V,:?V_P/1[2Y@CCg-DYa_
M:U>UGY\8]BYg2TZQ(_IQ(AGb=TFdbNA(cUF[&LD:/f8[[&4Vbb8>B+WS]R3G<+Y
9,8+&TR[K,;NeL/SM8D,OFI&WG\ZM3KCGN[LSGeJ+PE2C5Z,#435EHM8,^U5O(5O
X^97OI#dOK81Q#6O3Jc#BI+Tc0fZ4^YX3+gJG0:YOR^P_1&I1Db=eUI--ZM7H.E=
^F)UDD43K?\&2Xd32UTgLT>B@FfGOaQ.2J.M6P._=gg(K)1.C4YAc9gcFN-CD+GN
_+QMHPG3C9=DH21V[BQD=?3;Rd,8IJWL4U/f1U[e<I;HB1;G.F671^VXV@2cAg<f
BU2Q;.=&\gY39I:.[&^4+WHK##.9/7HIJTP)E_C;9PT=28NEKH:--^3(C2L3^FAg
63X-I/<YAIO3gP6I])V5I-BL#7XbY7JF,A5TT5Z04Tb<9X0]V-KA5RT]\CZDfg_&
33VaYg6/R.U6N1R6P14K_DI_:P@a5KOBH3Mc/WZT9^YJ05EX;]V7Fc\[IE6JVI+)
@._M.VEfM<A.C/@IS<34ZCd7OZ>Vc+[-J1DbK7cePS6UM.-ICE8<:E?RQ?BVbeO(
V^4-ME#D-V)^d64F;MCR7FV1gEHdBfL#+IDAGO\Q)\U;G@N8<8ZO1b)=b^M45-IC
+(AUdHF/^?D]f.?W5O.:<=\PDR^?IS@63D@LEYfV:5_TVNUU/G)R9+E@_1324L6T
>ZJ7Ld22)SIA<Jg03L4)F8c[_L0HFAT2ELDed-KXVb)1fK^/,OV0.41@)^ecQU-;
7-b-3Q[&\]-&b#,=CdJE-9[.XJ&-<<f\+5HDDQC33@([H=.1+;TRV2?da305efQ-
1gNQR+OY)<7]7>-T+9,OG<X=.VAPfd7-\D?BQIZ5B5\(U+26]<gD;Y90+FPLFN9I
\>aPT_NCV+4QQgcTCWf2_9aIf9F4)c3]D^VLKI63]G@1aY1FefY0Te^9+N;D?BV@
=(cWLbN>2=K.@U5_2CF(5\bYe?W1>[;+G,2TA:-TDC=ZZD6]1@e(2?_)D<Ld_#ZC
[(Q@SaURd52dP85DC0Rd9\U]KYbA>G+CVXZ4e)#?T+R<LRO2b.=<Y+HTLHSZ-DSH
6Z_EK7CCG(:H1CUUPB.^4-,=H]7<LN;LNNP#1b>;,Z9CeN1?21W](/G1@::=Y-_+
>S;5(Rbc,I+]0LH#RA2JR/.P0KV3/?K30MMYUDG=Ae1;1R\O2#J:BNQgGEO1XF?,
fA&E;6#V7B/c)aN2M?6J3gORCPJU27D(<V7WM];]gXddLO0L[J@0-3@SZ2gd1+B>
C)>#0M733M=X(5K#6Z8[<B\#O?,>]C2FN(g+&>\W/^G,R\dRL=P10LN>78]f^]BW
V-.\XF8C#V@YQPK:c;8R3FfLD>]/)3@fS0^EHI.(+&Y&WOH2@7Y\PG^D<PPFJWL0
L^OY]S9R.]5&_d(U97SO:SE8(a:)I?I([C1\Qb?H(f^Z:JVAD>DE]XIL6?c_.a?P
?S([C6<d^I(30JR;)J<?(@QE\BI?g6MZU6L^6_DXBM6==RN=\N(1Y<Z1NZB9Yd&3
2/9NHLW]RDOb:TNKEQ^RV,>BB:8+:;-VZcHGT5ERQILM@.>NZ,>V]#020a>,B+QZ
1SPFJM5R](M;682SHL8^b9;J1g,UIM<U2O(LBJ8HV3449PW#5;0gK0g,/Y2KRA)[
3Z8dc:[=7g39Q+0SF<15HPEaeYdHg4b-DU:LCbRO,Pa9C[,O;=Jdd8c0Bg0IHe#D
?d,Z2baa_\^SURK]a39DL>ASBF/+KKKNZJDTF4JJB4>aS(K5C\]E1#Q0KNaKC.K^
BW\/eOU(G^@(LLa+WafFM:;Q6RV]99H<:Y+0cBJ:J#:-9,b90U)07e7>?SM?b<X&
L9)2K;>12Nae:B(E44F?3MHcA)96e4Ne54dM?_RSD,;OcW+Rg_V0Y5BNffR/eEO:
21e56dM<//b2,6[NdN>#Gd48-[,6AEN:e-,5GHUc9,eNf3e4P5OOKZ\+>a.6^MVg
BCQWU,M_BJ]g+0^?:\:NSP>34W:6/@3fQO/IM-MD=^bDD9;P8=2#f]7(,+P-B2cf
5DG8#29d8ERbe<.-&2UOeO,F),FZWO.G.NF/:6@=).4;ZcF/<86,;a=Tf#R<\/O)
=;BDM,@-bN0?.WIHR6W-?GT8_8S1U510=7.ZWPD9>V_\9:,?gWb&UeI?3]M]U5@=
8Z8dFPRdFYP\WUCQ^/5NbWa(4L0[eMV3g2+eSa[Q?3<#Ka.-J#;U6d66<QV+T0AZ
MYUeJ11KSg@W6d_PJ]9b>;-Z8M22d@FHX<Z[Ff:Lg=7gT^PDN5YQE:@Ec145>K@C
#[Ng05)Z@1D(50]6;DP_@;;@f:RS1Mg-;NTG;XA<f/CfNY3VY1>^1XHQJDK)4TIg
5)g+fSV##T7gU;[U8W7M3c:,.UX0b+c3Hg7WaCd]M#]TREeT&3H(U=H/J?TF6D+;
VcINU^(8g?20WL=-gLR(+XH2-B[U:gU4O(BJcH#W4#0&L\98X,[V<6LF2J^](9@V
dO@SV:R8#P-X[:S[Ke^e2Od&]=TG1UQ:UZe5_JL^dd[)YNPP3OB+d/;]cEQE3BIF
4dAf#9UC+@8(&B=#8Ab>Efa3<SO4T9#SA3I]]G1Tf6?/bI65H.(>1D+I?N2\[e,a
?+MfUH\BP^&P[3\ZfVgXP,<VCeZf]b:a=MM1F[NN5K_^(Z9WcP\>-g029/0N7OIg
+)7VNM:OJCH^UNZ.=#0dZYX9,g[)8M<?+g#?0><80Weeb=UN/C>3c.@MEF@H]+U6
RE_X0HETBZ-6Ugg.6MBeYP(&V4@.LF?;<9]+10S;LO3/G2=Acc\A_CP[N&b1g2QY
>I_R(MRD^0[^S2-@6eZR#D/Sb_\:RGMe-Y@FJb_#23\<JWf]gRL)@PcD^[@W@&g9
.HOO\1VP.I)]Na-0;;ZgD?]QMZFK<)a&130\:1JJ)-fCTQH8X<5[O[4Qd;#g(VBB
2WF\<H;1FN3>G=5K=0SB[6+3FFTA;)RY^L&U-1fP+:d(D<I=?a+O(<;^^KAX>=B5
7:/;C5N>e.]a#BK-baW.D@2[.^^VC5WLbb<#W<d4K4@GM<4M.PO)#=DW/1F\fL>0
aBK92Gd],Y;EDO@B7;54f&7cY+L>OSQG+U3:X62,N5/IH]^+BGK8Kc>83[F=NT+\
@gE_:DCf:,eKAQebGX0<FHD(E3U2>&9T;\#8YT<,-O)KBA+B2[&,PB\A<(<e)GQd
]G6&ZV]89dE^4&6IGa;-/,VF)bKG5;dbPYTT/gN]<K&IYKgG4&JW]?0eNH5N_\&(
X@H(Me_>JTVA@Q/.EKLN7<XC8d?N[OS,f7C+,SO/6=C>_6f95aW]K&(6/Ge.2gb)
#&H6)>Q]AH5(Y#W;OSeYF&gF5S?^I1([TSAc>)QBdO)Hb=MYE)Qg#aN<#,Y/(S@3
[ZT3Qa^NA>@dVRMS]LBF>^U\()f>M;8I:?M7A#)Q-L9MI]_F0NLa^QOW59<.LP4I
:^5<MP:2+Ua1@8-LG(Cff]C:6NUNN^)]8[a]SV07_/DdIf+;BPV4\FQHb17g59X)
4D_7>BMRaUYWg6d-/L-Y,Ld&_X=J_#@5MC2>-aZLYLKQ,:R:eNN?R@=\G])=,6]6
a<ZPa2<[:S?de[A7N=W[8_<0L45I2-1bXVHPLU(R/NT,D[;]>&@VQPe,e;dMD_<T
2:O9a)T.-IHBeA[LJYDX1f;O\c3Qg-ed:BLRTYa4_6;V:9aR6?5FSFA40Iegb<c:
H.Rc5F?NO#@B=cR_9=B+TKPdIKD^de5<X8cNJ1(CX5)#b3Rd6I@[fHNEC>e/e(\(
^4LV:K#B6_#?:Rce+YD2OCT@)XObJF6426XDE+._5]SJ27JF-D8_I04Z0#IRCL5T
d>MV-A)TgX&+AT#/+,0Q:=c61L&#S5/+0B?VRVF.&fLGHTH2;(?52>RN(\^WB5?7
OYge8:,5Rg0^5^?8XTVF/[QJ#=\@^4(fWG+CPZX3X/RGP/e/(UXY2>MA^K4;VCQS
(Z+9_XRcfe3gUF5DE)&QIO:/@fUOWedPG62E9-14;SX&^3Jc8f;@C-[gVKRRY,PO
FWZ@&..-]D3PTGR.Fc>ZQfS^;6N764fK,bO6#cZWD^;:MXYfaN]R^9S;a(D1R^>Z
5/,Q+e-ESS9&_ME7bNU9XIeB^E(^X5V,KH]B,9IbF,=aDZ2C-7VPcPAA>KO=(_A9
&>(M3+=]OLUJdK?#GF=[/AUedCG,KST<(D+f</2,)_-Z04MVWf/c6+EXK#V,b)S/
5fdgbFUGYH#+^?63]VS@FMbVFLL>g&;X#L?90__LY4fc(g5)M-PWY-34Y3b77L&c
0>D1)fOP/)Y&7XeOcYXWRUQ?8dg=e:X&1U=O8+gZ667W3N7c;P0J.<HO1.NX)MK2
d6,F27M#SGVaCLcVf0(gC1/:I_8D@W)3Q.f)BCESab.LA813@dcU(CX^_4=0c3<X
;PE/?-f-2V/&A;7g/D+GDb6MN/S6dYSg@?[YVa[V7M-N#A.(?bQ>XF7cH@RWOGM?
@>]a=MN@2MUO4O;8#Q@)WK2gLV_8#QDAd_#MdWVMJRX1GVb5Z/WU-6+JO@VNFC#B
;+1IW7TU6<KdH)-Y&)[_5N@>dHFU;Mb:P@&ZfZb]D34BJB?3Z)+HMGbG:=8=2geT
:3,G<gC4_H.I@^KU<^Ob/^cT5Qd3fg6CcSYCcF18-=Q/)-CQX/F6Hc#:6/dJ.gc]
P83+N.,#(;Z6ae:;MF-?Y[\;bfSB0L?1gVd4I9[>cNG4S-=]ZZ]<dX5G3gKED1VB
OBUcE1I[99XP1a?Q]/&2TQB\]UPFbAP6JV/<^\\B+^-=6e7TA<Q,MFefE9b]N6.Q
=]V^0;aKJag/6-1f/ATR[g>KWEaR9TPG&ZB2^0,;/Y.6MJ@PL1X6?==@WZ#[V(60
E(61[H\8OI7)S5^74P:ETF2>K/VVQX<;PS.U2UZ@PCFCJ=:SA9]=]Pg&-gG#^^W(
e8QfONC)Le>:(gbEFP640+c:-.U@R(O,BMEFN=6I@V/]J/NJ:34.6X,YP1,-T[aU
_cVMJ3Z7X6cK\gAYIF:S0(B@W]<\KVaLE>P(aOg/CJMTNBM9I\c=)RP=51QDSEI^
CX27FJ9L_G3d_-Z:7HP1H?A,W:_PbXbUIN=U]E4dT(a#SK.X]7@9(+63CR#4WJQL
D=VMAc&NM-7g1-ZSAH?KK9-Z]g\ZSaZJG^:Z^X1BdT+HNR<ER\2V/8TVARNSDP?C
N5<ge4Gg3.?3NF=GP\ObV#b\<J2LTg^];-K_&T9N(?8ge1IM/I/L2bNXKN6#,5OO
58MfZS.NJVN)[NE?1:SNba1PX;U0H7g6(]A2GFXJDf[P#ZNPLC;=/A?a]@YXE]K[
5MWOLSREV8B@Z?9S#H0IO96-33/Z:I<OM:KFCFP91TWL.8cQ;;YR:JfW/7a(&66M
O<1Z3Q(=8O?QSU@I;3G6_gITFO#=;1bHO4c-2gOVeK6==/a<ZL2]-S4:ZZJWV-3c
2\&2.0LfH(8YO&XQE-]\S4L.91DJ#1]9<d;gJe/?EL8F^Sb@)YHN)?D/(=d5Y?P)
7<&205#a3=6a\G-=+2f7P-8ZME.]YBE_GIBFF:F<<<5M_#^90XL=+KI1[>JBMJX7
DJI0/A#)L>eNUaC:5RdcFH;Q\V,?0ZHI1VFX\5U^U6Wd8aIXaVSc24_b>;4bBVAa
YNgc&PNZBeDGc1#3SX>K?(adVA1G0U310)B@D.GJX/[F8E>gD:g97:DO#<I0HHF7
6d2#^2E#6)0B:D50BU34X;HPO(ed#4\d6X,D.E)5QGA;ee?=Jd9DH>E2MI[XL6H(
B7BYOAb0c\Kg:bH<_BZ;@K649b5<W3(UeQS;g3g<QYMF0Td<f56&J@U4V#F[RgbY
Ma=(-\\/3^dTB?;7e5EU@dB<=ZMFFXF^VB;F3UW27;UP/5#0cc[-Nf[PDGXf?G,\
B(b29@NF(59L7^Yd]dAd<&B0-M34Tb4QG+DG/B73,WCJQRc]6?GI6A)bJE5B+eMF
#Oc42T611FXOH_[==M_AdYK[[g1ATaZ;8-KZ)/Sc91(EJ&gJCf[JDTEc@>bW[F?[
D/[T.PS710/fMM(G:A9CJ1;Nd[cH.=f=XIG1-(f/EZ5SCA7HfI=2VaIR)d(,46ZW
)gN11Wdgc),J[RY=:.I@TQ@E^BWc9DV..[c<A)<ZSHQ+Ggf&(ZZMJ+@V>B9?2D4J
,fCgA5X:5UVg21_952dC=M0?U3J)dDAFDKD9V;8[KJL1HHgB33_V7Z9,=3YW>+dg
OU:RU_b)SXMbR<BcE;(;.<GV#/L9_C6Qd3eS\9aY<Y\8F\DUE2]V1=80P.T[LA?0
bCS@HHUUg4B6V\\2__JOOSZ:-JfdXQ&I]-9:WFU0;g57SZb]+>H<V5[\,Y.T2[KY
A?>Ybg:#@D[+gXIKPXc?(f^[afgFS21WP;6bU/1:WD-RAC#Gc=(1.N^6LPgEd>66
3;Q_NIWF0&):eWe#AM/Ba/F7f-(g/OXacHDeIIQ]QWW>82E,U?O#P[dEUbaDA6>P
[>_<FR^B7@RD/<c>D=D@3L>c?D+=T#gVfZg(:K@HJ=JX93=]FR55g&?QbS=g4ONM
a@=gZ=5S7.cALb8N-&>A0XU;a-?g&)d#0_LUD)U2=YUT,F3U+99/-0MI?9(cV[X)
@0dTSVe4=9[d-Q6Q1B1gXY]:PN9.,Y6(5f,X:GNRbI(N.J5#OR#gTNEEWKg)R6B#
&/)XdZ70:M#0QS+AN)JF1LI;IcA#:C26f6F+eXO=8RONWFL-M^5-<VJ:KP9I5^UB
72SX8<73+47[I&@ON=2Cd:KP7bF/#0<\G9Qf7&W\Fa@5KFE,I_(A4Z/HO&1:E4fd
YR&e<WBff<Nc-_=3cLT7292ZN[:G^_GX=#,Od#,\Y[250F=G=8f6F4UYT.FI^#-6
35K]6GYWe+4]eZbXKZ7\#6MTE]dH[I0,JgLB1>#8:PO.M1TePV:gK,AU?4(^(X^C
3M-5KLXQ:\CJGJ2:E_9]2>B)Mf6+e+f,B&#@.Q4+=;RAHTG^,4MGF_B@O48WK>=N
404\4\9)e0.]_223MX?LZ]Vab)T>gU@A-_Z@:KTY\A63)0>L\Ge+Za^7[H7OU&+d
15>f&FQGTPE\MVZ+:,;#bWCCYO7;@?J5N(:&4_@<>^V(O]A9b;b735bL?9-7g?1R
)4;M>;0+/VE-fS7_FKF3[D\-a,()_gIB@\O//8CJ/<RN-/VQ1SE8H\\>7C136de^
-,VS[/<O7ETJ](WQ\]D2Q8L9N+/a7JTVXf\WR8GI8=/15]M?9,QI;J;VS/UN38bJ
=.[#cf2Z;OA5GJKK9T.=LA-0c;YH<PS>CcA2/gJTSG(5Cc+:?E[F]M?596KIV#ac
M&WT)d5f^F+,Xa4Gc+HW3=TP;NCVT/NWR=P:94A,7+)FUa(_VJaWDTd\5I,+d0BE
Cc8W,9bUNS8:+&-Y\>)N5F;b0:0O-<X0)?<3gIXKVQQNRDQB?ca+ZHQOY2dQgKD9
Y3>PM9WXcMO+(4Cd(^=C2&0W+=-7<fI7M6[/I-5,;R^=J>NYL/7#fMaOHX31QP>C
ATG?F[061dHFG0EYF@J(TK^RVFb,6T4c53fa,\f4(8D-0^O.?gf4/=L,\5?BBT9S
G5=OD95:YX3e1Z)M[C,.X8/IP=76b;#=Z3-)EQgMBWH?,;Od0Re7[4<?YJ.3Zc+P
4X;W[27AB?GM(fYKfg(US>BH&1cWQQJ0c7#8+Q[(5IC?G^&ER-2aX#&Nf3SJH;,A
Z>>\G9J2^OU8E)H,>XUFT2dY2A?Z?MXCC,NEBBLME>T?P(\<(=H^H/UP3#48-+g@
=R7f<+cLeS#=&YA0&\KV[OK)4NBKb+1<U86;8G)Zab)J(RD.[/-.#D7;F\K/M]X:
?1/_59A\Q,Aeg5PC6L1CO#OMFTDa4_MDG4=5ZZOd32.<A<MPf4(2CW(EBKVU8U,=
UJL[gG;&f[cL53AZ7:F/cC\[^&S#9Z?4/_D5JGdOK(1>?WPT7b_KX@VC4EbMCd/Q
Nba/<W]^E->b3PZ]6P?5RC&(^[LCebC90K[WIf+\\(0R9e]>dXMK+P_7BR=72J>/
.C5V2N_AC8MW,@ZN;f95Z@RIOG850EE&4AM#7WT\F,SBa#9;IHDaSg1O2?LcT88J
V-R\UG[>?5Mc.-=C>ZZB\E\^.0P+ELAW7=FT0JP4[>U5dF5<XDb#V-L-GRSgWZ3O
^@^9^ES+9dEaaU+0D=0W<J:.FGU7HcCHb&1VCK6Z3O)=[N#&46]#6R-4R)DA2F[,
?EF;L&3+?T\a7SA3?c[J[fQR^,XR&Z,.#)VSI(?T0WRW2>ab:bKJfD#C7S1V&;SA
8J]3EN]Ld4-g9,0[E,9(1:[#GV&48,Wd,+5UHH>&O6&FBWc4Z6#MNaI2L;DQ/9YK
C3LO2V3_K1d3:a:/aGcN21_;LNV:+e4(ZaO_4^S9ZX#7CQ_:(4V05KJIFE21&J\^
)1BRI7O[7G7?J.ICI^d82ZO<b#G25:,>51[ATHS4KCI,:CLca1YgC0,aRG/+]IZe
&Nd#(RUOZH+=Hg@faDLXQ>U3[@D7J/;>23<.)#a>VaB?RVU<F-+c<>8P:-a^EC6P
VPf?BM:0F>fI=NCR8E2Fd,U_AUX8cLd3W3:@d&#QECFe[.M^Ncd/,X+0dVV40Iaf
bC^I+7=OdU+<MW=C=]A/bAZ+?8?f=U5784].K4WY<9]61^,)bMd;R[aPADf;RggS
?Q.W4ERb)&#KgT=MX,;fWYQYA\U6)39AN10KP]+e5^=8S>gaZKMYB&Cb7E&(ZF0)
R]JEe)Y9YO][Q1Q9_c&],B6;NG.=_<UH=e7dXSB7_R^<UeVL6NGQQf23NQaWT2aM
7dOR]=7[U_9LDA;<GOCa&DKO8>G<E.ANEc5<9dfSE@]JYZgQOCc[MM0=d:Ya7#aB
AZ.WE+G6D+f;Y(A,0/EAMV1XJ?eVD[cW1Z?\]O^OTSfTKEXS?6QaCL8UO2L;>YX-
^A&F,GV[--b1Q:QTV-c.Ya7V00CYIN4GW1\0(gFV[;c[/E8Sb-D&^aVRK+@8G5L6
1LY.F/AU1#_5\0ECc[P_1bRbGWSf/Q&17PDKZZ#;-09BcM(.C++I3Q&1LPWd7XV0
>?2:G?=Ec6_8-LF?_QSg_a,Mdb@20D^ZV]6@,N^4J.S/73aC9(NC?O7)9We,VIX?
G_VKG],/b/6/M6/]X;MGd-M(T5c&d58())g#=6F;QeU<13KC1H(G2Y#\Z\YDQW-K
FZe2f/@A/U5QZ&8J2L59C#))<Y7Q?a7bDV]LY)b>.cP,RSEPTEVHPEAPN7U:@#7Z
<b_2Z-U,F9dPZ41_f4&L2>dRM9+5JVgT<&-JQ1<JXfA)aeT\/3<]b.<HD+?:)eCU
DN1.MI_4DX1agF)2#X]JAa=S8Zg]8QVF[;.Na0,4LB&;F<-_J7\E&K/^K&eaL3YT
JJSR[)<>C&.d-:^RHe^Ob0D?/IPNe<YD3A)((^UDP&W_RXIAU>407)UVRA\L&&2B
4F]O,K_<L_#RK#5(_eAH=bfB0FKHC?&Q+Z=+4XMNWdc_;T<&ce0#P?L118c4=TK<
KOC8^<7/#0E-D\Sb?Q6f=-7F/A_R_bAQR]QN(bE]eAK#/IbQ<6>TQ.E_:[G9b&R=
2gCb(40XTQ]M?JJT79<+5EN>+G=9N8N6UJS/8IUZHZ_KQf]KfYVTQfUI]IZ,Q\d?
D:Ka@>(LF6/d0:]OMf5+6&237V3(gTL(C_H1IW:f&>_,WW1YTRX2<.T1@gB[,1f.
):^-dbY#1MX1POBQD(CDHb;L7]DFQ@ageGd_1SDHP:UC&(GF;+aT@(Yg4,<7DU(/
J-4IYBIODXA&6E9ES,W1FF)U-)&D5JEdB58Z7YDFMe]fWKbP;G6L2+YG),;20;TO
#+SQA+bQe/a1BV/KUKLbcA&4F(L=@@#BVW&-C5Lb@AP4DB<D^U+09XJB&AG^<8eO
eAOK?2gZZL)\=fN-A=Q(7<1ND&:VU<+7;CGSLCQJ-RN1.-5KW/2</>,d4H/PW@Jf
W.R>[H8ZI<ZcLWX#>MU433GESB0MOJN7MUPX6JNef_Z#T9T(F-Ka6gHKVd11.&JQ
NF;):a<deOG8X_QWYZJ[@B<7WQR<A9QJ]J^PZ./f6HH>V)PV[7ULaN/K=]9(-;?9
L^Vc/dB0ddgJJ@M<BX5)R&A<Sbe]B]BYMFJe[DDa2@[BO1(+a23Y.[_U6H1B>OZM
g,DJE-[K&/VOH0f?8WROaQJ,O+gdKab5T8Bg=a,-\D0+Uc5M@[8<f9]F6ND8?K.=
RJ#1bRULG#d#fP#_3SA>6(5Z/eIN-J=9f1a:YN@S0Y9RZG=N__+3fF^VU\,@\C]c
Df2MXADXM\b=/?:I9-+RKZa4&\4DeQ,D^RW3)Ua^&CHMa:96U>REOb5AbG_VSA3@
?VgVUN<e<+)K)@C,W\BVYCR_=0AAR_@T7H2+Z><DF7K4f^I7[[/<#6]Y>H.ggcUT
P]5d4G,aQGe==bf]+ML.KD<T4V1::L(IK&^\1CC5Y4Z+g3E4,S5.HCKETIC7JfV;
XN6O_-^M[bC19]994b1F./[S;6f]<:f&IK6<a4<\)Y)8N2\\0#B80MF\4F0MKXe^
ME_)a=HX_eZeDbBFL5:K&F(7.,DEB9QXTZ6.a-9@(5,])ZVb#,3P^WYX#aS6&,#\
1432&KYI]cY@QYK(DJT.Z1\:BA<b^R[E-4:eQRPeUV,[+?_OQHd)DV@Q<>eIQ1@N
AVPQS+5(S./D40B7/L9<X.>C@HgAa9X\6&EX1NGgI1NL)A6ac<YT_)cG5L9RA3FC
geA;\.T08L=(4d&^S)SVKOBG<?EYdU36PN.ZBR=RIT62PEdA(7=Z?G?MV)B]#ga=
GE:/HTBQF;9\4^K60]>:=0\K7[WN\>JCO2LBb1).MYbZ;2;AgKYTfTO/E(eg@7O8
?[c)G3SCXD+>c)9c\XB)&I>P](aQ;#TR[:^3BA)ff92Q:A1^AcXDd_U=[/HVB3-;
73dW0Te?-&b^<5PBCV>N0BQ\?;aWQ^b01/:8Z03V]FIS1;VF0)#5e<0QeJ?;3.D>
3JNXA3O(cM:F#+#+KH-CC#L:F:bRX[KO8I(C?YO1ZOD/@gS\(6BF9J\+QRCfb(/7
USL\3D4#FCZLaXF4TY3_?_07@.-J8&:A<0FHW8b,Q_C4(+gg4-^G/(^=+Y0)I\BC
eI6MI1S/JU-f\Q7^D07&2#d1KWFJD>/X:(LW2C0P.\I.+0TG/b3HfRIY/5A>ea\W
5C(;MM:3fVU&L/(L)04gA(^7HT\._@CX4:Yf\RV.J7@6]S.:a1A0KH8D;&7LE?\8
H)B(=[bKT3<GL&Z,b-FMgeG7#D;2e5E(M3YW2I_CVJ&>g\KSd)M/Wfg9RA..c6)O
G(OCT:+Jd?WKX_U34RA>NMDH&4bV_X__,eC@4?\CY>USMI>X,^W^M:XA+GMa,E7X
6C75T=<G4@,K&,D:d52H@^8]JMGY,LNcC1S3WV74Wc]Y&U,:.;?=L);[-Q=Y6M3@
8/XS.4RS=2]&aeL:O:60=-Mf<]D5U1DI1-,e-8P+HAEQe^gd)-SD[(Oc;7Z1S.cg
+a9)L7:);CafQJN64>WL;HbLZLf8?fXZZ_4[:6O=27d\9,3;>TIF1;7&VUXA)F\_
L1f1)\\OWMa//7;gJ\WL8^gIS?O(J[@7e:2A;#?c>2W,_G_X-^0;gS:M3@-V+N?b
PaDO0/OXF2eAGO(MRL,-F0:K>I27UNE#a3;BTGO:F[&dNR:8L:1EJ2a(FFAa(6\D
fDQb2Qb>BSZ\b1/+(,NWMOP13=gA9Z-_H3U)UMA\H/C-:Y(IW:f+VPC.EQ<CSJ@L
,Yb(bb<&\4@CU;:d0JT-/fO0(Q-?G-G:]KSE/g(Oc1&;9EX7F]2c[Y-9J15&.WH_
D2ecM#Fa1GaDU-[SY\0AC.NOW2Q:>RF=(6He85S<P4fMR+Bf4N(CN@8<A4];LCB9
)([+#(O=<C_La#DTf=LcD#9MDL=@C91+a0^dZY?NeB3(BN^?X&JLU#IJ@_2;\R@3
>KLE?-/.2-#9\^=ZT.4>b:SN)cR;[^e(@^^0>]I?4;/efUd@O[-Xg?(bQ)M32;+C
[Q\2-dX2(bBc)?0HYcJ(-]+(ALbVaHPMQe8=C\2HU2AeeEd4dV?UT.aT:3I0FI)S
S6KBG>9\NA54MY&(?(13\\F0[H[],4PRPHe04)a2?X^\cEfA(9f8I509,WCLB3&3
66G5W=OK[b>^##,3EfZfP-fT)_2W0[J>9_2?I;FT>bC7Of+KC4\a5cWAT+::]8e7
-3Fc+2)@4eIO<c2/UCPLbBcM/@B,b3\EHP:_LaE65N2Oc?6/CN#JS_^3EDYO=d=0
+/SSbAgCMT/@(3>\TO8O:.dP+Zb@\MU<9SQ&OYE,<3W.+bFL_3TG.V&-.J8N=5,b
E:YB2[EQb/>5:6eO+(d=C]D7L38IN(AaIXEFG3P49)JH14QH]/@M(S7N)QAQ808Y
GYfLN0)Qb4RaU8W57b]JUM_FR:J[C3X;ZZUXIQCNWD0<;ERBY[D+GE(B_AC[03D=
[16HXK(51GP7EdI@;(EX+.#DP,[U(2GM^VgfA)eN@>DALHe+V&G=b&ae_4]&[S,7
c:Z94)L5QZ35HZf0^7#-?ZI4N,@NF1DgNUe0dBQP.QV+?B(_\J;GF?4&L&2bX4DE
=&deZ/AaV-<bMX@<e>6+2E4WB.^PC_D+^^C;Ae)89YM7.UXO9+\;+9b4GG\IRAaP
OdBEe,Zd4.e3Z7/(Z_K4=JS3#]4<A(3AYHH>BE;f-U]OV=\B,&XVKTGXKB4Y;/1L
?WE3I=MJSe,HgCJ)3EEg.P6F8g75WX?6C9I8e_OIX4-RgA#IA7HNe3OISH[T01Hc
/]#/<&2;K>?I6GKa<(,^(R0+#gY/gBKg)dV:VO6VBNeLY3GHNN?IZX^L4\@2Ma\?
A5c=7\T8eH[TSEX_W(&BgD1_<B[dY^/SH&IGX9<AIB@3KL5D62S)f.UPW-ae=@-1
28K2A8]ZS6aU=KVO0VWc,_Ra@Rc/a#d>]&)O@7EL1#L/#(>9)21MV?[(37PRGZ0Y
?aa&,Q5I9f1\-NR(_KQMC(;;9=WeP0NI(+I/U)96^?@(KL\J:>(NE4Jdc9eH[>R(
.X#;KOE(</g;+KROEeYD,0LSQaX^/?OW:/O1VUT&RY;97d)YHYdO6@Cd]TQLS+T/
[+?W][@..+J++4^M^.JcP?0](#O<#aaQ[W26K:TEHO4\bF7&6_V7S3@2PLcN;@D#
c[(<)T75]#8F@U+<5gXU>#+KPXDV3C,(d,YJD?0N5_N]Y<TdF^JB-7;3]S;6#g]C
N1MSZ^FPa2IL>@CRV1&G3-:C<_79++:VfN5<J@cSOg9<7#&EaK3Nb8QdT6M(R>@K
N;b;eF:[RIE;6HG7?Y6;4B3,>1,Ff-.U+:F.48fBe.[dT&aabMO7OXP/)E9H[Nfg
H)6a9J=adc2D95D>QO]CCbd6.OXF7I#9b&G:f[J@J&QSgRfa<c5#W(BgG?U8#EgH
B&=W+II,a6.+IgS3a2Tfb5:cR1P8,<#P-MU(8\;Yc;?W=^XYM@98?e#,MJV5I.E.
R>D24eJ#IYF7=GMQ:P]b40-Z,_;01[cIGUH]O[NK7:Ca32&TUFAGL0MHT.K.EG7;
X28BADX&W]U#27X8/>J?<[FL+85V1ZAP40BND@@M<4<<RX^UJ6A_A<,H7-9]F9,H
^]d@OP6d\E6@OBAH-@M/cLBBQ<Fbd=MWQe:>LDSB8LW[-U;8)Ba=HQ5],1O#8b:G
8g9F#a6\eJ5;YI@_SJJ2M2@8O93H]g<ce9_RWDc/YI.QHWc,?DRdbfK_[U;7^:J&
JM9G;27/c/R/]+TJ^ZRTbNP.#2K>&XL0Q_cCPb#bCRG+@&_#2J+bKTKL/)VKK2])
LXL/XKW((NO@,I8\Z^7;4D3BVH<-^6S=eV1]8Jc-9?SZ]2B-0-A=<+N8</LBg8TV
K5ZGd0>WA;;)CfPCgJLbc>P0(d-F;9&\c:9Z[NF_Y6TV9\<V]cR]_9U7:;IL?ENA
OW(L54gZb..SIF&^KJY-E4dI\(e_NZa9c0a.&53\(93F^Z]6e=X5ERW6WERDUbcV
[?_K/]#WQ:.:c(X4;[fS9fGTUSIU30GZLM([MdHY)[W_TE,XK4_d_FAcQ[[&@,)<
2+c/;,gOFK(7X:#9IL#eQ[26GVEg->B;H4:6eFF(6-&,>8O]Q?M5[>N3_W)d&_6O
&G>d@0T8fE&gAIe+F&)^U3&[c[EZ?g7J6Bd2Q96>=1U_;/:JUd)G?/1Z#,d2:AeY
M#,JFMe9I]U;K7&8GGc_@Y<AfI2YA[faDBaH)#bMEa(Ha5]9OW:\KaaePB0VEW,E
=V)2?6;YVC?K0(:73U10CHLd5Xd9VZ9V>\\eb3f8L<[M@H[N)#A+[/>eNEZ@S&Db
[10(RRH_[aE<9e;MD&RS?cJ;VG)G;X](^8UQGEQF#b#>)(8&/TSJbBPE]dTU@PJ,
KB<AE^CR?J_.^A,,K))U&fYZ10G\fO99R=VCSZ((=d=>+b@GAgeR:VX54H?\:&D6
RWK?5EdCYT?SZ0PEO@;LF9[(a<a^+a>)Wd7F9MKZYLTJAcU\BE([a]BKOHLf<DV:
0XaeY#cR39S-/P5E\^cH5F:7(FKW42IK/X01MF(c#/U8eEf1.@8D.?IN@f[=9VL9
15^B,6LLC^R^Ea8;()gFbDdaa&A(RR0bPQZ):5EH\dFg#+NX(W=;EdI_^&48U+?H
KV9g^[/754),f]-Z(9.LRXIgL+ZT;\NeZ(eTdK7NU4-=6E,\fJN9f5c.8/G.?>=8
gLNa0a4TcJX?:;=[RM9+=JOC_JIaVF<UZ0b)@XNCYbIUZ>NXIC4H9^@3J..TIO<g
\8JA,I4VB=d?b(e3):;\bgU0UVQYEeC/H]@VWOA&(8ER(#?>)MM1O)Z-\+>VTFB(
8FOFQ2UY5d2;)5Y_H7e35E30RNUK@B\VP?dN]J_,^+]72EKOJ40M\H2a2P:@M@gT
AN>)D2<M3_+bN-(+V_O/WdaE<d>J1>X6.7ZVJZ.EI?MW//#,-EQaCM\-5I#/PBde
6dQ_?]>]MQH&c40H)(@RU[.]f4^3;OEZbMge6TT[:87WSdWBW2+0^K[VUX,PW,._
EN@HSS@-b^2WOQOA[#I>10eZFC)?RENd:U.#>J<d6;]#XS#:AT(8[T/AN=VG:6NI
ONUaM\ADM6UU;Q\gH13J)c_<6ec#DLX^:f7D1;_>1/N)\5?I=I/+@B3-(0N[8?,F
##,UWHNS@;^WSWT:MN272/^>O^b[fPZNB:SQC66LBebN>,WH)Me0;5(U,8C_OP+_
d0#(Z_^E;9d=77K#GRdfEGC^D>PM;<8_I3G&\#SZJTNQ:FZ&XQ.[7gL2H0XRI_2g
[=1NbLLf.;&,Egf?+GB\H;\Ie;eW9085#4,>ESe)+M\\C;S=--aADV:^D<IKbAD8
74BW<Uf(3a#S_[-0H\(_?CXLQK?M4FM>6D+)fO\6bg@,,7+=JAa0gRZN[/)6Q61@
G2U?5/Vd,V1)^Hd=X6WZ@-M.H?<S3P1T+7XG)O@2J[eXD)SZc+cN/_,PYNe9O=,4
?(g0>8CN.9/BeF]#>[D_2Zg2SM23N[>SC+ZW,9V^+0/R^edUI1QaE<.IGF:WeY2b
>9ITR-]CI+bAB75PDg(MV3U^R80Y8U+4=L+<93\I_c/T2[G1OGDffaS&M-Gafd(F
Dc^BN,D?Q]]L2^e(MXMK=HTXL7Z6:66H?#X(NZIe2UW&,P^b?V4c]^0QQf2YYeP?
PUB<4_7@ZNf5?0(#89=9CEC/b9,9K)1aIL(G=c#F\4KJRPW]6ZBWY>UX8XTW9.]X
]Lg8\3,GAd-;Z?]f3dJ@L,B8H,QZ8T5TG4L,ZAAT:b@DJ/<fIK,ETD/YF>GA-A^A
7f8IJ=79<.V7_2MCNSOFd-,DK/F0WX>R;[X.4,Qc_GX)V,2EQINYHEQ#_5TW_-0Z
CLV.<TQD].E7WJH6/J/AFP6J_OVH6Q;>.+[XbS11VU7<@dd>U=51>:1>1BMN,@]P
;08;38:_(U[Mg^?<)[^&X@<Q,.E1d)bag?6(.+f0/bfDEO+#+7;P_?^-D6/<@&Nc
F+FO:RF3gW^(E/NCM,)cJ?X^H9UD7MGF_9(DV<O2MVaD-6.K,M1O7NbgMKJf[R03
0VRNAW:IM)#:>dO==1RGfK+/6;fZ85ZZY6bM#)NEfA_R/]Z(KASfU]=c(54:CaO^
OK79,;L6f2f(BV(^A_a56f3QCLdcUeDND74OZH>BUV\cD84\E/_)U#B.55^808?9
TQ>EPegQARV2f]e12@)W<gI93,4(OCBH,W86X@8BbbcXH^S4=:=)W;BT]OU\S)^/
^5e6gB4fHe-56B:,c-Nf2M0/RU#6La_dJN:(F2[U>2Q)FVNOc]B7AO-A>.;+R^Ed
E7);<&2NGV76eIC/8XBX/W)R&AV<NN[]\K,PKK<OORe-_,d9SUPDaXA;4FJE/_bJ
dbDg,f/HcD)<=<Y[NdKP;RGN5?E8=_8e,F.E_efD:IfS-I_];W.B;K5-#NcX]3J3
PG>;cBg.?7e>M&ZCaD.N3?Z6UgPd\@7]ea[<NAbaMOeSQ&d9,Y_454S.FX2<f.-E
(Ng\a[A+J](&#:X9:D?M/1U^KVec7&U>0X8E;2LMQ#UWfb/K4D;NN50G+GGd<U^f
)_ME]B;VBZ#F?9G&GW;;4H.CcLRN7c\gaVRH#bT:NbM#&C(FC885U8FTP#RO5[8.
M+Z?,WfX[M&PB3Z8H&F8QX@:-6\3]R\>fdG\UFeUVN_,W2fgb-VW<_:(2.f,?JGQ
>c#13W^^>]?>LVSWR&E.-ACH<X.QIY2Q<).E=?e;IN7R[/:/e6ebB\B\=&I#(5)N
058N5TP^TE94N)#KH568^Q(fB\e0^85LeP+9&X]B@3&^5-RME@EOe</aBS9]UMD8
)_JVX@=&TDVaNG&<E/5Z/,1:&/PRNUBV3VSK9N=KRRGU(XKT5<DF60VB[c1:+Zd1
^2;DBR66U)d@O7_5+BM1UMJMV54.<I[;ALDc+_g2daM:aNXFEKBYW/+^M18[4cQ>
PQ7+d>bIM4UDZYI)^ZN>=74U_b(Cg?cR,5Y#P-62bg=.O()/QJX=6PYX?/0B37QI
V=6M2:./[cZ]cTN]TO.=2RZKSe8H,4DM(g#JB6CJ5F.4IZdaK7KeZ48.)0)0e#JV
T7eSe=0+/D3Gf0#d8YF6Q7:RgETPC1>P@VV8=J@cK5DX.M:CQ2:DY:+CHM8OT4[E
U,Y,]Jae^b[SM#)57\4_f;^A5?Q,&^E:&.C@Bd:.\Tc+?Y:Hd_NY2:4C2c]O+T\V
ab4+DGU.-3-B;M1[MR]Y07M(1Y(RTHI.#ZU#FC,48KE@11[\MVSO#]UBD1=#IJRF
f6-2KT3C+F\:-;.@cJdB]:OYQ(+2/R)O:g?B=RCM5;K:=GD^&g>K(ebEcGadV576
B&_],Ne-OgT^2N7S76[#bgbaLS0Vg(I:L5Y:a,QBb@RCS1H.+KQN:ffQ^HUT^P/-
OENVFDEg7>R]I^PNV8Wff+Ff\2+fX8&aa0=\^)S=9E7:(d7QXb/cWMIJQ&UdBc<Z
-V;LGUX7QI^2KZ93OPU._dfM)-L;Q?28MZPg?^g::+DUVB]Q;EQ@5?f@dQBH&H8:
_DQc+F3I\&<D:e&CX(>[;\]#:;;Y-;C+7ZK+P6Ed_^CJNIH1bA2(YFgEE[@DR)/>
&/CQKb;Mc7#5>QW6F:=R;[82#ZF^Z;A5dX7TZ2f+Y;-&d/#6[2J23C9-@F31C:2#
8_0?.&@P=>FTD<AV9^dX-]7Y6NY,1KQDe<<R<LJ6_/?^2K7>Hb45\6?#A/N?;JXf
BVKU/d#/@^dY85BW]IU+)1;.P</&A61J,H/Y[7DN_#K.D^&3+8-1IgN1AZK;8Vb4
a,/H84a7R,#@2dIaM7,(-8:V:)R3E)\4FE.#\@A0)XC10I@T[C3D39_<:)aY[]/.
]/WN(7^TQ3\)gE)NMN98_aN#>V7b&fIgdR[0U\O\1Se^V95BR?+DV]>K=I>4\;67
G:<<_c?2(1c:e22W.+N(>O7EA)a\fYZ^\P,IDI#Y9ebcf+/;L4:3@9a=RRd,LOa+
CaCDO5;bcW_<+cZ^^IJ1.Sa]fNY3PG^T^a1VeR^ICeK\&UUJLX[[_9GgMCN6(VTU
W3/G+ObT.RG]ZN^FQcaHET>4>H8.H^CZ7V-4e,:U9T[UUM0PHJI>5f8dO7<ECAEW
_QgAg/TM5HNF[G\D2dADGO)44\aU>/+J&7;#ZYXA++8Q5JCUc2:FJV_0[R]#IY-_
UU//EV7;0b7>aDWLH_^3;50OO;E3/R/8UY9-&#Ic9Ae39g)4gRAL9dMA&(2G_\)P
41b^8#7(2fL4KeYG=CT-XEGDD8De<;Q(/J(.NZH:0RKf<1aXVc2)00QTH=\DA8I@
[LQ0IEZcb7HVa.GETM]RFF>//EPJ0VB\5(A[TMf9-_M/:LHI&dU.Ig15G4B&6=WO
g1C#B3Hg5,WM^?C)NQ-</.TB8&R7C.6Z(95<J2:\L1P:G7-gEG([UAX;\EKD1,+G
#A;/c>2Z(B^G[JPb^f<SE>e+@/QW;K8T?UC.+B<8\-4:231>=cBNES?9KZT=S3>O
PVG#97J>H/KB2=/2<8-g[>S#747_Z6]UWd-#JIW@7;58<LTPOB&#H#D1g6d^F>@;
-(VQbRG]+(ZOK,=;/?7[g/Pdgcadf^97La77ZJN;MUFg4]OH2DT(I?(F06X0C^AF
FaM(<\VJJW4.Me,I9L=T#UFUc7?;:>(I3?_1UM]b,)[BFSG90P@>c<D^g^/IUF05
1(0Bd8-RP[K]O4FO#+E4Z?G4QX4R8G1f#T3X@c,Q5&AEJ\.N<O&&b.c/@)G&T>-3
3b0#&Fd=TgTBF5eUdQPDI_3/=OfF@ZdgHdUK8]EK65K[eQX3135:G<#@6]/dCU&A
,Z7E?1]CJ<KK-STZaW[/3?Rc,P?#Ne4=2&?,-NgP@=U.I6=<(:?e+#UB.(P>#_F_
ZPaNKM,BM5\J2JH&\g_:),SgOJ??Xd_#>5620LcObg]3BN,(#Ga09g^,RFG-V]/0
8V>a,=V+6O=71@3+A>&V)-X8&^fH6SWW;D5TR[;gE3M3-VJ/_-Yc7+,gE#PV2>Qg
WPH/U^\fX\a+8DWYe@9&eNNVPeU3,O/]=b1;:+0&a&S6+cO+@bP5HSAPU6f^,[<=
P(XO1ePTFAMEcaP4E9YQf3-g=LN/<QgK#0CHTIYRI;O7dW^UbJ04_4->;Q89:G?=
G_CGgRTP4:f&CT)ed^Jf+TO?2LL^M+\81H#KU7[S=gE6,V8-We^HcRe4&>L#]gG^
^f8EaH^XaA_g4-HcH,UTG>1-,-DYE)83RRAc3e9X)OUUP^/O(fe6Q]IdUXNaFYgb
1NE_gUCO[M-MdS=7=?d6C#.]34-?^@Y5<HKLVg8,K-?+e,4;)VDfA?HLNI.7;^&c
>N+X=:\GVM_P)Bb[J-.[[d77Rc]CL#TY-^]cAL=MXD7-WEI:-Ma+_]I,+N2VALO=
=]53]/6LfS.Mc+SEHdRI9g[@,01+7>JVYb@R7:J6GVJ;NSZOCOGA0)</-+7-BBOK
Q-E1>G62QeNL6bP(?&FR+_bVE/_]X]:g<@AgMRP[J:d?L\UI[D=:Z]^]VFRPNN,@
C4S<,a:<]#^QCLX@8&NG=REB#30NTUC3=UdUXgIg9VI2Z+J&<.LLMM)UNPaGPN\?
3MMbU+_C]BFX)_;O@/J0(WVBN]8\\))Aa?T]71&418,]:X76.+3.@1agf4#@BXM-
RZ\QV0=Z<</1H8][HEHX2[eT&U?:FI&Q6fY<&XQ>L4NT6&9;5<fBUHSa?KdZ<Z@a
)aZ?XU?4X.+Tg9.<&XAT<UBE)CAL2K6QgZ51S4H:8VZfIO[N/3&0f_5J(H@SY^W5
QT=cHWE^3T\I.7.^)bSHVc7Sa5.\\3SB)IEa5T4<I\FF518Y#6e7FBV4#8.RQLY5
U]EW>TPZD0_AReC+2KL^G<bMSYX.+8TSAH_,DZZ+Cb(9G\#V>K+CaLL)Jb::4,&5
36)?P1bE@R2(N3^7aSbTNBGI:+Y-Y82K_IM(A\3MaYO::+UOfOG<);H_1b^CGIO9
a>Q=5;(#80<JfHF37-D,[Eg+TNL9L\AAF_YD?J?[gW@U@(#J;\__=6,Y;f5eMSg5
c+<F/DM;RXb-ee/Af4U.,F&UBgUMY4:M3PM#3bJ<3MGJ7E4ORT^^XR8RYTMEQd<F
D3)D@bCPE]B30+;Td4&>8+fXVT4C1_7>cQcFMYK,3FH)cO,H+50bIOY3M3XAX-c@
-IUGPHBb6.\0d^Q\>WA(R&;JYP.P[be(NE_,H:=,McU/ZF5A)C.>bO^BPO-QE:Q>
,,P41,U>FBMZNg0;4:f]eO(291[1Wb+Cc?<(5[]Te+X-IHfKT#8?aBUFJ0ba@^fP
X5XJdB[]5GHVUeg/)ATNJ0I:JB5d3e->0#505B&AD_[QAeT3R5Y7TTG4PMAH8R2W
#E5;ECKKQQ>WB^R\KJA<CT&I2K:SV_<1\Zc@6=aO=3:4(=8\,?<I(fBbPZX3_O8#
)V=R7XB,Y@a0UY4/gK8g0CQ;+CdGX&B<VF0@@\EZGJ+dZ^-H5DD5ZCb1:[Z^9A;0
&N/?Cb_feX8.]7U]HaA@fIbf)D)RIS_2D/fQ@5-\O1KL#RQ7?V1CWB]GLBWLSf#4
-75C=[HJT]7Lc+YIJgM[=>gPfbfEee,<7@?/;(/SGeQI4R_,>Jg[U(#c(&f(dK];
915FJ@Na\Z2SUPD21/WRSb=N-)GMVYf_U1g7e7?ULU2DBG\[8H(=OV9c@>UN9F>K
._Y=;5\>,R&P3ZW#eJKNZ<7Q-OLHXFcaa;OREM?Nd(QKGb#+5g63]]P9)Odc\)LE
.CH>+32:4e3-e2?MbCJ47UJ1\0c6gfC/,Jd/YPI;eHNb?7C\I#FNd^.M@TNd2E,/
NB56.MV<6e.f/)MSGC7@J4L=QA3[,+28USOT(Eg_]W,T_BBWGMcYS@bKD4]7\#3c
=4dP1HP(/eaW_MIMS7/8JN\VL2HeV)@(&HT/A=GLDXA=dU1NM6>1PeFL6E#/1L:Z
FU#=e4Ga[=,8K7dP[A=0F(4fQDKWZ4;Y2=fBNGBEc=8TCKFA+)SCPB9?M;(eX\b8
a5+G<=@IgLY-McR9MbGH))U]DRU820/(^/._)MCf=.)/A?F-F(Y;KGMI]-e5<V>M
I;bZ,U9((.@:SYX5d\(.9(]cbV_)dDEEJ)/C^CEEgJVM3)0#ZS270F#3b)aF/,47
TL(7FOFO-M3LX\YG9g#IF7(d)4A9g.71OE0MBcVF;42^Jb^_22g:[<,__]E:RS_:
[Y@bCS_<D,;-[JWYPg7U2E.:L:U1Z_7146LHS,Be2&67MNH?<(A0])DLS@QNdIN?
;->6+1MZB1/]M_GVgSLb^T-20cPN+4ST+30JG=-@THI9\A9=ST:])U_e\?e=9X6T
7ZaOV7]&(9\I94S3ga[C[?N)(1ZTTCYcG;/A.f@BT,AF7(2P[RXIHg@<?-]6>J9V
IBF&U+cc;dI^e:J6A;(_#3L:TaaffaXB44?Y]g/QWM^aAeSgCJ(W83AUEgdAS)Ud
6If]>e1/C+^BLCP=c>)-#FF^4eC[]b5_abJ&XZ5La\IS##eDfS8:SJAQ(;=&9RFP
DB0H6aW^9A_K_F@eTe.UR9E.^_QGLJag@GFUR6UBCI4UW>B)dV?49b3Z>AeVBSFT
-fTG]B.0W&8KC/9_5APDID;<)Fad4:MSR;F+@2X0M[H1FP0eU>1[IVA:E&a,YC])
,=fNLaFGEE:72QBSgUNBS,PcT@&G\5d;(RUXb5GEYY8G^K95-=<^5FJ7A+0F(Q>&
bR+aC[67a5W^8&^C=0&:WHVgG0=KKaVO)S=#UI>QIS)SJJ,#DTA\HabVO;LEg<@=
U,F7Y,:9P:ST5B^:bbP]3WI(ddLV^C9;B7W]SQUKCEN)QH>FDU^K:?.\Yf;\gE1&
PV)Z[,\5d7cTUNBMH3?B_RO1XKP?7)U_12bC5&eg18(gT#NPRX3(>ZOa+)0@-X/6
SM;2DVCQ53UCLYd1+9S=ZH/3<38C&fWB>A2dLN/Zb+/\PTFW@_eA,Ld/?>#B\\3E
T44^J3?aY\a,0(&Y;U5,^b\Ld;c.JeKaVS+:/bKQXS=XU[CSdU2)gR);HX&Yf:<J
ea1Vg/CJP=JFPMZFD=e&HQ5J/07&2+LK#601Q2HM^K8X\)cPC8;TIdVZ@23SZ)gT
[:#;M(14SORQ_-\3a(J<X@/K?>5@g>D=?5R95gCXJTK5fb1T0P9Gb2UHLbX5VL.7
cY-ZJO<fF.=Hg?SGNXcdC)JDVdKI6.ad/\b)0TI5=P74[7,g8;9IGXG?IcFG-;fF
gJEH)<@=d6E8XZX1BRI_55HHd6dII=R1>[6V5[b,eY^]M=5bGZ,E6:MXQ5NL=[O,
=@\^/60-cIa]Q?TKgZ-CUI1_R)&gV0b&db\7Db^-9(B4]:2U#.DJN[A8ZbZCX-(=
L_a9EPPf#@Y]\K8G(.<gb4R[)M>C[6JCW]<Q;<.@d(IOg36#G@fgSU2YNQ2L/_2Z
AP?.eTCeg5O&)FDS1EG)]JI[.>70;:I;&AHR[88(Ga._<[aC^g=)Z/5&_9XTH?/;
605,6B#9V=4^B,63)B9MH#4J/0F#gMZ/eXef_/,IaD303:G24Z_;&9DE[64,)W_D
L6/A]5>/Md0Ka,>=+-:UKNT+<#O4Z[4<89IOd5:5cJ0HS4C/67.CfXRA),5698IA
6UNH&8a06U^2<G4BbDC][N:/#f+_H)+LfL/:X;1T5HDH[BfDIcGZU]PXCg),>&1M
Fb[ZI0_cEfNU^1_a)&OOI#AW0G>g)U5\DF5R;a.IL<PcG1gM+25)N_-0\<[cL<:f
CQA\1]#D934>S-cU<1TGbBFF9XG5R+2FBFZDH4/Fg3E)MB9MTM,03f+24:,dZ[E^
:^3S^HUYb8fCLFN:&MdUWKK?K8ZcB<IeAN.]-=#Q-YLMBELN,XagF:0\Z\M1KfYC
WO3MS9<<](+,Ge2G+Ea)]N2T5Y#=U,#9a7cK>8))JUCT1F/8BHdDYCFY4S8>bL7A
74N?\Z2,C8@DQ:a\K;2@(TCK_99)XC\4XP^)0;)LB8FCO(Ed3&4KBcSe_0)E\E(1
BMDg3#Q:U?b)[1I3]B-)b)OI+gKV1AEgd.)bN?D,B>]]UeXY.WQTXJSZFL@gL/e/
\>R+[V/<>98F_eXBUKJR2eD#D^.RGR^+NQT;+;Z;Y+bMcRSRGCY7TYcG:C<[B)I+
OfI;Eg(6?-bD4184>CgA_RG4NY<=3)^U@>d0-[#JCR8IC=[Ud>/=X[aDZVJRI06I
\P-Z:3PKXTBVBe2]-,V.9+D9bKdZXecA5Ve-&aUP+a(O[[3KeA@G-<B?#6Gg5DV\
WYUG,99V+-@ZBL.6b.D<F,Zf9bM_T&e)Q6NX??9A(ARb=b3-P_4S<+Q)b8&Ge@^,
??c\bZUS[[b;6E&=cfSb=O=&/Ldeg05VRT_f(>IFAH2DgT4,^YcaWHEfRLMCBg+g
>IWg+[?.G(+]@DE^-S)9a9C8X1UKK+65PA.SQH_6FR&8_:1V5>?Je7@CcG8[M8()
302gURXSY;\;ZHc.2DV(AZAbEZW4H5H0Sc23OQZQ--A;eRCWRV+^.QE2-S:c.S=#
R=&8g__J1V_M=gGaf[>LRQaCZ12[GLY+3aKAGMPS&.H]eKL4V(5&[EU_QB[Ab\)a
7S9I?90Z<D5BG?e?4_f.#7\.D3TUUYJ)OYQL]259=IQ12N0LcLMT6[_#6X6\&ITZ
&ISHGI4;O(A&dM)=cc1L28[)F\RJZZ\cP2>T+2<[-AJP&e>\R;69V+(+?KMK6X6Y
E(gU3I=T)<VSO@e2c[O(C5@@Y]+2+D.Dc^Bg/LD_0EWZ_7)5:-?CSN:-YZ6-UCRO
>[-MZ\0=e/g_d#GH0GT;Td(.-T[B9,^>=,)&.A3T;O]7\KHO#)HH<5?8@0baY9eW
]?gWX+&&895Z,7E6FZN>/)Y\UKE/H_G28,e=e28=3H3C[)X1F53UJUL;f]9V7X7,
^>:DI5LCMBgG&#9PX+MY1b^W^>PRCc=7F)(6CfTD>_O1BGV\f:#([<GL-;2@</3#
eRe>#\E7e4R^(?^?-:?#_>65_\>IF6eZ^0CJg[ZKPSOX->/L;#<4O9aHZK]XBT)N
cW)Q>1Ee]Za)(FAXR0WVCQ_,\\8<[B[S9Og@O&K,=4,-EdUD_KV3X^C[0VZA6Of0
5N9N<0&Q>Y?-)O@LV78&;9M#cS^N^R.=&X&gGMBOY_XD>:Q5c42ZL7MG;LI>\2#@
Db>c8NaU@<@5X^Wd?_=B\bQ:[H7\\YecOS/ceA.OCFWY(GbFG@3DC65:T+R@g]fK
DSJ@RT&f2-OO=ROMIJdU-HgOb(f\LI5A/_?P]H=IEFCND^5gD-:-bfKMXJg_-(TC
,#g?6bBAK>ZD/^VZCZSD?D+S6,-9J+OAMgg3f[+@&M/O7(NQ4ef?+F,,^dJAfb<+
E(B]/V#-Q=ILMP:];g4H-e(=E?FQ1N,LWdVY?B4U^QgT<e8^AM:ZEde5P&)1dW-C
b0G+W53QO]B)c3)X,QM#PR[A]_f]g=gXe16BG)]aB[g8S+bO7F=g0@YM9b+3KSRe
JP4\2c50P.\H=?/)Z+J286UgP+F;2TX1VZJP_>.Y874cG]H9J&[>bD9OX+AY_JZ+
_XBg2,A@a7YFPRU6de&<O:c2]&dH^&\FGDMZUD<c5N;d#Qd8Q=5&Xbefc:gN,V\d
@]\]P^,3&dUMeMKJR[AX6O&]+^f&:cKTCUI&U(:3P?_bbTB-,O.[1EHUCcb6V/-G
/7NKfTR.4d:)_:[1a(>8U4AORW0&_+f7H\>?Rb9,+XSHD:#MF,;gP=GPGVPVgBPC
W?0+.=(b<W<^fEC\L8H)\LcW#L#SZ,1CMYCE1PTY@NaOOVcW2M[8[\-IUG7.778a
;cRZAQ6TJfL[fLUCS/[;N?]96ZJ24GO/Q4(aG6afM[g\DJ]^O+R[NVa:A,.b51fE
T@FPQNTR[WTg)4OYCM,^8&AgfC5L&Ve0Q@2]0Qcc(b\\)-cAB4]-Y5):DUT@/EOB
Xb&SIBf8.c:@^Xg4T_LH.^^MJ04I+E9;3N<2WgAF_RH\f?]9QJaX[XA8T9JE&62b
7NYC/=.DPN:SMG52K\_Q;B.KX4AD0Z_.B:]4dPET.D4U=dJ\DCJg5E7(Y\LJ4NHU
&Cf>69U3QGQJCH]B@(@2)C2ZP-9EK&6Kd?<F:KYSf2:DZ7_gHAHa6A1NZ)?L6+aI
dDV)a3,/T^3QWG)>ZbJ&V;L]\\^E>GPIT^Aa^CF:7+G7He-M@]WD]2?K7CFc:&e[
VGPcg4?b>30Vbc4=W[<NZ3]@3/Je6^VMJF9EQQ5REY\ZdBMP576;UNSI?2gE^;e3
&,f_1P:B(JCX1P0N,L--+:T,VN/0LfK.RbI+g3JRD>@V9XZ8=(38b5D>G3B\N/@=
gDKF[X\)3K<ILOXUGN6_:\@+VBfe,>;?.dJRYCK]9F@FF6,\F[)a#=TIDUV^)+=Y
)POBT_=OQ.-?<@MA,PB3TGeA161@G?IeREgI,cEZAWeHM5e0fG+(b^Cc=CcV@&IF
5B-H8=1-[BHXMSaMG..]0G9>O\RHK@b(^H?ZaOB@C:[>d483LFe\@.5G3&6)N)QJ
,RA^D^Gd=I-;JRG9C8[OBc@EO+GfQ2Z5QVbZ#0ZUCWS,Nd411cG0aDd675IM2@b@
\D<&#^M.2/HK@Y2^,QU:KBTSH75>]f+#Q3J3\85AAYCggEc::I7##&HZPLG)d-V;
?QgRHY\-IeTg7<:e2UJLT\eROC^EJUL2De)333)H4dFFO4,):Jc2:@JX+HgYg?77
];Q?7DDLUHZXfU^_-Q)<A//MAA>+S-FF,A-e7_,2XCJG?_Z-ZK)2G;cR:4S(===a
G.\Z7^ddY^+>\RW+DC=b18VE[Ca<RA1>PY0H_MB7N/&5BRIg,P@&HVCF<A1623Z&
-Rf>QA51\88G\PAe<&/S?7]MCAfcOVKQNI?QJ2Y4^\Ab>&]95=aY1F[,:RfIGFJ(
gX9KE;TBW3IcYP=9,a<V?-^YE;1+N2^<&E)T8L0HOM_#KSW7^XfJf_3g0=[ZRdK#
a1QaE_11HYSI.@HKcGYAHBFO.=N\JLbeSFDN\X30B^^)C2RcK#(-&M_I=2G^8[NG
?WfL+F/Ha;FP0#.)Z3ERf1W[J&)^7\ZEb#]c)S:2BA4=.9>H2_Nag@22CT_)W,=P
SWS2W,,WE;f4.FG&_>T_GXU-Q_2a_#[Z^IPV0F]AF65d=/?4D<>#&-JK;&V>g@5E
SEZaM)VJM_WIV);1#&36D,7fL<,/Q=IaQG2:;_^6>C(\JW.Z\fZ=)a#N688CA_NR
=+&FP^.2aa#1^b+FO>))bLb&LO7fQH\VaRH38SbRdIc[B\FNH/gWU[eA@CHF[]1S
A41cV&I&L?aF>W2RTOSQ_T,7ZEgS)BM^XLJBZT[>X&)[5Nf\/0FVPf_?)g+UL]]X
&>a7<bYNA]8IKL+Uef\C<gY&fPPE&YBB(E5SNRE#H/J<KLH1BEYWdM[W#]UXXY9Z
(2&SZdL49@NH#gM;9K\/50Y1g-;0a^>=O/UGCM<(5-d/bD_bD&Z4cR.NIKe9;&=G
J=--T16GB6#-MJJReMJAW<T#YU?fPP;+\]&C#G3gPPY.5QCL@;0GP_[?eC<D]>7N
)Z?W\RfJ=;/JBf#95G?C[;:?GLS\?.N/.XJ:<2>3aOf7?TYEG,W@X5N/D50DJKYV
O-b6\VPQIV]@)OCIe(=#9U5)fGg4CN9VV1-,#SV_QWE;+>Y[VMF#5K;&7]]V7D_E
[3aG\f^(Z@2B/P[F=9Y57NHY6]39cf9]bM>UE9:Q1U,^=M\J3#;(K)V;I>Hg]_>.
OV)^GH:a4_&_::fT^(e^c;9XB]OF7cFf.4>O;65:Lfb#(T:QG=7C[61\>(USg9_Y
JHV6V+:0\Tc3f2]1a\Rd=D&?@D/@[:<)&K.S;2e@A[OTZcG+V@_;I_.-c5(OcO)=
CJ(2bGDb9fR<d<=3@#,2P_0[[6B_]\^dH;0I06WCa,,?VQ#gYDPa[N1(.,3[1PM#
1@=ISSUQQ6J/E+DHWL+(_KeAZ^9LT<HXH5G(S;e/IJ_872^C@0G>F5(PCY(fM]22
Dc1B3X>T2baDa+;9WYaKd[[VBCa.OG_aL?f=,(^TcI6=6]e#NBS1??QaV])#5-#]
U12-K7-gLSK\&1;&-(2FCA::YFd(3A:^GBSVF#24)MHa+=aR&dY:^cF17fA3U#@c
/Xdf_Q+:8M^01=8LPH\BG:W&ZLIRK\J,24eZ^UX=;FfHL:bT=633)Te.[?S.Rf+=
82TPCJ,S?[+5g3W]#Q&<RJO-PK?\PZPFUOgKMU.@F8I<5Gg9LL?ZgaA\Kc3.BR-f
TJ(Gg03Z1YEeAZObFZ9:)C7=(HR68&(QgCO_NDB<W&3d;XH0U6aB<38#<H_,\HA/
RcYC+ISg(<WVU8EFeVNG-[(O:Ac_d=KY3PL[c]YCe/Fd6_U8[]02#[g:^C3f&P>g
7#Ug>9@T<_#Sc-W[T,^Dg0157QAV0>^eWf1FZd_VYRJ;X@F(FTA2XO^[WKL3@YH:
MX(CS+d.A\NS80]UI>aLfN-K7FZB=bFOeP<Xa]ZIWUD-KC5?O9F3TI&3:BC9E@JE
T_([]86W@@C.]DXVIYA3-\)MPZfN)W3D;5WDB=USWT6C2U-LZ0Z(Re4I>_/6\,/g
23^COXd2-2(D20BJ5:0M5,.(a9/XWH([BQ^(=&-_UL,J>8H_ZDI2WFa7A2G@6]B7
cUcC3PRX:_g&[22?:^Q/+EK4b\V]+e>&-R2/^Ff6P4N>;>0:6(We)QbWZ(18WVMT
[8gSbeI:.:V,\;UdM\_N1C\G;a_(I[L?7K>1U=#Mg94@dXUCLUNX-F-00b;A;,9B
L)fPO#R&0K^d<L4EU).-I\U<9+5L:^],_faM(+(#811gF6ac2a6?6FF1?V>5ZLFP
HRZ/@HA)Q[f4(6>@FMY1\eZ:FDD/L_-I(efHYQMdcHYA/IC:8&C^J4]O/@5+gQ4K
A_b@(TfLaX^>:3Q8gY4D5B[:&D-E6IQXZQYfbK(\-V2_XLLK-#&DKA-aMCXAd0Y]
0UL06dbB+fP+.NgD,=FNCHI?M+@Q&:VA4-I0VSN+KDRQ[WFH2g.+;7AZS>.W_JY<
8YAX6TB5a4K1dR&UI#Y&NWH=A1?RJb+=@Y48K7gSA2Jb^55<Gaa4/0b&WaEL/+OO
TX/1GAa<+aT\1;4?8@[XU+-OB>C(NQN&5g:b5V&d#gK9#G<=9-c;:()3#ZS,,g&W
&Eb#bJB@-0@6/[7X-dfa[\)TN[B-d1KX?HYA;:]g]YJA2I\U9R0A:O\5+;=aTRJ^
LaH?JG-8H&&AR#MbG/<[@(,c#MY79E<C2AZ>.#?4B08.:;,UN/ReU2B5)2<H502;
:ea=\):PBZb@6\8bfb<YSRgBYIBgH2JJa,C<Wb9TY-eM(Lg<(.c96&_U7>gE4I;D
Md)AF^dg5KBFdQL0#E]-S,:MUc/F.V:U/P2S-@>,3&67,L6af4]GS]Zg)=(_O9YU
YZg>^>DbRCe;Y_S,Q@PdeH/B.@&N3=N6\V7ILCWGDL[=AB5K@:fEg37683U-2L&C
6F>?JGgKK,MNE4Gg/;=#)WJaN&dS>>6MOV/)XORE4C82FRUfO7X;V@Y>a__>P/BB
/2EAfO:SG>VAce\QTA6^=;T_c+g;dSR=HF66N9<J)_<QC,GJe_A36J&f78@0?<OU
2gVYT5D9)E_@W,g)T)HTAgR_0YGKRJ??WQ&?2H:]NKb8AZ_SQAYR\K:3@]2D.A+4
_)NYDET3-,83._&f@MO=_HX\,,\^E:9P2E.eJ:3=bI#R=0-V>eE^--[YQ_J:?OTG
K._YTf50bSHR6O[bM;C9L:,\=fYWb,T\B65#NSP#3-ZIb]DQc#aNHH-6g=a#)Z69
CY,ST:A2PCe;G5M,LFM4VE@\@:Dd[95R7[b1E572<TP-.2<8Og4d9D,AAISO,1;=
,Xf34g^9+^Xa9=<Y#XHRUX2P&]+<-Hc?TG+<X:XAS:Q)gHV.<(&J@\[7.Gbb0fL+
ZaeQD0D,<<g,7GbXMU5g;A6GO9R+1QD,&53bGVW:5(gWRS4JR<X]4;VII0<[:FDV
GI+.=&1^Fc4B.ARVULG_gN1I^:S.KBSQ3d5F?B8fa.)OIA,PUGYGeIJ\&ga-T\8W
gYfYDMe>\J8.1(KEFJ5+IU,WYL&6F]+e(_&/1)S@7)YXNM_d.>>E.O??)95]S:O3
_:g:N+@E:dP^1#]aHSZF;&0?[ANTP]4fP(b8,.b:YU9MdNQ\O9;YWHLQ0<XbHBJ>
Nc,RZXT:0-CVP9WRL;\AeWg<<EPg[d0L3R3#^]#KQ,\EIa#&VI&?29LT]g2QMZ\4
[,S:.NdI]=PH\O/1A^Z7GW@fJQ#/UG/>/[P+P10^_(b]MPd#A:FF7dK5fe>E&<8E
,4f06L^6)]Y-KgA;,f[/,2^N8[.V5M06K?a.HM>,G6/L?]Y4_+U@]QII;BENXC+^
Z-..R^HL\OfII<#:X;]aM_)J,@<gN)-a_O.d4HIE]\&4WLG,9+RcH8XF).L(Z1J/
d;.HP._E&K#gE-SJVW?A83aOO3e0F/f_&cC.]2=1WVW/W35Fg7+^>AL;I::&f8<F
^Q&W+,3_O7VWAF1LH-Xf^S8L](WLYAZ?W;_Y,JLNNNSYJ.>V8K9I=T/>7&fI.T<\
07b(?L>WXK]W(CR/g_-8-[E)7HF28:19fQa#2&dU#]U=0&S5_CFX;/?fSF6AeH#6
&c>dHg^XbKPPb?;3CJ-F],BU7[FT&>]CL^P08CP1:2+-G(S:@_=SgSC[+T+#2SOH
_9gc5>K=1PUTdY2XRdE1BGaO7WaX]\Z-;b7I@e\(aa@\(4b<Y]RB[>DT9C&GGa)>
+bINaUGO=(0JFaOWTSR/f2a4>aF;X<KM.6_(PJ:1LAVGB#DG-c6FX]I;Z?fLL=^[
J[Z5#RXE]2aA.<Q7:O8I-,gfAgJB.P,&?)=#H[X;O[[SE30UeB\IK7&?S&04CB[M
O(FY-^f+XffABD-G=Ud3&_]M[FP5LMBP4_::00&N7(8Z_AJGOgK&-[]1DZE0J^Ne
IgVABUSVfD\Jbb\X)&IK5FG(5N.?6XB9=1&fQ_IBF94K1=MU)KG:J:a><3Og1.Y@
CV>U_O-?H/0I-]3M5JD(1.G6V\6_[SOK\Y<RUYPA9fP]V,)Sf=XB_.85.R2RE_IG
&B#T=[HF?VKRTb>PaDVafg/DD9-A8+eA+FP.;f]RJf9HM,:_&[NY7QBE9L:+J(K(
7UBR>;QDR1(gbe+@\Q-46?RD#d>._BX=F]O(JOP7+UB1+RP)IffB^5H>2LWXAKIJ
aIBA7PN^2/)YC&[7\,Ub5dCID)VJ=EJV^,g:6L<=^<IV9O5R,Vc(=>.:R;GfGP>9
072K,<XCfD//TFF,R>D__LZV?VDbL/R)0>(K>Z/BDLbQ;Y:I:(L#4N;=;O#7S-55
M6,M-#6O.6KM?W+]\1d=LK5C>ec&)(_Q6I4aO39BO8KSL.cA:7__gB)R@:]M_YP]
@R2\[O=JQIZ]IP\,^2+G-9.dPa5OQDY[F/_#\<\YAQM;Wb>a_27>,6WB@?A,BcJO
CAb:-a--2^W\Z>O1OF9HLWJS6#/EYI&>#01>6F?X#Q1IOZ7D=bWZELDGEX=/A_<K
cR-cc<Z7>FKT.bGDM=gK@a5.C;MdNLg=27G-5^cf0;1@<c]Y#,f_KH@EG&--WCJ7
C@M60L:9_?N@0IbDZ8NLZ:HJa=YI1[)Qa#W?+VbP/W@gaN))?=f77^Y-,Wbb#/-#
S&L\EI9ea;,CXTQ,[4.AZ=^I8=4W;O1b26=C-<MDa1?._^^Xf7[Q)2T/aK-Scd#Z
U4ML0f0eFNN_+eL;@^1NIV0.95_S_./,dGZ_B,>T-[<_@(8Z4)E.VCG+KBXS(b+O
-^f<DgQC;])J;P@)/.HScJY,F>488+I:?#MgIOg4[T\ZdFFCUNQ\--X)EL>:TJ]g
]B.8E05=(5^eKU@5?(H-GLU,(PT:OMULI54-F1_<Fb?9@MI-D^f6Z=Jb\@d]93@5
E2A8.@ODTO#&CGL2CJ-0gFc<G0eJ@c<YYZ+]DVOR=(W9T_>4I_HE^]^d1I(X5T1)
]R18-AM\X&/0^HL(R.^UULL:U6;SN?AagME2;H-B7>A<\#8]\SB00<1=);UOE?C0
.(@PdH^)]DHU@]A@(aODR#eaf6,I_dHO01OX@;c22fF14_)MZMe^ZU)C3U&>Zda)
AJ[L=QJRZVeJ9e6_Y+U5JAWP7,RG@?,CR^EeR<X8F^/)ZTB7O/,2NISZDC4\/-5K
e/WC9e0+<G.g@DIYZXN?gdHWHFG76P_7-OJKU:ABU:aM;eR1#Md<KU&K41[A^3Xc
a;I:OeC-V,7bLV2ZG39,.+d,DO7F>O6?COUBI>afHS13Lg5?R[=/8GFbYbLH^^9C
M/cQNfI?_&FXdEYE\;cGFT73c)2G_4NCZ_ace0<>#&&5#/H/[FUcb07X^LA#N>G&
.F>>T2c?P>&(L<&+SMWO+JAM\@/1#4<a--e->VHXC->R]AI(+Ge:cWR5P<H4S(Bc
DEBWaT/+5eJ\C/eK\@Q)392N4ABEE.6NS[W2c#bN16=,K+K7_0MHST^KQ#;MQ;]3
PT:W>4ZaPNKT?S7VF]X8R&;)S39Gb#g#Y-WGBW&e(.;PDE5Vf3N&e6E6D\[1O^W1
eP:;2+,cK)]d#@<^ZMG)>2CXS+b00[C]IKC<);ZMg:aY4LVge+/cfL.)f,/2afC^
W\HEB0=XeMF^0.V59Y;E]0dA(;N/TE^/(JF?K0T>EGfQFOC3/B\#YM..&K\J^]90
NCT:db8ZZOW^2\S^2(;T\(bgM,IJg38Pf/\YJA#g1B#QJZV:5KIbd.gEHI;>[c#=
5_79SNV+c)[B>e=RG?5[gUfO=KgJ#;;G#e_c9C@d>I)#f7_.a@,d3HN.7[/I0eg;
.?WI@)Ag;_C^4>WM4gUQP^72_MDVgL<8XaNQ[:L(\D>_6PfD4Q5TL9#QK/S#bJI(
QSLJUL-\d<1bB>e3Q,\JS8#9E0N4JH,,Ef^(-_c_=5GDK8[;JLV9B4.g8757(-1W
/>.[@Ke&H]a&+Re1M\RAM[WP^&69TQMO@JUU50(91/<PY8(cM6(JG>A&6^dSf)NW
MRXMCdSW\FK=PZ<Q))745]P:U&9Hg8FVW<YJ\BZM7Fc=Vecdb?a?]a9AHI3c^Df3
QJ]]53F49/\^G?1V8=@K,gYF9DX[7/.-KPJ4.Oa,AEg7WWZZ8W__J?HV(NK[ZV8\
g.VNA:_6]@<18)D(&Ufe?ALG.O]1G+#4S9fO8T.a>/KAASCZf:b/aU15^FT0e(>>
/1d\54MIF5BZP(011IEcUQD?5f]+#N,^P>-<Z_IX2dZ_Je\XbeO(R@==fQ]<N9(Y
UWKQ/a[A9?_/5A0+g:5\]5F0,Ae.K:UT:TKMcKY&+,4ZN@4KQHdBO5\PGB/)D]_U
:JcXFQ+JM),L1[75N3X1CSV:Xc.,)<)><#>)ZZ([>E4:>^XS>4S)4Z40).OANR69
=0Q/[IA-JYYa],I4:g+UF-bRfKJ]b/AcdfO7b60Z@dN6+]OKS5OM6:^a^-4Q+:Fg
SP)<OW/[Q+:I-_/[4BCQbRK;M9ffF<fd0,c3ed@7(PB,=9OLTT#dQa5OR6JRJ[,(
d;XLa>.Ne+P(TND_e<c>O/,c0]>14DX\NB6Fd2BJb>7f/bZX\XVC].+?>MV[:3Ng
M:,QCLA@WVV43;CMT@DE6YGE^I;4e4H)@80D=HA;bJ2:DEPbXJY1-6+J+D;7XJRK
cVS6.6(:+Z6?(@_:8M^-aO32OGL=OSQ[KTEZOV4<:^^c=U(dIZL=]D3EJWFc-Xba
J8>A07,TZ(,5FM#26O84J489.XFPL)+[R75g&4169g:OJBCNb37XC-KeWaMOe(&b
)Nb@966(@:?3^<3G@d7J,)MMQ[001<3XO#<\2K#cW1UP^;]CBC3EaKV)F8M#3gH&
D+>a=)Wc[[PN0Q.+dQeT&U(#5QKYaYcA5f2O7SM>)SM.Tg]<f\5NNc5=9999Q&Vf
SIQZDGD/d=V[e8:IbKLbKa,0T>]c3PS&[D>AbNT_CYZ+O0?dE^X[5Z0,b:1>@XFP
UR0F@G8adF8GL;a3Pa,22XfT>Q4IS12;G&?:b.b@dTUX<e+Xg&a651cUX1CGYTC5
4RcWF4)#2HBG\/ZZW&;8?5>YS:;Og_.gaXX:(N/@@e&9OK4?7c9>@X,38GZY1:2&
7+J&KNa8bg+OAL?L7\#NW)g.P=TNa1B<)LE6#cS96R#XCYaI,?d9T71JFVc1_>.J
I8d_2M?DU62]@DaE7&_#I>?T8g?=A9cPM6#dWDKE21>G6#g9PHKET]NF?.GdAQ:<
3bH,U^@P81F=XFd\6]Gd[F>=5K4cJZ@88IU7FE1((7G+;NPW<d)\QDN?-Kf\2UJ5
@#9bVL&U\P:33<?<XOgc_YA1MV;VWY]a4YT\-Y0;S8ERF4T&5e>XF6a@M=\3P>F:
JMI/XX-dEPUCX+6]c?b1T9cKJ8-_K6dXee0P4^cd>KZF[/+Pa162AGNF<5_PTV/^
R80#0CZBb2#<0baW23,NXY;Xb(&WaNg(C)dSAYC(f<WKaBJgF2DN@Hb+)7^@I8[g
^IRUe,-dS(EG)H(3Y::\Pa6#<:N(H>.E\Y0RJ#fOV?H:],#@(^XJb0H\gK[;B?VN
=[Y)?>J,\bL^VMe4+8VEMA[[2=&<AC0-OJPK6Q_IU5\gKQ^=&07fUST-^VbaNOY\
64Pb2FB5HO4B#YBQ:gWE.D#ORMESb[TcJY90(@aO]&:(d29+K./+N4<IPZc>@^/_
-Fb<G@O1ARNBMZ>(cD[I?\-e7N/e#E4DX0K:8Ic.]46SVULP9I0XgV&gWU27T5KF
\I;&QbGC+++8])/5b;0?[PfHH+_=;XDb37972N#)d4)9_:BeRWU7Q;/ZJcJ&WF)d
P;)9>TP&K=dBOGL-].=IN?>-W)65V=1\_#XN;(Q.O??)N9TO(cK]dJa??WK-dJd:
RAL@BT9\#XgbU+<ZOFW/(L&T<#F@W#gB.7.]:g,]5J8J/f+2GLTe@Y5fgLb<d6L-
B0.c8c/e;Q01[g-D/?U:1Bd.?1(#&XUDVI:HQ.L5R)^)cO99EF+HbfN5:K4a.Y<e
,T>EDK6/[^G,XCfe-O#b\eG,1,B8/UgM2>57O(8>))X7U2&/DT^)YAaH12)gJG8[
+3e-/<fV4FVbU,dbeT\I3c<DWBF:.([dPO8G7<7G[DZ]K^D,<2(3JNH-F08bNdRI
]W(?I&g+c7],7+?&K-,BGEUQ^EY9UPFA#X.CC+@A7&5_4^G]Q^R9Y9/]/g5-90+V
C^aV\V^45P8I,]G#-LCT@cAa]:fe0FXa0LL^[H(adX]39&TEc1<Q&3HIT\SVOAC0
>Db.A(]QL^WG>?ICDWLBN4G>Ja9<\DG;(5+H]0e9_#6EEZIX]I&0\L5&(#V[DYT8
:8F@YfefG2NZ[(2-+O.ED7Ya],I]U0(\BIccI[Ie@));A,7d=N7E/=7B;EHBHeH>
9&UYI4D+Dd]GYS6-Jb5P;U\5AB7^]&Of[.4cb;M&MFBdR4Xe\\5+WbSe-LN[@&@P
6CL_<&1X\U^)##KZ[QK]&6[R[eB2FO=1A-(F>FGbAM0c@\I)2XaS=Bd(b[1?,X:E
^P.TaZMVPM^S7R9VFa>2cA8CB6^]C350FZXFG7T5bMS@+X@e[I9CMcACL8LIBQVW
QYU2YYNDdX<9X4-JJNDCHA:K?<#MP;@OT]2IW+-/_08@+L3aI(6V<:S80;Q^G2Oe
E;0f5S;fb02IMF2)X23QGRg_RMf.0YN;GNS<Sf[_F+,,=bB\b/)A1\O?gRGf4]05
XZ/&-M?V#VVfU+)IB/A99g+S:+/[fe?P=I\YA#C[?RNP-R-fdJW\S@BAc]V2;4gN
CLWN3g,.<LgfGK)]?K7MNC=EPH+KcIf8XL0A]1+XJ6W_aaF:_XZ_b,)3FP>)_(Ie
UM)EORbHAMJM_LK[T_KRW^C_)5,4_T?6H9cZ=/A;9/S]=8?96M&IO-12:f5FM.W?
+ee-<2.HE#-^&D]F\4_ZXQ9KDUNf_^K?XU?d<9f54:40f?bH2b5dPRPQ)XM\,GS[
3=K[B+gaa:HC,A<KS4>GDKT4YJf;_5X>M?Uf0<D,YU7L9UKcG5)=;f9N.QfVW&98
Q<B9^RLQ/?Z=+L23CXHCS?V+KY_VgO-;=G/0Q/K^[K#K-fA/[\?^QM-.E4HX1B_)
.+>O]W:86dI)A>_g@N2&:68a,55/b>E,_]J^EF[QA&R6/Fc^^9&:CMdUL9OgNa:f
G-e<J\:g8V?>S5eB9=aL>ROe6==9=bFIb4c(6>ZeIW/#L07;(bDOM1?\;6WK8EYB
DO.7NZ(TTe/aM.WYPC5^DT1H>MPQV<[E4+J>RF)=KdVYVF/geYMP/PGP<N/[PIY+
edPX(EC@KRYEfS-0<OL>,NfT7<.X>1+d4b=U2?/YaE@7=F;V6c7HGCE2]BfVX,1<
Ce@82:./f,WWdEdg<,5WUNB^PaOg(G08L<b&0@^cBR#WECGCKbR++M(,ZD_7X&76
#[;;V]PQfF4#,ZcB[PF-.b6]eF=0[b@bX&#f6M+\DI6C#cb0B75EeF@dI0RJBFH:
67dY?Ogg+4O&OFF5(X0cBcbHCbb^]<)5>d(gNG#(cP3I:bWWCR]=a;Z.UaA#bcJR
a2Hf_LUa8ObHC=@GK<T1IbCa[VPa8ZF;cfVgJ5f66ZSBC^g3\W<V7Mg>UaR-M-Q[
H,Sca>ONB-GLSE9R^2Y[A\X=/XK0Ld[#_8deXI@HSfbG:PS:W;E0fcLUe&BJ)X[W
daf#2/56TW\7-N(^2C.(KC;_W[5I-3-1<\\3Y9-AHOKQg9CV(L=bWS?WG6<9.I,L
:M_11BLDO3[B&W&4:A^f&JPWRT@@gJ2gAKc7K^B1e:E560C<[<W_MO-<>e0)B:^8
b-\0-9fBaZZF:F(1)aGVU[=XSZ\H//[Y=+N;aQ:Y]UL4W0T#IK_I5d5\f,4/M57;
3;FXff7[@]/\:-V(0F4Z5K0NYN1THCRHU:DD8g1JU6eDfZGe=K+I\\3T+J&I((WL
eXBFE0K/&=D?)2W+^Q)a81S73aO5C,gF[C0&>..13P@PY_/SCWH7#a(IJEMY8S]B
SUB99<0R19K?e3Y=K@NAD;YW28V0:7,M3]I>W>PX7LZ4K]gT=SMT^3,L1J.+D>FB
7RG34O+,[)&+9EFON9Oc#@1(:b?4OCV\==M-\f7/0?#bB6,L(f_]d0]JZ-DA,Y?=
<1RU9LbYfRI[Vg9F\.PeK>X<Mf+4^@267(dU^@XTLO:/.?[8&cG4&afV+gF(EO2e
2PFHEeAK..:U6Z;Mg1+YMC)Pa:]V3^E(CHaTIc;#,ZDZDGE>f?bP3aSZP7^CabH/
c&4E^/cM>aH^E=^DMK+Wd5KG[8ROQ&C+M-;e]#L^Z@a?Z/6JHaD+JRM8LGf90<7J
g:TNAODG7Z^XU#8:XFd:.@Y;T4dLQUVCcAHBI]A^TcV\XP:&(PWJO+JNG9NIW9UF
H#:_)2<F;MX41a>I3T#IO]MIbdITG+,V[\##76ZeH=/c@>;-=\?\>0W&_Y?[\P6^
MU0F6dP&DL5)K<JRA/N(/?(8P,O)]UKdAP_==N?:e[ae]W-QEdYf:f(R3=2PH9fA
&>UJL?3V^-X5Wa/HTB3(Z3&/D;J8IJMEf>U6<J#fCR<FCagP0>=&<XJOC[#+U(1P
S981R0HcRT+WP;8J_5X9-VI48V-</EVP1b2+QWK6#X0X6^[JGO#HCW4OGZaU8I[N
SB/V9CFd?)70T.JQfO[=]g4FTG-APX>XR\0=CgScfMa&9]b:O5aN.S&6].W[>;(J
_ZOf4e4VE<T/R_ZTUU9)XFW?S.<IeUCP@f-Dd4RREVf>cIR1Eg5]f]#<NdG2+TXD
JV02C^SV.3/1R#XY&K,Tb?&Pe&MT/d6G?_0V.FV_6Q]Ya(K9=P&E<M&QC\:-7:4f
9a,>fOANf.e)>\BE_13eg^D?U\E/^U9G;RNLKRRKUS#,K>]>&LgdIc^=<O<0@b:O
UbE@(\&3a^(,4d^+]8J+ZIC,II\3e/FLZLFVKA2ga9/7BNZZ=WHF@#LO[PFT:&5>
,DScb6aISPF[:M(LWW?>J2d.5.18[;7S@Ted\(,Jb=._b.Ae@BEJQ<ee_H4<K&WC
\<O@=fR,&?/EfAY/U0B\+g]O6S/fBN1RJ^@eS\EL=U(R+Oa;IQ]#98?GdAZQbXTB
#P(d1EO6>,Y71_CL2B-;bgdZ?]V]EZC(dXg8W^;P&LOZ8/.0#fF+cZZc2[Hg24Pa
K.8..G=bM_5HFEBcUDb<..JC.6b:A5CG/eNgG4;bM54QKHN(VY)RO1@3f?+M3Q5\
M)9;E8GRJ4S/>=_7<e_CW4TNdJ2eKV):H2\+EF0\Q]-3.79(:BWQZRV]\dJb9)6G
(a<:4/NcFCXM/>.N=c-e\(LV?>bcC7/-4JF3Q;aRU2ESf95;B:0U1Rd-&-+.[C=g
3^L3QMQAF3.V,?OEB;Y+.^F?,6@BL_S3BCNQQcI;ODJ6Z/KQ1:&;Z:TDC_I.8#EA
L)]IWf(28T(9-#A=0L?]9,)XO;8PT\LO=B^9FP0+VR=6;<:T(EPL(WXZ7fOeTP-0
a(RTXgZ2;.Oe,>(/SREO:_=[ST/O4?VU3DRaQ<fg><Sg@VcYaIEeVHNM@:R6/;L5
7>gI^,OG3F_6S+DR@c328ca-D/\6bgV\ASC=:#B,H)4f@8Wf0+D]4&e7-LMA:&9G
F43)U-HRIBMeZ()Y#CGLLKM6d6NR4@9d^E:W[NeIaR5?1a-^X#T@AJL)@3]IBIe)
L>MFQT),S4\[:=3HTQV70E,5G@R;JLQ]2;gGQ?Y]e[\BKfU2PN4(_->eOB&33g2Q
/.9cAU<N<+]gC.QC-5CTHJPQQg;_Fc#9Q1/FBAU7<ff78:I48^Q1=/;H7_MGZHd#
B;:0;L;5^^N((J5[/2(a]Q,]N9L1G8?;.R6<ZPG[Vb)EYBUKTg:OT1:dNY@b<a3)
#gUO>5JL=O5U3)[<DGbTL=\@)>;?/<60.9I7>>H4dd=#X2\Pb948;/D^/Q_EEd5X
^R<1&L)P@g2]WV\Q)J5?PE>Yb<dXD,V(ID90Z^N5&]VbRL)b/EH<g576?(IP[;7c
fV,YKI2E@JP1DcM_Yg]gK+>=)JG,-Y@ZeC-B9RUR+cVEXfLfETa-.;[ENRb+#DG/
8gD\bE;[LG#FTeXSBHdLP5fM>/3FJ\(]-X4RKbD>-<8P->_XU0DJ8U\C7Zg\HaWM
SZ#[dFHUDVdQ_F0_J@WQ/CHecY[e,/(b1J8bF([6I.V6R0&g)9:Cg,Z7Cb)N)ELJ
)MWIA,#49A]8_TP42[0DN<,a29W3,-N6RK;C1;K_c)=Rc-2/HDW>a&9/>dgX&UL#
Ld3FM=@/_3d-e=)D<ALXJa6c+G^HT:gagd:cM?C(FQ7TW+QQ-+\@.6SH4ecE(CPX
LL-cO()Y_6S/&&1+EADAb5\6DN8ZIbHR.X.;-1>5N2P+cf>IWg^4PG^1KR@TWcG1
TP&dDE:EM[>DcKIK#Ea]-I2?KdOA8;AI:Tecf0<5U3@3cRAAfRa\>I.GZ#H]1:S5
Hd4b84>gL11bGL_>ga_XCRCPRd,)VO853I^SaT7a,@5=FY>?_XD[CM/N4MUQ=eGC
KQU)a6)a)S>1F:#d-K/e=Y3.IcPFQ6FaC]NNcIU[Ya?>C99_((;+45X-5aHBWK]d
]>I-9aY9=4+.c:3RB06NI,+WTQ.Z[><@.VQWa77=^e&/a&F^.87\<R;bLTL-M.3;
YURA(5RB?\g+DKX)V(E1+aZaOVC;Q1#W4ABZ_#H5S0>IM?OHU=[9Q&CMAFUT8d-\
#LN\gOO##FV,WJX6.+,I;)g6/E[#+[Y[)V@M/dFE#)7S]IWP;HB[GMa0RUO94:MB
g8g)FXU-fRH<gI\,L:[f]IO1;0W6M?(I)cd)5BaP0Z.Pb0cIa<eJ/X)?<If>;_FC
^ZXMW2HfHI+cO+L;BY<X74/ZZ)(YILgJJFR[.]J=)IU;/aMV.?1bZRQHQ\#X?/&E
A0c<VKOV=2QMd;WKE)_ZULa3N,K4:O8eRfgI(XR\^Ye)1>DKH:A(TH5(_QX4CF>&
P2SW3=URD\A+XPP?3I)11;,XB&Yb9YNCdIB92]_S3([F_<fR]MF_?MAK&_2GLca-
^b=GH7/,0a^3gA7S8:IY-71Ic5@AZ\OU<Y5(Y\>5LGZ04[RBJ/<UNRa77?e7X]L/
[<.X7=GIA9ZRXf0?A#PgW<>Cg(]-=;PY:cYa<Ug8@6IgYN\\)5[LJ)+KXK3&ZF3L
6WaTN=+bAbAb3R[SbROTVL-K=7a,.OG:ZXg?CY+9?FT#4IADXg47&W,gLe<^0TXg
B/c+@2KRRTJKEB)f3@CD+.51C-gZ5[A0Z1.,3^O7YJM,Ebc-W-JK&OZFW]S;[W#T
T37-?4-(9LWQJC/:[Ee.c419?ddM>PJ]\;55VM.4I,5N-fa,58BKUD=(3B;,]=[?
9E.ZDR,^YE.EP9<YQC&/^H/MBR>(.f1Z-;4E7BOZ3aM[BFZ2^^L1I(5)G2[c=b]Q
7Ef[Q.R[SZ4:V#&gO14J.TP=g7bAC3#^X\>VGf9+b0Ta&?RR66RJIKE/6RZ9X&0M
d&XH(GL>0Pe+eW6g+3Ie2e]00T+18#2CR7+O4-d549&Q\4(;?ObGfLOZU=E(aL09
#J09E)Ja1O[NN,>CQ[?\,;DdbQ\QGZF?O73]Ba7;W0g&6afV&)>OIVUIS]D=#15A
S7>8@R+3NKFV#4\Ce95X?Aa0(\^C2GGJBAS\F.\@WWZ4-TR,EEdda0/+RbPF,,^0
R3;UaObaF)X,XPPF>(V5fY\cf[T96&V6VXUTK]@S,+@,K_#,WM?LNGb-9IKRZRTK
\,E7_S0ZLSd5Q7-5D1FW)P-7#=U__X,A&gCZ+3&,=a\M9&[<Y8aY14L#R@:S/)eb
;ba--9=8W#N6O@6.:_6)YU3,5=1Q0XF&8bSSA#NO-g>K/U7N.fea5,_E@P3NFEc5
(RE=Tg)3M4D5#.=IbY\CHc\)21S;>9O4W^R#BTH-DY@0H&1<?B?Hg)8VRfE0#,?/
a>@8U0DC)^TXJfgYXZG<X-33D;Q_9W3BeYRUTU>5IaEZeY=IRP2#;8/HgJTB<4B3
:IbQF)+BUQZ=fJS-TWL4SE)GXADd@[47WCCJ#ebK^<gT2X@Ea+_e]?),#NR-SbQX
;4Mb\S:+0PdU_E[,:YATDJ._:\aeBD-GSf2U3(dI[V^Xc6?7=(V<QJF_?;TfaIJY
LbT2G[UZ<KfUZCc,d8-P)J2G^PIcaG;(..7If/;;AY(:(O,-M,L[OVf1005\W[[M
DUUECf:U(Ac1bDP/<B<4b3HIU/A#(0I)5I(P.g1=(#_Oa@[[&=)W(fEdG,PW7QJf
,Z[]Rf1e[gBV76]J(W7\?)]])WJ:O0_/e(YMc9_E(JUZUZgG_SP>/LR]cI)0N-eD
>W),3R/U=?FBdUcOeZ#bC4=DUe=5](]FgS/P2L[O)9B__C-?;44F#S+<D4bQM7AV
C7V=O^:]g/edC_\>0)=U4]c#Ra5aIJIIF2SebBGOeE\N+#(R?GFK?/E@.gV1NA1]
NH7V]ARcM/J38H>9I/L68\c0X0>..V4c_?]LN9>c_W-]),/c(g)gRLEIYeKC6Q?@
gD2[.B==7TIc[J=7#0BBA38J#:B.g1=\T(KdA48ANZU<-+CW#C=N9B0I,fJ.0-:e
@LHXdg7fDcXJf.3@S0+Z#bD:AC2bIO[G?M+K5:9bLON)e^Jdb2+>Z\(^a4&X1&Q7
9DK7_IgJ[72E.O)CJ_eL&HD(#(PE6CBfM>Q_gEeEA#c#77F=OPda]+&T_:50aP@M
e=I3SJ.FY)?+#\?6Y2<KJW)-YU9DV/8\d\[.AW:^H/ZON_&Zd,==9AcP6_:WT;P&
(\6\S;4:^^6gKMXdZS^.K9,2E]NR8X16IJX0<ZOc569\dE^dG:)<\R?g]Tc6H7),
V\SeUe:.1:GZIT4RM7JZSeMV/_E8?/@I02QcEMHXN-A61gQ8BOJQI#98HYR2M:U&
AU(O#-gI4f=9E#(]TYZZ@OY^d9dU+[W)16KgDNJ/DFVS,>:],OC,JP=.b0UHGc=H
0UB;V2FNDG.UK@L]V>SdZJ(45.Hfb&L?X)<F<VIbK1#QLJb]QJf4[fU2.I0\(>K_
eb[8;@[cA88_g9G<\<B#PPUf_(QF@ZR,O]2M3>WMaQFN[-WX,I,3>=>a))3DX>e.
A-:BCM]]OFB0>HBR6F#4SMAgUW-XL@Me[1A]&3T_XIg-&@e=U)4HM42Tc1D-)=AW
BMJQ_0K4A1:0PEGKcJegBG4AU0cSPPAAMZV.Nf\@F.KK8L?A7=XT_^^\@OX^F_e4
f/Y//PcD/g(OcB836FL>a/4[,53X=ZOSec><U>]/IKT.-cd]KTf5;N3&MS7VYUP,
]:09ECTDgQ1_#IVJVD5e&<ZT6H9]K,B7K&+YCN4D.N+M4RUaL.If89L:=>g9KR]H
=dK5UG_+SZU]_.N,_ZE1P31&(<9PY@K9gY13C0IGa:&X(4ID3+[,&YB[,]4L>PI9
M;:aG95I2P#&SSc4?NVXQ\03C>YP?H9eY-1[U^.2LZ;&8M(KeQ3[9KS\+@==5,f^
Bf_][V[e2gbDYZ@06URH<TO34?(,cd1M<b-=5MeIBBI4B6Y)=?2/.01bQ2?HDREN
?9FD_VgS7@/f6I@_MF0f9_O2^#I1,bacIbET,FJC)W..=^M:#HZ[N>Pe@PLDG+Qe
QB8N51L,O\OS[?.KUP+EWG&0&KY[>ga1^QMeL?MQ@b,4+27AQ25KS4Tf__d6:cTa
Y(Q+]M1^;Q=/HY=8[6cW\g;TS:G8,QO7d9.a>5K^#)Y=]-Bc9]dQ9+OR-/OCWS4N
&OEISG27.#fJ8,7(-QLZV20AC(B6_Y1XaWE#V5/H;LDC#RN#;7@<_-<;c[:P]BLE
5ZV?Nf7-S0NdV5^2K>_V^ZGcU&YbX_>SWUZG&g,b-O#=C=:+^/,7AYc&0aGdHK+Z
X)RdBY\3;3=;(08O4dUg2N5.1KW\.2&XSJ:IB:(2]HY9:47:OHHX-/VdaTde3N2:
WSK;NQ23e2Ed>L1(<;ND0Bf<BE[R5C);G\<0Z/H.>VS>HUQTEHB3@DQ2f10J0=-6
9dF,#K.HWI3AVB]36)L1UV/8K(8deO>NAac;8eT3@/6C=DPF&a5+c0O(C(&(Ne9F
=@GV38D\.0@1]f.,+I+3N]97=^]GXW2eMJL:WL0F=W8LLX2_5O(O?1D/SR0g18OH
KO17DBegbE=P,B[B^T^.,?d6&c(fFd]0D,H_LRO>_82>>7]H16&9I:+EI)7#W,cK
&FFGTQ:,bVT],CaM7G+[4KHRK6XONHA81VI;]\f,_C;L;D?HRKAbWGZQ(8DFAf#I
Y=Ib^f:Q0H2&I5P2CN5?,E8g5G5[eKKY:>,4bDc,QUEI..</@7Ff/A?>L58K]e&+
ZL/HeA:-/=C:Nf,LK>GfJc69>5LW=e508(R?D>N1&7f;Y(X,8:\9(V18RR>(O4,A
MQ#7D9[f4NBVAU@(JN>M_CJPY<,eL9N3,.\#F3.LRN2R?C]QO>eE(Gf[PL]-C=F2
@NRZ;0eT2I8RP[DG-&+0LdG#^<G0+P(TN::9[CGQ0(J3^c+bL;I-dCDKe&AfGA=#
1?BTJ.NR[@NQD?\L8U6Aa[7e2J?)f6Q5LQKTeOQP9I>W8UG5cgRL&CKObJY<N4Cd
X.15E?__>22CeE1Q\PDP);H]U^3MMd(:Re=6).BQ7L#HeC_V]G4M3@Ud][[B@6<>
S<=93QW.^;(V;&g&7KG5+?J)a8NJYZ+.+g<6=83N_6EaIX^1Q7FNb@]M&\V:.Cg/
\RI[Cb?2W8UM_b\<Q=7B=90.Z[?1BH>fJ>Q?9E^(^E6Yd:&/_?<TeJ[>-b@,:@>Q
F1_49[SCFHeF&FWNX7T\.IKI8N&7GZc_Y@^Q95eZ5;,M\40d.VSIf5<Z6JPR4^D_
<-\\?7CIJ.6+bM+ON1WV:M>6EB\dH+fg3<.:HP@P(E:cgN(DZ5?=U_6=)^?>;7Ef
-6)U]efPNe&O/HR^UeFE,Q.<?8eHN+9]eP84W5GZ0,>(ZUb/NFY9+0M)-@9Y>\I=
X,CFP=A_P;9LJ2e/(=\1FS\,PNC9?[99[Ae4D>?98ND5^N/H47Y&EX@JW]N>J)[T
\@>0bOS2>@<,[C(;N<2_3@c<6KH/dK.Cg2>UF&#6d:6c#>N<\\=DXA[O#JKN<3>Z
\?>Tfc@f24eIEM>8P5G7.3CH/B)[)Jf+DHC#4?3HB5?>7.R8\D:0+]1<O0]K#85X
E3E?6M42E-H)E\S;?Ag[Y=&JCKDEDcBaN\2_P;D8E@2E;g(UPAROAM]8:^8NK]&\
b5K#LC3a/6PfA+g@&#XF-SfFW&3N+6HE?Uc>@\TB,CHH.9CKaf4N8/&6XM^TX@#.
3e/[1CP0=[^E=X&5aZSXJA8b5-CcLW__6O5VSF5=P.WOUS7Rg#e7I/7#fEE#DQ?I
5C7<#cCcQ/8RXN:^ZHBDXa.<5UY.D[9(a=>T[>#?-e^f:QIG.B&A4U<YX[Pg63(S
45ZUVL/UC/2dHbI@[.L<GZL.(3)OP<;b@$
`endprotected


`endif // GUARD_SVT_CHI_COMMON_TRANSACTION_SV

