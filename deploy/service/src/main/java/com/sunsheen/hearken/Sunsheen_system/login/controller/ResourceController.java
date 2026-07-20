package com.sunsheen.hearken.Sunsheen_system.login.controller;

import com.sunsheen.hearken.Sunsheen_system.login.common.constant.R;
import com.sunsheen.hearken.Sunsheen_system.login.common.constant.ResponseCode;
import com.sunsheen.jfids.hearken.component.login.dto.ResourceDTO;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static com.sunsheen.hearken.Sunsheen_system.login.common.constant.Const.SERVER_API_PATH;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping(SERVER_API_PATH + "/resource")
public class ResourceController {
    private final SystemManagerStrategyFactory strategyFactory;

    @GetMapping("/resources")
    public R<List<ResourceDTO>> getResourceList(
            @RequestParam(required = false) String parentId,
            @RequestParam(required = false) Integer resourceType) {
        try {
            return R.success(strategyFactory.getResourceManager()
                    .getResourceListByParentIdAndType(parentId, resourceType));
        } catch (Exception e) {
            log.error("获取资源列表失败", e);
            return R.failed(ResponseCode.INTERNAL_SERVER_ERROR, "获取资源列表失败", e.getMessage(), null);
        }
    }

    @GetMapping("/resources/{resourceId}")
    public R<ResourceDTO> getResourceById(@PathVariable String resourceId) {
        try {
            return R.success(strategyFactory.getResourceManager().getResourceById(resourceId));
        } catch (Exception e) {
            log.error("获取资源详情失败，resourceId: {}", resourceId, e);
            return R.failed(ResponseCode.INTERNAL_SERVER_ERROR, "获取资源详情失败", e.getMessage(), null);
        }
    }

    @PostMapping("/resources")
    public R<Void> createResource(@Valid @RequestBody ResourceDTO resourceDTO) {
        strategyFactory.getResourceManager().createResource(resourceDTO);
        return R.success();
    }

    @PutMapping("/resources/{resourceId}")
    public R<Void> updateResource(@PathVariable String resourceId, @Valid @RequestBody ResourceDTO resourceDTO) {
        strategyFactory.getResourceManager().updateResource(resourceId, resourceDTO);
        return R.success();
    }

    @DeleteMapping("/resources/{resourceId}")
    public R<Void> deleteResource(@PathVariable String resourceId) {
        strategyFactory.getResourceManager().deleteResource(resourceId);
        return R.success();
    }
}
