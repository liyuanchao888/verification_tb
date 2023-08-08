#ifndef _VC_HDRS_H
#define _VC_HDRS_H

#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif
#include <stdio.h>
#include <dlfcn.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef _VC_TYPES_
#define _VC_TYPES_
/* common definitions shared with DirectC.h */

typedef unsigned int U;
typedef unsigned char UB;
typedef unsigned char scalar;
typedef struct { U c; U d;} vec32;

#define scalar_0 0
#define scalar_1 1
#define scalar_z 2
#define scalar_x 3

extern long long int ConvUP2LLI(U* a);
extern void ConvLLI2UP(long long int a1, U* a2);
extern long long int GetLLIresult();
extern void StoreLLIresult(const unsigned int* data);
typedef struct VeriC_Descriptor *vc_handle;

#ifndef SV_3_COMPATIBILITY
#define SV_STRING const char*
#else
#define SV_STRING char*
#endif

#endif /* _VC_TYPES_ */


 extern int SLI_Terminate();

 extern int uvm_hdl_check_path(/* INPUT */const char* path);

 extern int uvm_hdl_deposit(/* INPUT */const char* path, const /* INPUT */svLogicVecVal *value);

 extern int uvm_hdl_force(/* INPUT */const char* path, const /* INPUT */svLogicVecVal *value);

 extern int uvm_hdl_release_and_read(/* INPUT */const char* path, /* INOUT */svLogicVecVal *value);

 extern int uvm_hdl_release(/* INPUT */const char* path);

 extern int uvm_hdl_read(/* INPUT */const char* path, /* OUTPUT */svLogicVecVal *value);

 extern SV_STRING uvm_hdl_read_string(/* INPUT */const char* path);

 extern int uvm_memory_load(/* INPUT */const char* nid, /* INPUT */const char* scope, /* INPUT */const char* fileName, /* INPUT */const char* radix, /* INPUT */const char* startaddr, /* INPUT */const char* endaddr, /* INPUT */const char* types);

 extern SV_STRING uvm_dpi_get_next_arg_c();

 extern SV_STRING uvm_dpi_get_tool_name_c();

 extern SV_STRING uvm_dpi_get_tool_version_c();

 extern void* uvm_dpi_regcomp(/* INPUT */const char* regex);

 extern int uvm_dpi_regexec(/* INPUT */void* preg, /* INPUT */const char* str);

 extern void uvm_dpi_regfree(/* INPUT */void* preg);

 extern int uvm_re_match(/* INPUT */const char* re, /* INPUT */const char* str);

 extern void uvm_dump_re_cache();

 extern SV_STRING uvm_glob_to_re(/* INPUT */const char* glob);

 extern void fsdbTransDPI_scope_add_logicvec_attribute(/* OUTPUT */int *state, /* INPUT */const char* scope_fullname, /* INPUT */const char* attribute_name, const /* INPUT */svLogicVecVal *attribute, /* INPUT */int numbit, /* INPUT */const char* options);

 extern void fsdbTransDPI_scope_add_int_attribute(/* OUTPUT */int *state, /* INPUT */const char* scope_fullname, /* INPUT */const char* attribute_name, /* INPUT */int attribute, /* INPUT */const char* options);

 extern void fsdbTransDPI_scope_add_string_attribute(/* OUTPUT */int *state, /* INPUT */const char* scope_fullname, /* INPUT */const char* attribute_name, /* INPUT */const char* attribute, /* INPUT */const char* options);

 extern void fsdbTransDPI_scope_add_real_attribute(/* OUTPUT */int *state, /* INPUT */const char* scope_fullname, /* INPUT */const char* attribute_name, /* INPUT */double attribute, /* INPUT */const char* options);

 extern void fsdbTransDPI_scope_add_enum_int_attribute(/* OUTPUT */int *state, /* INPUT */const char* scope_fullname, /* INPUT */const char* attribute_name, /* INPUT */unsigned int enum_id, /* INPUT */int attribute, /* INPUT */const char* options);

 extern int fsdbTransDPI_create_stream_begin(/* OUTPUT */int *state, /* INPUT */const char* stream_fullname, /* INPUT */const char* description, /* INPUT */const char* options);

 extern void fsdbTransDPI_define_logicvec_attribute(/* OUTPUT */int *state, /* INPUT */int sid, /* INPUT */const char* attribute_name, const /* INPUT */svLogicVecVal *attribute, /* INPUT */int numbit, /* INPUT */const char* options);

 extern void fsdbTransDPI_define_int_attribute(/* OUTPUT */int *state, /* INPUT */int sid, /* INPUT */const char* attribute_name, /* INPUT */int attribute, /* INPUT */const char* options);

 extern void fsdbTransDPI_define_string_attribute(/* OUTPUT */int *state, /* INPUT */int sid, /* INPUT */const char* attribute_name, /* INPUT */const char* attribute, /* INPUT */const char* options);

 extern void fsdbTransDPI_define_real_attribute(/* OUTPUT */int *state, /* INPUT */int sid, /* INPUT */const char* attribute_name, /* INPUT */double attribute, /* INPUT */const char* options);

 extern void fsdbTransDPI_define_enum_int_attribute(/* OUTPUT */int *state, /* INPUT */int sid, /* INPUT */const char* attribute_name, /* INPUT */unsigned int enum_id, /* INPUT */int attribute, /* INPUT */const char* options);

 extern void fsdbTransDPI_stream_add_logicvec_attribute(/* OUTPUT */int *state, /* INPUT */int sid, /* INPUT */const char* attribute_name, const /* INPUT */svLogicVecVal *attribute, /* INPUT */int numbit, /* INPUT */const char* options);

 extern void fsdbTransDPI_stream_add_int_attribute(/* OUTPUT */int *state, /* INPUT */int sid, /* INPUT */const char* attribute_name, /* INPUT */int attribute, /* INPUT */const char* options);

 extern void fsdbTransDPI_stream_add_string_attribute(/* OUTPUT */int *state, /* INPUT */int sid, /* INPUT */const char* attribute_name, /* INPUT */const char* attribute, /* INPUT */const char* options);

 extern void fsdbTransDPI_stream_add_real_attribute(/* OUTPUT */int *state, /* INPUT */int sid, /* INPUT */const char* attribute_name, /* INPUT */double attribute, /* INPUT */const char* options);

 extern void fsdbTransDPI_stream_add_enum_int_attribute(/* OUTPUT */int *state, /* INPUT */int sid, /* INPUT */const char* attribute_name, /* INPUT */unsigned int enum_id, /* INPUT */int attribute, /* INPUT */const char* options);

 extern void fsdbTransDPI_create_stream_end(/* OUTPUT */int *state, /* INPUT */int sid, /* INPUT */const char* options);

 extern int fsdbTransDPI_get_ended_stream_id(/* OUTPUT */int *state, /* INPUT */const char* stream_fullname, /* INPUT */const char* options);

 extern long long fsdbTransDPI_begin(/* OUTPUT */int *state, /* INPUT */int sid, /* INPUT */const char* trans_type, /* INPUT */const char* options);

 extern void fsdbTransDPI_set_label(/* OUTPUT */int *state, /* INPUT */long long tid, /* INPUT */const char* label, /* INPUT */const char* options);

 extern void fsdbTransDPI_add_tag(/* OUTPUT */int *state, /* INPUT */long long tid, /* INPUT */const char* tag, /* INPUT */const char* options);

 extern void fsdbTransDPI_add_logicvec_attribute(/* OUTPUT */int *state, /* INPUT */long long tid, /* INPUT */const char* attribute_name, const /* INPUT */svLogicVecVal *attribute, /* INPUT */int numbit, /* INPUT */const char* options);

 extern void fsdbTransDPI_add_bitvec_attribute(/* OUTPUT */int *state, /* INPUT */long long tid, /* INPUT */const char* attribute_name, const /* INPUT */svBitVecVal *attribute, /* INPUT */int numbit, /* INPUT */const char* options);

 extern void fsdbTransDPI_add_int_attribute(/* OUTPUT */int *state, /* INPUT */long long tid, /* INPUT */const char* attribute_name, /* INPUT */int attribute, /* INPUT */const char* options);

 extern void fsdbTransDPI_add_shortint_attribute(/* OUTPUT */int *state, /* INPUT */long long tid, /* INPUT */const char* attribute_name, /* INPUT */short int attribute, /* INPUT */const char* options);

 extern void fsdbTransDPI_add_longint_attribute(/* OUTPUT */int *state, /* INPUT */long long tid, /* INPUT */const char* attribute_name, /* INPUT */long long attribute, /* INPUT */const char* options);

 extern void fsdbTransDPI_add_string_attribute(/* OUTPUT */int *state, /* INPUT */long long tid, /* INPUT */const char* attribute_name, /* INPUT */const char* attribute, /* INPUT */const char* options);

 extern void fsdbTransDPI_add_real_attribute(/* OUTPUT */int *state, /* INPUT */long long tid, /* INPUT */const char* attribute_name, /* INPUT */double attribute, /* INPUT */const char* options);

 extern void fsdbTransDPI_add_enum_int_attribute(/* OUTPUT */int *state, /* INPUT */long long tid, /* INPUT */const char* attribute_name, /* INPUT */unsigned int enum_id, /* INPUT */int attribute, /* INPUT */const char* options);

 extern void fsdbTransDPI_add_logicvec_attribute_with_expected_value(/* OUTPUT */int *state, /* INPUT */long long tid, /* INPUT */const char* attribute_name, const /* INPUT */svLogicVecVal *attribute, /* INPUT */int numbit, const /* INPUT */svLogicVecVal *expected_val, /* INPUT */const char* options);

 extern void fsdbTransDPI_add_bitvec_attribute_with_expected_value(/* OUTPUT */int *state, /* INPUT */long long tid, /* INPUT */const char* attribute_name, const /* INPUT */svBitVecVal *attribute, /* INPUT */int numbit, const /* INPUT */svBitVecVal *expected_val, /* INPUT */const char* options);

 extern void fsdbTransDPI_add_int_attribute_with_expected_value(/* OUTPUT */int *state, /* INPUT */long long tid, /* INPUT */const char* attribute_name, /* INPUT */int attribute, /* INPUT */int expected_val, /* INPUT */const char* options);

 extern void fsdbTransDPI_add_shortint_attribute_with_expected_value(/* OUTPUT */int *state, /* INPUT */long long tid, /* INPUT */const char* attribute_name, /* INPUT */short int attribute, /* INPUT */short int expected_val, /* INPUT */const char* options);

 extern void fsdbTransDPI_add_longint_attribute_with_expected_value(/* OUTPUT */int *state, /* INPUT */long long tid, /* INPUT */const char* attribute_name, /* INPUT */long long attribute, /* INPUT */long long expected_val, /* INPUT */const char* options);

 extern void fsdbTransDPI_add_string_attribute_with_expected_value(/* OUTPUT */int *state, /* INPUT */long long tid, /* INPUT */const char* attribute_name, /* INPUT */const char* attribute, /* INPUT */const char* expected_val, /* INPUT */const char* options);

 extern void fsdbTransDPI_add_real_attribute_with_expected_value(/* OUTPUT */int *state, /* INPUT */long long tid, /* INPUT */const char* attribute_name, /* INPUT */double attribute, /* INPUT */double expected_val, /* INPUT */const char* options);

 extern void fsdbTransDPI_add_enum_int_attribute_with_expected_value(/* OUTPUT */int *state, /* INPUT */long long tid, /* INPUT */const char* attribute_name, /* INPUT */unsigned int enum_id, /* INPUT */int attribute, /* INPUT */int expected_val, /* INPUT */const char* options);

 extern void fsdbTransDPI_end(/* OUTPUT */int *state, /* INPUT */long long tid, /* INPUT */const char* options);

 extern void fsdbTransDPI_add_relation(/* OUTPUT */int *state, /* INPUT */const char* rel_name, /* INPUT */long long master_tid, /* INPUT */long long slave_tid, /* INPUT */const char* options);

 extern unsigned int fsdbTransDPI_get_enum_id(/* OUTPUT */int *state, /* INPUT */const char* enum_var_name);

 extern SV_STRING fsdbTransDPI_get_class_str(/* OUTPUT */int *state, /* INPUT */const char* class_var_name, /* INPUT */const char* options);

 extern int SLI_Init(/* INPUT */const char* serv_path);

 extern int SLI_Authorize_Token(/* INPUT */int group_id, /* INPUT */const char* product_spec, /* INOUT */SV_STRING *feats_checkedout, /* INPUT */int reg_off);

 extern int SLI_Errtext(/* INPUT */int error_status, /* INOUT */SV_STRING *error_str);

 extern int SLI_Authorize_XLMODE(/* INPUT */int group_id, /* INOUT */SV_STRING *feats_checkedout, /* INPUT */int reg_off);

 extern int svt_vcap__analyze_test(/* INPUT */const char* test_profile_path);

 extern int svt_vcap__get_group_count();

 extern int svt_vcap__get_group();

 extern SV_STRING svt_vcap__get_group_name();

 extern int svt_vcap__get_sequencer_count();

 extern int svt_vcap__get_sequencer();

 extern SV_STRING svt_vcap__get_sequencer_inst_path();

 extern SV_STRING svt_vcap__get_sequencer_sequencer_name();

 extern int svt_vcap__get_sequencer_resource_profile_count();

 extern int svt_vcap__get_sequencer_resource_profile();

 extern SV_STRING svt_vcap__get_sequencer_resource_profile_path();

 extern int svt_vcap__get_sequencer_resource_profile_attr_count();

 extern int svt_vcap__get_sequencer_resource_profile_attr();

 extern SV_STRING svt_vcap__get_sequencer_resource_profile_attr_name();

 extern SV_STRING svt_vcap__get_sequencer_resource_profile_attr_value();

 extern int svt_vcap__get_traffic_profile_count();

 extern int svt_vcap__get_traffic_profile();

 extern SV_STRING svt_vcap__get_traffic_profile_path();

 extern SV_STRING svt_vcap__get_traffic_profile_profile_name();

 extern SV_STRING svt_vcap__get_traffic_profile_component();

 extern SV_STRING svt_vcap__get_traffic_profile_protocol();

 extern int svt_vcap__get_traffic_profile_attr_count();

 extern int svt_vcap__get_traffic_profile_attr();

 extern SV_STRING svt_vcap__get_traffic_profile_attr_name();

 extern SV_STRING svt_vcap__get_traffic_profile_attr_value();

 extern int svt_vcap__get_traffic_resource_profile_count();

 extern int svt_vcap__get_traffic_resource_profile();

 extern SV_STRING svt_vcap__get_traffic_resource_profile_path();

 extern int svt_vcap__get_traffic_resource_profile_attr_count();

 extern int svt_vcap__get_traffic_resource_profile_attr();

 extern SV_STRING svt_vcap__get_traffic_resource_profile_attr_name();

 extern SV_STRING svt_vcap__get_traffic_resource_profile_attr_value();

 extern int svt_vcap__get_synchronization_spec();

 extern int svt_vcap__get_synchronization_spec_input_event_count();

 extern int svt_vcap__get_synchronization_spec_input_event();

 extern SV_STRING svt_vcap__get_synchronization_spec_input_event_event_name();

 extern SV_STRING svt_vcap__get_synchronization_spec_input_event_sequencer_name();

 extern SV_STRING svt_vcap__get_synchronization_spec_input_event_traffic_profile_name();

 extern int svt_vcap__get_synchronization_spec_output_event_count();

 extern int svt_vcap__get_synchronization_spec_output_event();

 extern SV_STRING svt_vcap__get_synchronization_spec_output_event_event_name();

 extern SV_STRING svt_vcap__get_synchronization_spec_output_event_sequencer_name();

 extern SV_STRING svt_vcap__get_synchronization_spec_output_event_traffic_profile_name();

 extern SV_STRING svt_vcap__get_synchronization_spec_output_event_output_event_type();

 extern SV_STRING svt_vcap__get_synchronization_spec_output_event_frame_size();

 extern SV_STRING svt_vcap__get_synchronization_spec_output_event_frame_time();

 extern void* svapfGetAttempt(/* INPUT */unsigned int assertHandle);

 extern void svapfReportResult(/* INPUT */unsigned int assertHandle, /* INPUT */void* ptrAttempt, /* INPUT */int result);

 extern int svapfGetAssertEnabled(/* INPUT */unsigned int assertHandle);
void SdisableFork();

#ifdef __cplusplus
}
#endif


#endif //#ifndef _VC_HDRS_H

