// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XREVERSI_ACCEL_H
#define XREVERSI_ACCEL_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xreversi_accel_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
    u16 DeviceId;
    u32 Control_BaseAddress;
} XReversi_accel_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XReversi_accel;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XReversi_accel_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XReversi_accel_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XReversi_accel_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XReversi_accel_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XReversi_accel_Initialize(XReversi_accel *InstancePtr, u16 DeviceId);
XReversi_accel_Config* XReversi_accel_LookupConfig(u16 DeviceId);
int XReversi_accel_CfgInitialize(XReversi_accel *InstancePtr, XReversi_accel_Config *ConfigPtr);
#else
int XReversi_accel_Initialize(XReversi_accel *InstancePtr, const char* InstanceName);
int XReversi_accel_Release(XReversi_accel *InstancePtr);
#endif

void XReversi_accel_Start(XReversi_accel *InstancePtr);
u32 XReversi_accel_IsDone(XReversi_accel *InstancePtr);
u32 XReversi_accel_IsIdle(XReversi_accel *InstancePtr);
u32 XReversi_accel_IsReady(XReversi_accel *InstancePtr);
void XReversi_accel_EnableAutoRestart(XReversi_accel *InstancePtr);
void XReversi_accel_DisableAutoRestart(XReversi_accel *InstancePtr);

void XReversi_accel_Set_data_in(XReversi_accel *InstancePtr, u64 Data);
u64 XReversi_accel_Get_data_in(XReversi_accel *InstancePtr);
void XReversi_accel_Set_rho_out(XReversi_accel *InstancePtr, u64 Data);
u64 XReversi_accel_Get_rho_out(XReversi_accel *InstancePtr);
void XReversi_accel_Set_theta_out(XReversi_accel *InstancePtr, u64 Data);
u64 XReversi_accel_Get_theta_out(XReversi_accel *InstancePtr);
void XReversi_accel_Set_height(XReversi_accel *InstancePtr, u32 Data);
u32 XReversi_accel_Get_height(XReversi_accel *InstancePtr);
void XReversi_accel_Set_width(XReversi_accel *InstancePtr, u32 Data);
u32 XReversi_accel_Get_width(XReversi_accel *InstancePtr);
void XReversi_accel_Set_stride(XReversi_accel *InstancePtr, u32 Data);
u32 XReversi_accel_Get_stride(XReversi_accel *InstancePtr);

void XReversi_accel_InterruptGlobalEnable(XReversi_accel *InstancePtr);
void XReversi_accel_InterruptGlobalDisable(XReversi_accel *InstancePtr);
void XReversi_accel_InterruptEnable(XReversi_accel *InstancePtr, u32 Mask);
void XReversi_accel_InterruptDisable(XReversi_accel *InstancePtr, u32 Mask);
void XReversi_accel_InterruptClear(XReversi_accel *InstancePtr, u32 Mask);
u32 XReversi_accel_InterruptGetEnabled(XReversi_accel *InstancePtr);
u32 XReversi_accel_InterruptGetStatus(XReversi_accel *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
