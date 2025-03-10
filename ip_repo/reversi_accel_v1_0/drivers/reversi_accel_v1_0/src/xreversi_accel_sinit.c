// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xreversi_accel.h"

extern XReversi_accel_Config XReversi_accel_ConfigTable[];

XReversi_accel_Config *XReversi_accel_LookupConfig(u16 DeviceId) {
	XReversi_accel_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XREVERSI_ACCEL_NUM_INSTANCES; Index++) {
		if (XReversi_accel_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XReversi_accel_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XReversi_accel_Initialize(XReversi_accel *InstancePtr, u16 DeviceId) {
	XReversi_accel_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XReversi_accel_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XReversi_accel_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

