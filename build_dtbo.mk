#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

JAGAR_DTBO_SRC := $(KERNEL_SRC)/arch/$(KERNEL_ARCH)/boot/dts/mediatek/jagar.dts
JAGAR_DTBO_TMP := $(DTBO_OUT)/mediatek/jagar.dts.tmp
JAGAR_DTBO := $(DTBO_OUT)/mediatek/jagar.dtbo

MKDTBOIMG ?= $(HOST_OUT_EXECUTABLES)/mkdtboimg$(HOST_EXECUTABLE_SUFFIX)

$(DTBO_OUT):
	mkdir -p $(DTBO_OUT)

$(DTBO_OUT)/mediatek: $(DTBO_OUT)
	mkdir -p $@

$(JAGAR_DTBO): $(JAGAR_DTBO_SRC) $(KERNEL_CONFIG) $(DTC) | $(DTBO_OUT)/mediatek
	@echo "Building DTBO $@"
	$(PATH_OVERRIDE) $(TARGET_KERNEL_CLANG_PATH)/bin/clang -E -nostdinc -undef -D__DTS__ \
		-I$(DEVICE_PATH)/dtbo/include \
		-I$(KERNEL_SRC)/scripts/dtc/include-prefixes \
		-I$(KERNEL_SRC)/arch/$(KERNEL_ARCH)/boot/dts \
		-I$(KERNEL_SRC)/arch/$(KERNEL_ARCH)/boot/dts/include \
		-I$(KERNEL_OUT)/include \
		-x assembler-with-cpp -o $(JAGAR_DTBO_TMP) $<
	$(DTC) -@ -I dts -O dtb -o $@ \
		-i $(DEVICE_PATH)/dtbo/include \
		-i $(KERNEL_SRC)/scripts/dtc/include-prefixes \
		-i $(KERNEL_SRC)/arch/$(KERNEL_ARCH)/boot/dts \
		-i $(KERNEL_SRC)/arch/$(KERNEL_ARCH)/boot/dts/include \
		-i $(KERNEL_OUT)/include \
		$(JAGAR_DTBO_TMP)

$(BOARD_PREBUILT_DTBOIMAGE): $(JAGAR_DTBO) $(MKDTBOIMG)
	@echo "Building dtbo.img"
	mkdir -p $(dir $@)
	$(MKDTBOIMG) create $@ --page_size=$(BOARD_KERNEL_PAGESIZE) $(JAGAR_DTBO)
