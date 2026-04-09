detach_all_packages <- function() {
  # 获取已加载的包
  loaded_pkgs <- grep("^package:", search(), value = TRUE)
  
  # 核心包列表
  core_pkgs <- c(
    "package:base", "package:stats", "package:graphics",
    "package:grDevices", "package:utils", "package:datasets",
    "package:methods"
  )
  
  # 待移除的非核心包
  to_detach <- setdiff(loaded_pkgs, core_pkgs)
  
  # 逆序移除
  if (length(to_detach) > 0) {
    for (pkg in rev(to_detach)) {
      detach(pkg, character.only = TRUE, unload = TRUE, force = TRUE)
      message(paste("Detached:", pkg))
    }
  } else {
    message("No non-core packages to detach.")
  }
}

detach_all_packages()