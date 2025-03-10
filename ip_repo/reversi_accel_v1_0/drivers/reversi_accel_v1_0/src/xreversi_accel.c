// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xreversi_accel.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XReversi_accel_CfgInitialize(XReversi_accel *InstancePtr, XReversi_accel_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XReversi_accel_Start(XReversi_accel *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XReversi_accel_ReadReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_AP_CTRL) & 0x80;
    XReversi_accel_WriteReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XReversi_accel_IsDone(XReversi_accel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XReversi_accel_ReadReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XReversi_accel_IsIdle(XReversi_accel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XReversi_accel_ReadReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XReversi_accel_IsReady(XReversi_accel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XReversi_accel_ReadReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XReversi_accel_EnableAutoRestart(XReversi_accel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XReversi_accel_WriteReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XReversi_accel_DisableAutoRestart(XReversi_accel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XReversi_accel_WriteReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_AP_CTRL, 0);
}

void XReversi_accel_Set_data_in(XReversi_accel *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XReversi_accel_WriteReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_DATA_IN_DATA, (u32)(Data));
    XReversi_accel_WriteReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_DATA_IN_DATA + 4, (u32)(Data >> 32));
}

u64 XReversi_accel_Get_data_in(XReversi_accel *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XReversi_accel_ReadReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_DATA_IN_DATA);
    Data += (u64)XReversi_accel_ReadReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_DATA_IN_DATA + 4) << 32;
    return Data;
}

void XReversi_accel_Set_rho_out(XReversi_accel *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XReversi_accel_WriteReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_RHO_OUT_DATA, (u32)(Data));
    XReversi_accel_WriteReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_RHO_OUT_DATA + 4, (u32)(Data >> 32));
}

u64 XReversi_accel_Get_rho_out(XReversi_accel *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XReversi_accel_ReadReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_RHO_OUT_DATA);
    Data += (u64)XReversi_accel_ReadReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_RHO_OUT_DATA + 4) << 32;
    return Data;
}

void XReversi_accel_Set_theta_out(XReversi_accel *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XReversi_accel_WriteReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_THETA_OUT_DATA, (u32)(Data));
    XReversi_accel_WriteReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_THETA_OUT_DATA + 4, (u32)(Data >> 32));
}

u64 XReversi_accel_Get_theta_out(XReversi_accel *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XReversi_accel_ReadReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_THETA_OUT_DATA);
    Data += (u64)XReversi_accel_ReadReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_THETA_OUT_DATA + 4) << 32;
    return Data;
}

void XReversi_accel_Set_height(XReversi_accel *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XReversi_accel_WriteReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_HEIGHT_DATA, Data);
}

u32 XReversi_accel_Get_height(XReversi_accel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XReversi_accel_ReadReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_HEIGHT_DATA);
    return Data;
}

void XReversi_accel_Set_width(XReversi_accel *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XReversi_accel_WriteReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_WIDTH_DATA, Data);
}

u32 XReversi_accel_Get_width(XReversi_accel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XReversi_accel_ReadReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_WIDTH_DATA);
    return Data;
}

void XReversi_accel_Set_stride(XReversi_accel *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XReversi_accel_WriteReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_STRIDE_DATA, Data);
}

u32 XReversi_accel_Get_stride(XReversi_accel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XReversi_accel_ReadReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_STRIDE_DATA);
    return Data;
}

void XReversi_accel_InterruptGlobalEnable(XReversi_accel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XReversi_accel_WriteReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_GIE, 1);
}

void XReversi_accel_InterruptGlobalDisable(XReversi_accel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XReversi_accel_WriteReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_GIE, 0);
}

void XReversi_accel_InterruptEnable(XReversi_accel *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XReversi_accel_ReadReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_IER);
    XReversi_accel_WriteReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_IER, Register | Mask);
}

void XReversi_accel_InterruptDisable(XReversi_accel *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XReversi_accel_ReadReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_IER);
    XReversi_accel_WriteReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_IER, Register & (~Mask));
}

void XReversi_accel_InterruptClear(XReversi_accel *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XReversi_accel_WriteReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_ISR, Mask);
}

u32 XReversi_accel_InterruptGetEnabled(XReversi_accel *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XReversi_accel_ReadReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_IER);
}

u32 XReversi_accel_InterruptGetStatus(XReversi_accel *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XReversi_accel_ReadReg(InstancePtr->Control_BaseAddress, XREVERSI_ACCEL_CONTROL_ADDR_ISR);
}

