<?xml version="1.0" encoding="UTF-8"?>
<sqlMap namespace="herb">
    <database id="herb" description="" >
        <![CDATA[
            ## 数据映射文件(database)，创建于2026/7/20 15:35:00
            
            -- ============================================================
            -- 中药材表 - herb
            -- ============================================================
            
            -- 查询药材列表（分页）
            SELECT id, name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications, created_at, updated_at
            FROM herb
            WHERE 1=1
            <if test="name != null and name != ''">
                AND name LIKE CONCAT('%', #{name}, '%')
            </if>
            <if test="category != null and category != ''">
                AND category = #{category}
            </if>
            <if test="nature != null and nature != ''">
                AND nature = #{nature}
            </if>
            ORDER BY created_at DESC
            LIMIT #{offset}, #{pageSize}
            
            -- 查询药材总数
            SELECT COUNT(*)
            FROM herb
            WHERE 1=1
            <if test="name != null and name != ''">
                AND name LIKE CONCAT('%', #{name}, '%')
            </if>
            <if test="category != null and category != ''">
                AND category = #{category}
            </if>
            <if test="nature != null and nature != ''">
                AND nature = #{nature}
            </if>
            
            -- 根据ID查询药材详情
            SELECT id, name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications, created_at, updated_at
            FROM herb
            WHERE id = #{id}
            
            -- 新增药材
            INSERT INTO herb (name, category, nature, taste, meridian, min_dosage, max_dosage, unit, is_toxic, functions, indications)
            VALUES (#{name}, #{category}, #{nature}, #{taste}, #{meridian}, #{minDosage}, #{maxDosage}, #{unit}, #{isToxic}, #{functions}, #{indications})
            
            -- 修改药材信息
            UPDATE herb
            SET name = #{name},
                category = #{category},
                nature = #{nature},
                taste = #{taste},
                meridian = #{meridian},
                min_dosage = #{minDosage},
                max_dosage = #{maxDosage},
                unit = #{unit},
                is_toxic = #{isToxic},
                functions = #{functions},
                indications = #{indications}
            WHERE id = #{id}
            
            -- 删除药材
            DELETE FROM herb WHERE id = #{id}
            
            -- ============================================================
            -- 配伍禁忌关系表 - herb_incompatibility
            -- ============================================================
            
            -- 查询配伍禁忌列表
            SELECT hi.id, hi.herb_a_id, hi.herb_b_id, hi.type, hi.detail,
                   ha.name AS herb_a_name, hb.name AS herb_b_name
            FROM herb_incompatibility hi
            LEFT JOIN herb ha ON hi.herb_a_id = ha.id
            LEFT JOIN herb hb ON hi.herb_b_id = hb.id
            WHERE 1=1
            <if test="herbId != null">
                AND (hi.herb_a_id = #{herbId} OR hi.herb_b_id = #{herbId})
            </if>
            <if test="type != null and type != ''">
                AND hi.type = #{type}
            </if>
            ORDER BY hi.id ASC
            
            -- 新增配伍禁忌
            INSERT INTO herb_incompatibility (herb_a_id, herb_b_id, type, detail)
            VALUES (#{herbAId}, #{herbBId}, #{type}, #{detail})
            
            -- 修改配伍禁忌
            UPDATE herb_incompatibility
            SET herb_a_id = #{herbAId},
                herb_b_id = #{herbBId},
                type = #{type},
                detail = #{detail}
            WHERE id = #{id}
            
            -- 删除配伍禁忌
            DELETE FROM herb_incompatibility WHERE id = #{id}
            
            -- ============================================================
            -- 方剂表 - formula
            -- ============================================================
            
            -- 查询方剂列表（分页）
            SELECT id, name, category_l1, category_l2, functions, indications, modifications, source, created_at, updated_at
            FROM formula
            WHERE 1=1
            <if test="name != null and name != ''">
                AND name LIKE CONCAT('%', #{name}, '%')
            </if>
            <if test="categoryL1 != null and categoryL1 != ''">
                AND category_l1 = #{categoryL1}
            </if>
            ORDER BY created_at DESC
            LIMIT #{offset}, #{pageSize}
            
            -- 查询方剂总数
            SELECT COUNT(*)
            FROM formula
            WHERE 1=1
            <if test="name != null and name != ''">
                AND name LIKE CONCAT('%', #{name}, '%')
            </if>
            <if test="categoryL1 != null and categoryL1 != ''">
                AND category_l1 = #{categoryL1}
            </if>
            
            -- 根据ID查询方剂详情
            SELECT id, name, category_l1, category_l2, functions, indications, modifications, source, created_at, updated_at
            FROM formula
            WHERE id = #{id}
            
            -- 新增方剂
            INSERT INTO formula (name, category_l1, category_l2, functions, indications, modifications, source)
            VALUES (#{name}, #{categoryL1}, #{categoryL2}, #{functions}, #{indications}, #{modifications}, #{source})
            
            -- 修改方剂信息
            UPDATE formula
            SET name = #{name},
                category_l1 = #{categoryL1},
                category_l2 = #{categoryL2},
                functions = #{functions},
                indications = #{indications},
                modifications = #{modifications},
                source = #{source}
            WHERE id = #{id}
            
            -- 删除方剂
            DELETE FROM formula WHERE id = #{id}
            
            -- ============================================================
            -- 方剂-药材关联表 - formula_herb
            -- ============================================================
            
            -- 查询方剂药材明细
            SELECT fh.id, fh.formula_id, fh.herb_id, fh.dosage, fh.sort_order,
                   h.name AS herb_name, h.category, h.nature, h.taste
            FROM formula_herb fh
            LEFT JOIN herb h ON fh.herb_id = h.id
            WHERE fh.formula_id = #{formulaId}
            ORDER BY fh.sort_order ASC
            
            -- 新增方剂药材关联
            INSERT INTO formula_herb (formula_id, herb_id, dosage, sort_order)
            VALUES (#{formulaId}, #{herbId}, #{dosage}, #{sortOrder})
            
            -- 修改方剂药材关联
            UPDATE formula_herb
            SET dosage = #{dosage},
                sort_order = #{sortOrder}
            WHERE id = #{id}
            
            -- 删除方剂药材关联
            DELETE FROM formula_herb WHERE id = #{id}
            
            -- 批量删除方剂药材关联
            DELETE FROM formula_herb WHERE formula_id = #{formulaId}
            
        ]]>
    </database>
</sqlMap>