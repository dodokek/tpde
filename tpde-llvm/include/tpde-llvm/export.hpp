#pragma once

#ifdef TPDE_LLVM_EXPORTS
    #define TPDE_LLVM_API __attribute__((visibility("default")))
#else
    #define TPDE_LLVM_API
#endif