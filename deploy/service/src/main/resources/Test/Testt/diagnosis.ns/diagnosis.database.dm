<?xml version="1.0" encoding="UTF-8"?>
<sqlMap namespace="diagnosis">
    <database id="diagnosis" description="" >
        <![CDATA[
            <?xml version="1.0" encoding="UTF-8"?>
            <sqlMap namespace="diagnosis">
                <!-- ============================================================ -->
                <!-- 辨证诊断结果表 - diagnosis_result                             -->
                <!-- ============================================================ -->
                <database id="list" description="查询诊断结果列表（按就诊记录）">
                    <![CDATA[
                        SELECT id, visit_id, pattern_name, pattern_code, confidence, description, symptoms, etiology, pathogenesis, is_selected, source, created_at
                        FROM diagnosis_result
                        WHERE visit_id = #{visitId}
                        ORDER BY confidence DESC
                    ]]>
                </database>
                <database id="detail" description="根据ID查询诊断结果详情">
                    <![CDATA[
                        SELECT id, visit_id, pattern_name, pattern_code, confidence, description, symptoms, etiology, pathogenesis, is_selected, source, created_at
                        FROM diagnosis_result
                        WHERE id = #{id}
                    ]]>
                </database>
                <database id="insert" description="新增诊断结果">
                    <![CDATA[
                        INSERT INTO diagnosis_result (visit_id, pattern_name, pattern_code, confidence, description, symptoms, etiology, pathogenesis, is_selected, source)
                        VALUES (#{visitId}, #{patternName}, #{patternCode}, #{confidence}, #{description}, #{symptoms}, #{etiology}, #{pathogenesis}, #{isSelected}, #{source})
                    ]]>
                </database>
                <database id="update" description="修改诊断结果">
                    <![CDATA[
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
                    ]]>
                </database>
                <database id="delete" description="删除诊断结果">
                    <![CDATA[
                        DELETE FROM diagnosis_result WHERE id = #{id}
                    ]]>
                </database>
                <database id="batchDeleteByVisit" description="批量删除某就诊记录的所有诊断结果">
                    <![CDATA[
                        DELETE FROM diagnosis_result WHERE visit_id = #{visitId}
                    ]]>
                </database>
            
                <!-- ============================================================ -->
                <!-- 证型知识表 - syndrome_pattern                                 -->
                <!-- ============================================================ -->
                <database id="syndromeList" description="查询证型列表（分页）">
                    <![CDATA[
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
                    ]]>
                </database>
                <database id="syndromeCount" description="查询证型总数">
                    <![CDATA[
                        SELECT COUNT(*)
                        FROM syndrome_pattern
                        WHERE 1=1
                        <if test="patternName != null and patternName != ''">
                            AND pattern_name LIKE CONCAT('%', #{patternName}, '%')
                        </if>
                        <if test="category != null and category != ''">
                            AND category = #{category}
                        </if>
                    ]]>
                </database>
                <database id="syndromeDetail" description="根据ID查询证型详情">
                    <![CDATA[
                        SELECT id, pattern_name, pattern_code, category, etiology, pathogenesis, key_symptoms, pulse_pattern, tongue_pattern, differentiation, treatment_method, recommended_formula, related_diagnosis, sort_order, created_at, updated_at
                        FROM syndrome_pattern
                        WHERE id = #{id}
                    ]]>
                </database>
                <database id="syndromeInsert" description="新增证型">
                    <![CDATA[
                        INSERT INTO syndrome_pattern (pattern_name, pattern_code, category, etiology, pathogenesis, key_symptoms, pulse_pattern, tongue_pattern, differentiation, treatment_method, recommended_formula, related_diagnosis, sort_order)
                        VALUES (#{patternName}, #{patternCode}, #{category}, #{etiology}, #{pathogenesis}, #{keySymptoms}, #{pulsePattern}, #{tonguePattern}, #{differentiation}, #{treatmentMethod}, #{recommendedFormula}, #{relatedDiagnosis}, #{sortOrder})
                    ]]>
                </database>
                <database id="syndromeUpdate" description="修改证型信息">
                    <![CDATA[
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
                    ]]>
                </database>
                <database id="syndromeDelete" description="删除证型">
                    <![CDATA[
                        DELETE FROM syndrome_pattern WHERE id = #{id}
                    ]]>
                </database>
            
                <!-- ============================================================ -->
                <!-- 症状/标签字典表 - symptom_dict                                -->
                <!-- ============================================================ -->
                <database id="symptomList" description="查询症状字典列表（按分类）">
                    <![CDATA[
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
                    ]]>
                </database>
                <database id="symptomDetail" description="根据ID查询症状详情">
                    <![CDATA[
                        SELECT id, category, sub_category, label, sort_order, is_common, weight, created_at
                        FROM symptom_dict
                        WHERE id = #{id}
                    ]]>
                </database>
                <database id="symptomInsert" description="新增症状标签">
                    <![CDATA[
                        INSERT INTO symptom_dict (category, sub_category, label, sort_order, is_common, weight)
                        VALUES (#{category}, #{subCategory}, #{label}, #{sortOrder}, #{isCommon}, #{weight})
                    ]]>
                </database>
                <database id="symptomUpdate" description="修改症状标签">
                    <![CDATA[
                        UPDATE symptom_dict
                        SET sub_category = #{subCategory},
                            label = #{label},
                            sort_order = #{sortOrder},
                            is_common = #{isCommon},
                            weight = #{weight}
                        WHERE id = #{id}
                    ]]>
                </database>
                <database id="symptomDelete" description="删除症状标签">
                    <![CDATA[
                        DELETE FROM symptom_dict WHERE id = #{id}
                    ]]>
                </database>
            </sqlMap>
            
        ]]>
    </database>
</sqlMap>