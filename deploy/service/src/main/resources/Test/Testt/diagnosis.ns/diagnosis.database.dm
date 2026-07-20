<?xml version="1.0" encoding="UTF-8"?>
<sqlMap namespace="diagnosis">
    <database id="diagnosis" description="" >
        <![CDATA[
            ## 数据映射文件(database)，创建于2026/7/20 15:35:00
            
            -- ============================================================
            -- 辨证诊断结果表 - diagnosis_result
            -- ============================================================
            
            -- 查询诊断结果列表（按就诊记录）
            SELECT id, visit_id, pattern_name, pattern_code, confidence, description, symptoms, etiology, pathogenesis, is_selected, source, created_at
            FROM diagnosis_result
            WHERE visit_id = #{visitId}
            ORDER BY confidence DESC
            
            -- 根据ID查询诊断结果详情
            SELECT id, visit_id, pattern_name, pattern_code, confidence, description, symptoms, etiology, pathogenesis, is_selected, source, created_at
            FROM diagnosis_result
            WHERE id = #{id}
            
            -- 新增诊断结果
            INSERT INTO diagnosis_result (visit_id, pattern_name, pattern_code, confidence, description, symptoms, etiology, pathogenesis, is_selected, source)
            VALUES (#{visitId}, #{patternName}, #{patternCode}, #{confidence}, #{description}, #{symptoms}, #{etiology}, #{pathogenesis}, #{isSelected}, #{source})
            
            -- 修改诊断结果
            UPDATE diagnosis_result
            SET pattern_name = #{patternName},
                pattern_code = #{patternCode},
                confidence = #{confidence},
                description = #{description},
                symptoms = #{symptoms},
                etiology = #{etiology},
                pathogenesis = #{pathogenesis},
                is_selected = #{isSelected}
            WHERE id = #{id}
            
            -- 删除诊断结果
            DELETE FROM diagnosis_result WHERE id = #{id}
            
            -- 批量删除某就诊记录的所有诊断结果
            DELETE FROM diagnosis_result WHERE visit_id = #{visitId}
            
            -- ============================================================
            -- 证型知识表 - syndrome_pattern
            -- ============================================================
            
            -- 查询证型列表（分页）
            SELECT id, pattern_name, pattern_code, category, etiology, pathogenesis, key_symptoms, pulse_pattern, tongue_pattern, differentiation, treatment_method, recommended_formula, related_diagnosis, sort_order, created_at, updated_at
            FROM syndrome_pattern
            WHERE 1=1
            <if test="patternName != null and patternName != ''">
                AND pattern_name LIKE CONCAT('%', #{patternName}, '%')
            </if>
            <if test="category != null and category != ''">
                AND category = #{category}
            </if>
            ORDER BY sort_order ASC
            LIMIT #{offset}, #{pageSize}
            
            -- 查询证型总数
            SELECT COUNT(*)
            FROM syndrome_pattern
            WHERE 1=1
            <if test="patternName != null and patternName != ''">
                AND pattern_name LIKE CONCAT('%', #{patternName}, '%')
            </if>
            <if test="category != null and category != ''">
                AND category = #{category}
            </if>
            
            -- 根据ID查询证型详情
            SELECT id, pattern_name, pattern_code, category, etiology, pathogenesis, key_symptoms, pulse_pattern, tongue_pattern, differentiation, treatment_method, recommended_formula, related_diagnosis, sort_order, created_at, updated_at
            FROM syndrome_pattern
            WHERE id = #{id}
            
            -- 新增证型
            INSERT INTO syndrome_pattern (pattern_name, pattern_code, category, etiology, pathogenesis, key_symptoms, pulse_pattern, tongue_pattern, differentiation, treatment_method, recommended_formula, related_diagnosis, sort_order)
            VALUES (#{patternName}, #{patternCode}, #{category}, #{etiology}, #{pathogenesis}, #{keySymptoms}, #{pulsePattern}, #{tonguePattern}, #{differentiation}, #{treatmentMethod}, #{recommendedFormula}, #{relatedDiagnosis}, #{sortOrder})
            
            -- 修改证型信息
            UPDATE syndrome_pattern
            SET pattern_name = #{patternName},
                pattern_code = #{patternCode},
                category = #{category},
                etiology = #{etiology},
                pathogenesis = #{pathogenesis},
                key_symptoms = #{keySymptoms},
                pulse_pattern = #{pulsePattern},
                tongue_pattern = #{tonguePattern},
                differentiation = #{differentiation},
                treatment_method = #{treatmentMethod},
                recommended_formula = #{recommendedFormula},
                related_diagnosis = #{relatedDiagnosis},
                sort_order = #{sortOrder}
            WHERE id = #{id}
            
            -- 删除证型
            DELETE FROM syndrome_pattern WHERE id = #{id}
            
            -- ============================================================
            -- 症状/标签字典表 - symptom_dict
            -- ============================================================
            
            -- 查询症状字典列表（按分类）
            SELECT id, category, sub_category, label, sort_order, is_common, weight, created_at
            FROM symptom_dict
            WHERE 1=1
            <if test="category != null and category != ''">
                AND category = #{category}
            </if>
            <if test="subCategory != null and subCategory != ''">
                AND sub_category = #{subCategory}
            </if>
            <if test="label != null and label != ''">
                AND label LIKE CONCAT('%', #{label}, '%')
            </if>
            <if test="isCommon != null">
                AND is_common = #{isCommon}
            </if>
            ORDER BY sort_order ASC
            
            -- 根据ID查询症状详情
            SELECT id, category, sub_category, label, sort_order, is_common, weight, created_at
            FROM symptom_dict
            WHERE id = #{id}
            
            -- 新增症状标签
            INSERT INTO symptom_dict (category, sub_category, label, sort_order, is_common, weight)
            VALUES (#{category}, #{subCategory}, #{label}, #{sortOrder}, #{isCommon}, #{weight})
            
            -- 修改症状标签
            UPDATE symptom_dict
            SET sub_category = #{subCategory},
                label = #{label},
                sort_order = #{sortOrder},
                is_common = #{isCommon},
                weight = #{weight}
            WHERE id = #{id}
            
            -- 删除症状标签
            DELETE FROM symptom_dict WHERE id = #{id}
            
        ]]>
    </database>
</sqlMap>