#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=PEZM-004T
PKG_VERSION:=1.0.1
PKG_RELEASE:=5
PKG_MAINTAINER:=Armand Huqi
PKG_LICENSE:=GPL-2
PKG_CONFIG_DEPENDS:=libcurl

include $(INCLUDE_DIR)/package.mk

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

TARGET_LDFLAGS+= \
  -Wl,-rpath-link=$(STAGING_DIR)/usr/lib \
  -Wl,-rpath-link=$(STAGING_DIR)/usr/lib/libcurl/lib \
  -Wl,-rpath-link=$(STAGING_DIR)/usr/lib/libcurl/lib

define Package/load2sqlite
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+libcurl 
  TITLE:=A simple script to read write from PEZM-004T
  URL:=https://github.com/alabamas/PEZM-004T
  MENU:=1
endef

define Package/PEZM-004T/description
 Example SQLite is a sample program built using libsqlite3 and libconfig
 which creates or opens a user-defined SQLite3 database and performs some
 simple verification checks on the file to ensure that the target table (readings)
 exists, and if not creates the table, then inserts a row with the current system
 time, and the load (1 minute, 5 minute, 15 minute).
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Build/Configure
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) $(TARGET_CONFIGURE_OPTS)
endef

define Package/load2sqlite/install
	$(INSTALL_DIR) $(1)/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/PEZM-004T $(1)/bin/
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/PEZM-004T.conf $(1)/etc/config/PEZM-004T
endef

$(eval $(call BuildPackage,PEZM-004T))
