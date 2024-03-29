#
# SPDX-FileCopyrightText: Copyright (c) 2019, 2022 Andreas Sandberg <andreas@sandberg.uk>
#
# SPDX-License-Identifier: BSD-3-Clause
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gosolis
PKG_VERSION:=0.2
PKG_RELEASE:=1

PKG_MAINTAINER:=Andreas Sandberg <andreas@sandberg.uk>
PKG_LICENSE:=BSD-3-Clause

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/andysan/gosolis.git
PKG_SOURCE_VERSION:=2c81ed7bd7d6804aa4e1a471acb86fb6d232cfce
PKG_MIRROR_HASH:=89b5bfb45976820f2dce7025dab7878509153e3828d72d6fe7479f19a7db3f1c

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

GO_PKG:=github.com/andysan/gosolis
GO_PKG_BUILD_PKG:=$(GO_PKG)/cmd/gosolis

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/gosolis
  TITLE:=an interface for Ginlong Solis inverters
  DEPENDS:=$(GO_ARCH_DEPENDS)
  URL:=https://github.com/andysan/gosolis.git
  SECTION:=utils
  CATEGORY:=Utilities
endef

define Package/gosolis/description
endef

define Package/gosolis/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(GO_PKG_BUILD_BIN_DIR)/gosolis $(1)/usr/bin/
	$(INSTALL_BIN) ./files/gosolis_uci_config $(1)/usr/bin/gosolis_uci_config
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/gosolis.init $(1)/etc/init.d/gosolis
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_BIN) ./files/gosolis.conf $(1)/etc/config/gosolis
endef

$(eval $(call GoBinPackage,gosolis))
$(eval $(call BuildPackage,gosolis))
