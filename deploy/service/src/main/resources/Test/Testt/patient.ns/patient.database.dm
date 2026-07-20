<?xml version="1.0" encoding="UTF-8"?>
<sqlMap namespace="patient">
    <database id="patient" description="" >
        <![CDATA[
            ## 数据映射文件(database)，创建于2026/7/20 15:35:00
            
            -- ============================================================
            -- 系统用户表 - sys_user
            -- ============================================================
            
            -- 查询用户列表（分页）
            SELECT id, username, role, real_name, phone, is_active, created_at, updated_at
            FROM sys_user
            WHERE 1=1
            <if test="username != null and username != ''">
                AND username LIKE CONCAT('%', #{username}, '%')
            </if>
            <if test="role != null and role != ''">
                AND role = #{role}
            </if>
            <if test="isActive != null">
                AND is_active = #{isActive}
            </if>
            ORDER BY created_at DESC
            LIMIT #{offset}, #{pageSize}
            
            -- 查询用户总数
            SELECT COUNT(*)
            FROM sys_user
            WHERE 1=1
            <if test="username != null and username != ''">
                AND username LIKE CONCAT('%', #{username}, '%')
            </if>
            <if test="role != null and role != ''">
                AND role = #{role}
            </if>
            <if test="isActive != null">
                AND is_active = #{isActive}
            </if>
            
            -- 根据ID查询用户详情
            SELECT id, username, role, real_name, phone, is_active, created_at, updated_at
            FROM sys_user
            WHERE id = #{id}
            
            -- 根据用户名查询用户
            SELECT id, username, password_hash, role, real_name, phone, is_active, created_at, updated_at
            FROM sys_user
            WHERE username = #{username}
            
            -- 新增用户
            INSERT INTO sys_user (username, password_hash, role, real_name, phone, is_active)
            VALUES (#{username}, #{passwordHash}, #{role}, #{realName}, #{phone}, #{isActive})
            
            -- 修改用户信息
            UPDATE sys_user
            SET username = #{username},
                role = #{role},
                real_name = #{realName},
                phone = #{phone},
                is_active = #{isActive}
            WHERE id = #{id}
            
            -- 修改用户密码
            UPDATE sys_user
            SET password_hash = #{passwordHash}
            WHERE id = #{id}
            
            -- 删除用户
            DELETE FROM sys_user WHERE id = #{id}
            
            -- ============================================================
            -- 患者信息表 - patient
            -- ============================================================
            
            -- 查询患者列表（分页）
            SELECT id, name, gender, age, phone, id_card, address, blood_type, height, weight, allergy_info, status, created_at, updated_at
            FROM patient
            WHERE 1=1
            <if test="name != null and name != ''">
                AND name LIKE CONCAT('%', #{name}, '%')
            </if>
            <if test="phone != null and phone != ''">
                AND phone = #{phone}
            </if>
            <if test="status != null and status != ''">
                AND status = #{status}
            </if>
            ORDER BY created_at DESC
            LIMIT #{offset}, #{pageSize}
            
            -- 查询患者总数
            SELECT COUNT(*)
            FROM patient
            WHERE 1=1
            <if test="name != null and name != ''">
                AND name LIKE CONCAT('%', #{name}, '%')
            </if>
            <if test="phone != null and phone != ''">
                AND phone = #{phone}
            </if>
            <if test="status != null and status != ''">
                AND status = #{status}
            </if>
            
            -- 根据ID查询患者详情
            SELECT id, name, gender, age, phone, id_card, address, blood_type, height, weight, allergy_info, status, created_by, created_at, updated_at
            FROM patient
            WHERE id = #{id}
            
            -- 新增患者
            INSERT INTO patient (name, gender, age, phone, id_card, address, blood_type, height, weight, allergy_info, status, created_by)
            VALUES (#{name}, #{gender}, #{age}, #{phone}, #{id_card}, #{address}, #{blood_type}, #{height}, #{weight}, #{allergy_info}, #{status}, #{createdBy})
            
            -- 修改患者信息
            UPDATE patient
            SET name = #{name},
                gender = #{gender},
                age = #{age},
                phone = #{phone},
                id_card = #{id_card},
                address = #{address},
                blood_type = #{blood_type},
                height = #{height},
                weight = #{weight},
                allergy_info = #{allergy_info},
                status = #{status}
            WHERE id = #{id}
            
            -- 删除患者
            DELETE FROM patient WHERE id = #{id}
            
            -- ============================================================
            -- 就诊记录表 - visit_record
            -- ============================================================
            
            -- 查询就诊记录列表（分页）
            SELECT vr.id, vr.patient_id, vr.doctor_id, vr.visit_date, vr.chief_complaint, vr.present_illness, vr.past_history, vr.allergy_history, vr.personal_history, vr.tongue_image, vr.pulse_image, vr.other_exams, vr.status, vr.created_at, vr.updated_at,
                   p.name AS patient_name, u.real_name AS doctor_name
            FROM visit_record vr
            LEFT JOIN patient p ON vr.patient_id = p.id
            LEFT JOIN sys_user u ON vr.doctor_id = u.id
            WHERE 1=1
            <if test="patientId != null">
                AND vr.patient_id = #{patientId}
            </if>
            <if test="doctorId != null">
                AND vr.doctor_id = #{doctorId}
            </if>
            <if test="status != null and status != ''">
                AND vr.status = #{status}
            </if>
            <if test="visitDateStart != null">
                AND vr.visit_date >= #{visitDateStart}
            </if>
            <if test="visitDateEnd != null">
                AND vr.visit_date <= #{visitDateEnd}
            </if>
            ORDER BY vr.visit_date DESC
            LIMIT #{offset}, #{pageSize}
            
            -- 查询就诊记录总数
            SELECT COUNT(*)
            FROM visit_record vr
            WHERE 1=1
            <if test="patientId != null">
                AND vr.patient_id = #{patientId}
            </if>
            <if test="doctorId != null">
                AND vr.doctor_id = #{doctorId}
            </if>
            <if test="status != null and status != ''">
                AND vr.status = #{status}
            </if>
            
            -- 根据ID查询就诊记录详情
            SELECT vr.id, vr.patient_id, vr.doctor_id, vr.visit_date, vr.chief_complaint, vr.present_illness, vr.past_history, vr.allergy_history, vr.personal_history, vr.tongue_image, vr.pulse_image, vr.other_exams, vr.status, vr.created_at, vr.updated_at,
                   p.name AS patient_name, u.real_name AS doctor_name
            FROM visit_record vr
            LEFT JOIN patient p ON vr.patient_id = p.id
            LEFT JOIN sys_user u ON vr.doctor_id = u.id
            WHERE vr.id = #{id}
            
            -- 新增就诊记录
            INSERT INTO visit_record (patient_id, doctor_id, visit_date, chief_complaint, present_illness, past_history, allergy_history, personal_history, tongue_image, pulse_image, other_exams, status)
            VALUES (#{patientId}, #{doctorId}, #{visitDate}, #{chiefComplaint}, #{presentIllness}, #{pastHistory}, #{allergyHistory}, #{personalHistory}, #{tongueImage}, #{pulseImage}, #{otherExams}, #{status})
            
            -- 修改就诊记录
            UPDATE visit_record
            SET chief_complaint = #{chiefComplaint},
                present_illness = #{presentIllness},
                past_history = #{pastHistory},
                allergy_history = #{allergyHistory},
                personal_history = #{personalHistory},
                tongue_image = #{tongueImage},
                pulse_image = #{pulseImage},
                other_exams = #{otherExams},
                status = #{status}
            WHERE id = #{id}
            
            -- 删除就诊记录
            DELETE FROM visit_record WHERE id = #{id}
            
        ]]>
    </database>
</sqlMap>