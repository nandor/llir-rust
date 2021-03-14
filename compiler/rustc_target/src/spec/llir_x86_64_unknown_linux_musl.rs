use crate::spec::{Target};

pub fn target() -> Target {
    let mut base = super::linux_musl_base::opts();
    base.cpu = "x86-64".to_string();
    base.max_atomic_width = Some(64);
    base.archive_format = "gnu".to_string();
    base.dynamic_linking = true;
    base.crt_static_default = false;
    base.is_llir = true;
    base.forces_embed_bitcode = false;

    Target {
        llvm_target: "llir_x86_64-unknown-linux-musl".to_string(),
        pointer_width: 64,
        data_layout: "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
            .to_string(),
        arch: "llir_x86_64".to_string(),
        options: base,
    }
}
