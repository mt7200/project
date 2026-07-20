package com.sunsheen.hearken.Sunsheen_system.tcm.common.util;

import com.sunsheen.hearken.Sunsheen_system.login.common.constant.R;

public class ResponseUtil {

    public static <T> R<T> success(T data) {
        return R.success(data);
    }

    public static <T> R<T> success() {
        return R.success();
    }

    public static <T> R<T> failed(String msg) {
        return R.failed(null, msg, null, null);
    }

    public static <T> R<T> notFound(String msg) {
        return R.failed(null, msg, null, null);
    }

    private ResponseUtil() {}
}
