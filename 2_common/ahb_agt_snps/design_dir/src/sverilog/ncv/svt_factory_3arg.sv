//=======================================================================
// COPYRIGHT (C) 2015 SYNOPSYS INC.
//
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_FACTORY_3ARG_SV
`define GUARD_SVT_FACTORY_3ARG_SV

/** @cond PRIVATE */

//-----------------------------------------------------------------------

/**
 * Named-base class factory for class hierarchies
 * whose constructor has three arguments.
 * The type of the constructor arguments are parameterized.
 */
virtual class  svt_factory_3arg #(type BASE_TYPE = int,
                                  type ARG1_TYPE = int,
                                  type ARG2_TYPE = int,
                                  type ARG3_TYPE = int);

  typedef svt_factory_3arg#(BASE_TYPE, ARG1_TYPE, ARG2_TYPE, ARG3_TYPE) this_type;

`ifdef SVT_VMM_TECHNOLOGY
  /** Default message reporter */
  static vmm_log log = new("svt_factory_3arg", "class");
`endif
  
  /** Class registry */
  local static this_type m_entries[string];

  /**
   * Function that does the actual object creation.
   * Must be overloaded by every type that registers
   * an entry in the factory.
   *
   * @param arg1      First argument to the object's constructor
   * @param arg2      Second argument to the object's constructor
   * @param arg3      Third argument to the object's constructor
   */
  pure virtual function BASE_TYPE do_create(ARG1_TYPE arg1,
                                            ARG2_TYPE arg2,
                                            ARG3_TYPE arg3);

  /**
   * Registration function, usually called via a static initialized
   *
   * @param name  Name of the type to be created by this factory entry
   * @param entry Factory entry to create an object of the named type.
   */  
  static function void register(string name,
                                this_type entry);
    m_entries[name] = entry;
  endfunction

  /**
   * Create an instance of the requested type.
   * If not found, will suggest that the specified package be included
   *
   * @param name      Name of the type to be created
   * @param arg1      First argument to the object's constructor
   * @param arg2      Second argument to the object's constructor
   * @param arg3      Third argument to the object's constructor
   * @param pkg_name  Name of the package that should contain the named type
   */
  static function BASE_TYPE create(string name,
                                   ARG1_TYPE arg1,
                                   ARG2_TYPE arg2,
                                   ARG3_TYPE arg3,
                                   string    pkg_name);
    if (m_entries.exists(name)) begin
      create = m_entries[name].do_create(arg1, arg2, arg3);
    end
    else begin
`ifndef SVT_VMM_TECHNOLOGY
      `SVT_XVM(report_object) reporter = `SVT_XVM(root)::get();
`endif
      `svt_fatal("svt_factory_3arg::create()",
                 {"Attempting to create an instance of unknown type name ",
                  name, ". Make sure the package ", pkg_name, " is loaded."});
      create = null;
    end
  endfunction
endclass

/** @endcond */

`endif
