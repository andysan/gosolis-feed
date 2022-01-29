#
# SPDX-FileCopyrightText: Copyright (c) 2019 Andreas Sandberg <andreas@sandberg.uk>
#
# SPDX-License-Identifier: BSD-3-Clause
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-gosolis
PKG_VERSION:=0.2
PKG_RELEASE:=1
PKG_MAINTAINER:=Andreas Sandberg <andreas@sandberg.uk>
PKG_LICENSE:=BSD-3-Clause

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

LUCI_LIBRARYDIR = /usr/lib/lua/luci

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-gosolis
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=GoSolis LuCI interface
	PKGARCH:=all
	DEPENDS:=+gosolis
endef

define Package/luci-app-gosolis/description
  Provides a webadmin for GoSolis.
endef

define Build/Compile
endef

define Package/luci-app-gosolis/install
	$(INSTALL_DIR) $(1)$(LUCI_LIBRARYDIR)
	cp -pR ./files/luasrc/* $(1)$(LUCI_LIBRARYDIR)/;
endef

$(eval $(call BuildPackage,luci-app-gosolis))
